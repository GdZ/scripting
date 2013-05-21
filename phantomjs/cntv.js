var page = require('webpage').create();
//page.viewportSize = { width: 400, height : 400 };
page.onConsoleMessage = function(msg) {
   console.log("Phantom: " + msg);
};
// User-Agent is supported through page.settings
// iOS 6.0
//page.settings.userAgent = 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25';
//Android Tablet:
//page.settings.userAgent = 'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Safari/535.19';
//iPad:
page.settings.userAgent = 'Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B176 Safari/7534.48.3';
var url = 'http://tv.cntv.cn/live/cctv1';
page.open(url,function(status) {
   if(status != 'success') {
      console.log("error to open the page");
   } else {
      page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {

         page.evaluate(function() {
            var m_box_list = $(".m_box");
            //console.log(m_box_list);
            for (var i = 0; i < m_box_list.length; i++) { 
                  
               var tvlink = m_box_list[i].getElementsByTagName('a')[0].getAttribute('href');
               var tvname = m_box_list[i].getElementsByTagName('a')[0].innerHTML;
               console.log("TVStation Name " + tvname + " Link " + tvlink);
            }

         });
         console.log(page.content);
         phantom.exit();
   });
   }


});
