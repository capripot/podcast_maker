# Podcast Maker

Podcast Maker gives the ability to record an internet live streaming
and build an RSS feed compatible with iTunes

### Usage

Best way to use it is to schedule it with `crontab`

> crontab -e

And add `30 22 * * 1-5 /usr/bin/ruby 'podcast_maker.rb'`

### Dependencies

It's dependant to the great `mplayer` program which you can install with `apt-get` or `brew`

Debian/Ubuntu:

> apt-get install mplayer
> apt-get install lame

macOS:

> brew bundle

### Licence

Distributed under MIT licence

(c) May 2016 - Ronan Potage
