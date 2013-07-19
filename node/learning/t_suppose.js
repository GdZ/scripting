var suppose = require('suppose')
, fs = require('fs');

var prompt = '4\.2# ';
suppose('telnet',['171.71.47.71'])
.on(prompt).respond("reboot\n")
.on(prompt).respond('nothing\n')
.error(function(err){
   console.log("error: " + err.message);
})
.end(function(code){
   console.log("telnet abort " + code);
   mountnfs();
});
function mountnfs () {
   suppose('telnet',['171.71.47.71'])
   .debug(fs.createWriteStream('stboutput.log'))
   .on(prompt).respond("ls\n")
   .on(prompt).respond('mkdir host\n')
   .on(prompt).respond('mount -t nfs -o tcp,nolock 171.71.46.197:/home/herry/tmp/nfs/ISB8K-E /host\n')
   .on(prompt).respond('cd host\n')
   .on(prompt).respond('./start.sh\n')
   .on(prompt).respond('nothing\n')
   .error(function(err){
      console.log("error: " + err.message);
      setTimeout(function() {
         console.log("retrying mount nfs ");
         mountnfs();}, 2000);
      })
   .end(function(code){
      console.log("code : " + code);
   })

}
