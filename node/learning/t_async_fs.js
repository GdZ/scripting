var util=require('util'),fs = require('fs');
var fd = fs.open('tmp.ts','w+','0666',function(err,fd) {
   if(err) throw err;
   var buf = new Buffer('File write\n');
   fs.write(fd,buf,0,buf.length,null,function(err,written,buf){
      if(err) throw err;
      util.log("LOG " + written+' bytes written');
      console.log("LOG " + written+' bytes written');
      fs.close(fd);
   });
});
