var sys=require('util'),fs = require('fs');
var fd = fs.openSync('tmp.ts','w+',undefined);
var buf = new Buffer('File write\n');
fs.writeSync(fd,buf,0,buf.length,0)
//function(err,written,buffer){
//		if(err) throw err;
//		sys.log(written+'bytes written');
//		};
fs.closeSync(fd);
