// get list of proxy ip 

//It's crashing phantom 1.9 (git version) on linux. 


var page = require('webpage').create(),
url = 'http://spys.ru/free-proxy-list/CN/';
    /**
     * From PhantomJS documentation:
     * This callback is invoked when there is a JavaScript console. The callback may accept up to three arguments: 
     * the string for the message, the line number, and the source identifier.
*/

page.onConsoleMessage = function(msg) {
   console.log(msg);
};
page.open(url, function (status) {
   if (status !== 'success') {
      console.log('Unable to access network');
   } else {
      page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
         var results = page.evaluate(function() {
            var proxy = [];
            var proxyrows = $("tbody:eq(2)").find("tr:gt(2)"), i;
            console.log(proxyrows.length);
            for (i = 0; i < proxyrows.length - 1; i++) {
               //console.log(proxyrows[i]);
               //console.log( proxyrows[i].querySelectorAll("td"));
               //
               var tds = proxyrows[i].querySelectorAll("td");
               var fonts = tds[0].querySelectorAll("font");
               console.log("Result:  #" + fonts[0].innerText + " IP:Port " + fonts[1].innerText  );
               proxy.push(fonts[1].innerText);
            }
            return proxy;
         });
         console.log(results.join("\n"));
         console.log("exiting phantom ");
         phantom.exit();
      });
   };
});
