var o = "51*8*51*51*51*24*51*38*51*51*1*40*8*38*51*1*11*24*1*42*60*11*51*1*1*30*30*42*8*30*30*51*38*60*30*24*28*22*4*28*42*51*24*4*60*40*32*42*4*22*22*1*51*4*1*51*8*25*28*60*24*38*51*40*32*51*";
var d = "0300080F08513F05985B29055EEB3EE0F2E8C4-CB08-217B-4450-503DC28F0170"
var o_l = o.split('*');
var d_l = d.split("");
console.log(o_l.length);
console.log(d_l.length);
var Mapping = {};
for(var i=0; i< o_l.length-1 ; i++) {
   Mapping[o_l[i]] = d_l[i];
}
console.log(Mapping);
var flv = "51*8*51*51*51*60*51*38*51*51*1*40*8*30*25*28*11*25*1*42*60*11*51*1*1*30*30*42*8*30*30*51*38*60*30*24*28*22*4*28*42*51*24*4*60*40*32*42*4*22*22*1*51*4*1*51*8*25*28*60*24*38*51*40*32*51*"
var flv_l = flv.split('*');
var flv_o = [];
for(var j=0; j< flv_l.length-1 ; j++) {
   flv_o.push(Mapping[flv_l[j]]);
}

console.log(flv_o.join(""));
//https://github.com/cscscheng/Raspberry-Pi-NetworkPlayer/blob/master/youku.py
//http://userscripts.org/scripts/review/131926
//http://stackoverflow.com/questions/1527803/generating-random-numbers-in-javascript-in-a-specific-range
function oetRandom(min, max) {
   return Math.random() * (max -min) + min;
};
function getRandomInt(min, max) {
   return Math.floor(Math.random() * (max - min + 1)) + min;
}

function sid() {
//var sid=new Date().getTime() + "" + (1000 + new Date().getMilliseconds()) + "" + (parseInt(Math.random() * 9000,10) + 1000);

   var now = new Date().getTime();
   var r1 = getRandomInt(1000,1998);
   var r2 = getRandomInt(1000,9999);
   var output = String(now) + String(r1) + String(r2);
   return output;
}

function getFileId(str,seed) {
   var mixstr = getMixString(seed);
   var ids = str.split('*');
   var fileid = "";
   var idx = 0;
   for(var i = 0 ; i < ids.length-1; i++) {
      idx = parseInt(ids[i],10);
      fileid += mixstr.charAt(idx);
   }
   return fileid;
};

console.log(sid());

function getMixString(seed) {

   var o = "";
   var source = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890";
   var len = source.length;
   for(var i= 0; i < len; ++i) {
      seed = (seed * 211 + 30031) % 65536;
      var index = seed/ 65536 * source.length;
      var c = source.charAt(index);
      o += c;
      source = source.replace(c+'','');
   }
   return o;
}
console.log(getMixString(7401));
console.log(getFileId(o,7401));
console.log("0300080F08513F05985B29055EEB3EE0F2E8C4-CB08-217B-4450-503DC28F0170");

var youku_f_link = "http://f.youku.com/player/getFlvPath/sid/";

var video_part_num = 8;

var stream_t = 'mp4';

var fullfids = getFileId(o,7401);

var key = "?start=69&K=332598cdf94c47ea261cfd95&hd=1&myp=0&ts=400&ymovie=1&ypp=0"

var request_url = youku_f_link + sid() + '_' + ('0' + video_part_num).substring(-2) + '/st/' + stream_t + '/fileid/' + fullfids + key;
console.log(request_url);
