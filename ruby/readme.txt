Introduction:
    http-wmt-get is used to send http request to WindowMediaService, simulate Windows Media Player.

Example:
    ./http-wmt-get -u http://wmt-os.auto-sj5.com:8800/snowboard_100.wmv  -S 3.0 -D 10 -V
    ./http-wmt-get -u http://wmt.auto-sj5.com/snowboard_100.wmv
    
    or add ruby before the program, when ruby in not under /usr/bin
    
    ruby http-wmt-get -u http://wmt.auto-sj5.com/snowboard_100.wmv

Features:
    1)      VOD + Live (http)
    2)      WMV, asf, asx files are supported.
    3)      Fast-cache, Fast-start
    4)      SR redirect is suppoted
    5)      Log stats report to server

Location:
U4-LNX-2:/home/hailwang/http-wmt-get
Usage:
    ./http-wmt-get -u http://wmt.auto-sj5.com/snowboard_100.wmv  -S 3.0 -V
    
    -V verbose
    -u URL
    -S speed
    -D duration, -D 10 means abort when connection time is > 10second

Not supported:

1) asx(rtsp)
2) MBR, select stream

Issues:
1) Some Logstat fields are hardcoded


Installation:
    For Redhat:
    #yum install ruby ruby-devel ruby-docs ruby-ri ruby-irb ruby-rdoc
    #gem install curb
    #gem install xml-simple
Development tips:
    Ruby, Gem are required to run this tool.
    Ruby packages: curb, simple-xml

