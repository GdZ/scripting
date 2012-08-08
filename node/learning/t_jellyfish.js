var jellyfish = require('jellyfish'), assert = require('assert');
//Firefox 12 doesn't work on Ubuntu. It can be openned but can't browser to web site.
//Chrome is fine. 
//var browser = jellyfish.createFirefox();
var browser = jellyfish.createChrome();
browser.on('result', function(res) {
   console.log(browser.name + ' : '+browser.tid + ' - \x1b[33m%s\x1b[0m', JSON.stringify(res));
});
browser.go("http://www.jelly.io")
.js("document.title", function(o) {
   assert.equal(o.result, "Jelly.io: Jellyfish Home")
})
.jsurl("http://jelly.io/test.js", function(o) { 
   assert.equal(o.result, 
                "alerted: Jellyfish remote file loaded successfully!")
                browser.stop(function() {
                   setTimeout(process.exit(), 2000);
                })
});
