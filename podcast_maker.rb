#! /usr/bin/ruby
# (c) 2016-05 Ronan Potage

streaming_url = "http://streaming18.hstbr.net:8094/live"
path = "/tmp/" # where to save the podcast files
filename = "podcast_maker_#{Time.new.strftime("%Y-%m-%d_%Hh%M")}.wav"
lenght = "40:00" # how long is the live show in ((hh:)mm:)ss

@log_file = "/var/log/podcast_maker.log"

mplayer_cmd = "mplayer #{streaming_url} -vc null -vo null -ao pcm:waveheader:file=#{path}/#{filename} -endpos #{lenght} &>> #{@log_file}"

def log(string)
  IO.write(@log_file, "[#{Time.now}] #{string}\n", mode: "a")
end

log "Start recording"
log mplayer_cmd

`#{mplayer_cmd}`

log "Transcode to MP3 with Lame"
`lame --preset standard #{path}/#{filename} &>> #{@log_file}`

log "remove wav original"
`rm #{path}/#{filename} 2>&1 &>> #{@log_file}`

log "rebuild RSS"
`podcast_maker_rss.rb 2>&1 &>> #{@log_file}`

log "Done!"
