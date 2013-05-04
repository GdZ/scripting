var page = require('webpage').create();
//page.viewportSize = { width: 400, height : 400 };
page.onConsoleMessage = function(msg) {
   console.log("Phantom: " + msg);
};
// User-Agent is supported through page.settings
// iOS 6.0
//page.settings.userAgent = 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25';
//Android Tablet:
page.settings.userAgent = 'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Safari/535.19';
//iPad:
//page.settings.userAgent = 'Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B176 Safari/7534.48.3';
page.open('http://m.iqiyi.com/play.html?tvid=447406&vid=49b21ec3ef8f40e28283d8d83e879168',function(status) {
   if(status != 'success') {
      console.log("error to open the page");
   } else {
         var title = page.evaluate( function(){
            return document.title;
        });
         console.log('Title ' + title);

         page.evaluate(function() {

            console.log("evalutation ...")
            var videos = document.getElementsByTagName('video');
            for (var i = 0; i < videos.length; i++) { 
               var video_src = videos[i].getAttribute("src");
               console.log("video src: " + video_src);
               //var video_href = videos[i].getElementsByTagName('a')[0];
               //console.log("video link: " + video_href.getAttribute('href'));
            }

         });
         //console.log(page.content);
         //page.render('sohu.png');
         phantom.exit();
   }


});
