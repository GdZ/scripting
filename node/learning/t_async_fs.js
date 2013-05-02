var util=require('util'),fs = require('fs');
var fd = fs.open('tmp.ts','w+','0666',function(err,fd) {
   if(err) throw err;
   var buf = new Buffer('File write\n');
   fs.write(fd,buf,0,buf.length,null,function(err,written,buf){
      if(err) throw err;
      //util.log("LOG " + written+' bytes written');
      //console.log("LOG " + written+' bytes written');
      fs.close(fd);
   });
});

var walk_dir = function(dir, done) {
  var results = [];
  fs.readdir(dir, function(err, list) {
    if (err) return done(err);
    var pending = list.length;
    if (!pending) return done(null, results);
    list.forEach(function(file) {
      file = dir + '/' + file;
      fs.stat(file, function(err, stat) {
        if (stat && stat.isDirectory()) {
         results = results.concat(file);
          walk_dir(file, function(err, res) {
            results = results.concat(res);
            if (!--pending) done(null, results);
          });
        } else {
          if (!--pending) done(null, results);
        }
      });
    });
  });
};

walk_dir("./movies/videos", function(any, res) { console.log(res)});
