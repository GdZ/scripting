var page = require('webpage').create();
//page.viewportSize = { width: 400, height : 400 };
page.open('http://171.71.46.197/TNC/TNCTestSuite/testCase/css3Gradient/index.html',function(status) {
   if(status != 'success') {
      console.log("error to open the page");
   } else {
      var clipRect = page.evaluate(function() {
         var el = document.getElementById('p1');

         var clipRect = el.getBoundingClientRect();
      
         return clipRect;
      });
         console.log(clipRect.top, clipRect.left, clipRect.width, clipRect.height);
         page.clipRect = {
            top:    clipRect.top,
            left:   clipRect.left,
            width:  clipRect.width,
            //height: clipRect.height
            height: 300
         };

      page.render('gradient.png');
   }
   phantom.exit();
});
