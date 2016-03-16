# Setting up Weechat

Used this quickstart guide: http://weechat.org/files/doc/devel/weechat_quickstart.en.html


## Install

brew install weechat --with-perl --with-python


## SSL certificate error problem

* See item 6.1 at http://weechat.org/files/doc/weechat_faq.en.html
* Needed to install certs from here: https://gist.github.com/1stvamp/2158128
    * NOTE: As of El Capitan, you need to follow the instructions in this comment:
      https://gist.github.com/1stvamp/2158128#gistcomment-1573222

Then ran:
/set weechat.network.gnutls_ca_file "~/.weechat/certs/ca-bundle.crt"



## misc
* use SASL authentication
* use "/set irc.server.freenode.*" to see all freenode settings
* use "/nick eh_eff" to use "secondary" nick
* /set weechat.bar.title.color_bg black
* /set weechat.bar.status.color_bg black
* filtering out join/leaves: "/filter add irc_smart * irc_smart_filter *"
    * via http://wiki.xkcd.com/irc/Hide_join_part_messages


## controls
* /help
* /quit
* /join <channel>
* /close
* Alt + arrow keys to switch buffers
* pgup/down to scroll text in buffer


## plugins
* /script install buffers.pl
* /script autoload buffers.pl
* /script install iset.pl
* /script autoload iset.pl
* https://github.com/sindresorhus/weechat-notification-center
