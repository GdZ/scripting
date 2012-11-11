
function route(handle,pathname,response,postdata,query) {
   console.log("About to route a request for " + pathname);
   if(pathname.indexOf("VR5SIF") >=0 ) {
      console.log("proxy SIF request ... ");
      var p2 = pathname.substr(pathname.indexOf(pathname.split('/')[2]));
      if(query) {p2 = p2 + '?' + query};
      handle["/VR5SIF"](response,p2,postdata);
   } else if (typeof handle[pathname] === 'function') {
      handle[pathname](response,query);
   } else {
      handle["static"](response,pathname);
   }
}

exports.route = route;
