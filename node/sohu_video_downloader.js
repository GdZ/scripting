var http = require('follow-redirects').http;
//var http = require('http');
var util = require('util');
var URL = require('url'),fs=require('fs'),qs=require('querystring');

var async = require('async');

var url_super_mp4 = "http://data.vod.itc.cn/?new=/48/228/ZIluR8bu7eNUTmoNv1KPD6.mp4,http://data.vod.itc.cn/?new=/94/179/e0ZWLoKxTmSWcqaV92VNa5.mp4,http://data.vod.itc.cn/?new=/127/209/M0nv9NgZyI1L1Nio5092Y2.mp4,http://data.vod.itc.cn/?new=/45/20/OheETKB80eU6NX9c8Eqyo3.mp4,http://data.vod.itc.cn/?new=/151/125/fTgFxR7Nud9qgjpKUxnKa6.mp4,http://data.vod.itc.cn/?new=/205/34/LY4YFzf4Fwtp2u0Sc1Yfk6.mp4,http://data.vod.itc.cn/?new=/128/16/iHuIdkmaARTep82Bg7DCB.mp4,http://data.vod.itc.cn/?new=/98/214/hgGBWbLSqnMHctC5SaOEB5.mp4,http://data.vod.itc.cn/?new=/45/22/y9KEopCVKV8xWagmaQPJ97.mp4,http://data.vod.itc.cn/?new=/232/251/9I2JAamIHiOYxerAA4kdw1.mp4,http://data.vod.itc.cn/?new=/24/15/PP4k5nGtiDEi0rdhZ6cq05.mp4,http://data.vod.itc.cn/?new=/116/96/gYvlXUn6cDQmease94L1I2.mp4,http://data.vod.itc.cn/?new=/245/140/vSU8mbMDjxa2zmHkIjZUX6.mp4,http://data.vod.itc.cn/?new=/9/28/uZ0jM52sPOv5MN4NYpZjZ6.mp4,http://data.vod.itc.cn/?new=/27/63/oIgSCSLvPIeT7A0rHTwYP5.mp4,http://data.vod.itc.cn/?new=/65/25/DWUL0cjigOCeS8Vxm7fAg1.mp4,http://data.vod.itc.cn/?new=/37/207/qrOAPV0CHal7kBWmaFkt23.mp4,http://data.vod.itc.cn/?new=/76/35/9GaRK3xD4KtqjSrJr3zsk3.mp4,http://data.vod.itc.cn/?new=/26/245/t26GMvRD39F5HdP9VSzk75.mp4,http://data.vod.itc.cn/?new=/146/160/yWC1EYdxItC5s4b3hvpF44.mp4,http://data.vod.itc.cn/?new=/251/97/iej9ny3OeXSvrXuVZsOmC.mp4,http://data.vod.itc.cn/?new=/177/103/bZqVesz3NsCl7v6zZP6U44.mp4,http://data.vod.itc.cn/?new=/67/19/WMcZQLtDL9HVdCyZ7Rahe2.mp4,http://data.vod.itc.cn/?new=/162/47/v54cmLY2pHcMNeiG3xYFO1.mp4"


var media_file_list = url_super_mp4.split(',');

console.log(media_file_list);
var items = [];
function _change(list) {
  //var fd = fs.openSync("mylist.txt",'a+');
	for(var i=0;i<list.length;i++) {
		var filename = i.toString() + '.mp4';
		
		fs.appendFileSync("mylist.txt","file " + "'" + filename + "'" + "\r\n",null);
		items.push({url: list[i], fname: filename});
		//console.log("URL is " + myoptions.host + " path is: " + myoptions.path);
	}
	//fs.closeSync(fd);
}

_change(media_file_list);
console.log(items);
//async.eachSeries(items, download_one, function(err){
	//console.log(err);
//});
function download_one(item,callback) {
		var url = item.url;
		var fname = item.fname;
		var fd = fs.openSync(fname,'a+');
		var opts = URL.parse(url);
		http.get(opts,function(res) {
			console.log("Got response: " + res.statusCode);
			console.log('HEADERS: ' + JSON.stringify(res.headers));
			res.on('data',function(chunk) {
				fs.writeSync(fd,chunk,0,chunk.length,null);
			});
			res.on('end',function() {
				console.log(fd);
				fs.closeSync(fd);
			});
			res.on('close',function(err) {
				console.log(err);
				callback(err);
			});


		});
}

