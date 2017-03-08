#! /usr/bin/ruby
# (c) 2016-05 Ronan Potage

require "date"

base_url = "http://show_name.com/"
path = "/tmp/" # where to save RSS file
rss_file = "show_name.rss"

file_list = `ls -1 -t #{path}/*.mp3`.split("\n")
items = []
last_date = nil

file_list.each do |file|

  file_name = file.split("/").last
  url = base_url+file_name

  match_date = /([0-9]{4}-[0-9]{2}-[0-9]{2})_([0-9]{2}h[0-9]{2})/.match file_name

  date = DateTime.parse(match_date[1]+" "+match_date[2]+" -0400")

  last_date = date unless last_date

  items << '<item>
    <title>Cover Hits do '+date.strftime("%d/%m/%Y")+' com Fran - UniFM </title>
    <link>https://www.facebook.com/UniFM/</link>
    <guid>'+url+'</guid>
    <description></description>
    <enclosure url="'+url+'" length="'+File.new(file).size.to_s+'" type="audio/mpeg"/>
    <category>Radio</category>
    <pubDate>'+date.rfc2822+'</pubDate>
    <itunes:author>Fran Catozzo</itunes:author>
    <itunes:explicit>No</itunes:explicit>
    <itunes:subtitle></itunes:subtitle>
    <itunes:summary></itunes:summary>
    <itunes:duration>00:30:00</itunes:duration>
    <itunes:keywords>UniFM, CoverHits, Covers, Hits, Radio, Universitario</itunes:keywords>
</item>'

end

description = "The best music que cover com Fran Catozzo UniFM 94.5 em Curitiba, PR, Brazil"

content = '<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">

  <channel>

    <title>CoverHits com Fran Catozzo - Radio UniFM</title>
    <description>'+description+'</description>
    <link>https://www.facebook.com/UniFM/</link>
    <language>pt-BR</language>
    <copyright>UniFM 2016</copyright>
    <lastBuildDate>'+last_date.rfc2822+'</lastBuildDate>
    <pubDate>'+DateTime.now.rfc2822+'</pubDate>
    <docs>http://blogs.law.harvard.edu/tech/rss</docs>
    <webMaster>webmaster@capripot.fr</webMaster>

    <itunes:author>Fran Catozzo</itunes:author>
    <itunes:subtitle>'+description+'</itunes:subtitle>
    <itunes:summary>'+description+'</itunes:summary>

    <itunes:owner>
      <itunes:name>Franceslly Catozzo</itunes:name>
      <itunes:email>frany_zzo@hotmail.com</itunes:email>
    </itunes:owner>

    <itunes:explicit>No</itunes:explicit>

    <itunes:image href="'+base_url+'/img/unifm.png" />

    <itunes:category text="Radio">
      <itunes:category text="Music"/>
    </itunes:category>
'+items.join("\n")+'
  </channel>

</rss>'

puts "RSS feed built!" if IO.write path+"/"+rss_file, content, mode: "w"
