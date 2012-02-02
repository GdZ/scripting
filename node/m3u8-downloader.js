var http = require('http');
var net = require('net');
var options = {
host: 't.live.cntv.cn',
      port: 80,
      path: '/m3u8/cctv-news.m3u8',
      method: 'GET'
};
function type(obj){
	return Object.prototype.toString.call(obj).match(/^\[object (.*)\]$/)[1]
};
var pids = new Array();

//HTTP data body call back
cb_data = function (chunk) {

	console.log('BODY: ' + chunk);
	console.log('chunk type : ' + type(chunk)); 
	var buffer = [];
	var bodyLen = 0;
	buffer.push(chunk);
	bodyLen += chunk.length;
	var lines = chunk.toString().split("\n");
	var isM3U8 = false;
	var patten1 = /#EXT-X-STREAM-INF:PROGRAM-ID=(\d+), BANDWIDTH=(\d+)/;
	//3.3.10.  EXT-X-STREAM-INF

	//   The EXT-X-STREAM-INF tag identifies a media URI as a Playlist file
	//   containing a multimedia presentation and provides information about
	//   that presentation.  It applies only to the URI that follows it.  Its
	//   format is:
	//
	//   #EXT-X-STREAM-INF:<attribute-list>
	//   <URI>
	var patten2 = /#EXT-X-TARGETDURATION:(\d+)/;
	//RFC: 3.3.2.  EXT-X-TARGETDURATION

	//  The EXT-X-TARGETDURATION tag specifies the maximum media segment
	//  duration.  The EXTINF duration of each media segment in the Playlist
	//  file MUST be less than or equal to the target duration.  This tag
	//  MUST appear once in the Playlist file.  It applies to the entire
	//  Playlist file.  Its format is:

	//  #EXT-X-TARGETDURATION:<s>
	var patten3 = /#EXTINF:(\d+),/;
	var patten4 = /#EXT-X-MEDIA-SEQUENCE:(\d+)/;
	//  Each media URI in a Playlist has a unique integer sequence number.
	//  The sequence number of a URI is equal to the sequence number of the
	//  URI that preceded it plus one.  The EXT-X-MEDIA-SEQUENCE tag
	//  indicates the sequence number of the first URI that appears in a
	//  Playlist file.  Its format is:

	//  #EXT-X-MEDIA-SEQUENCE:<number>


	//The initial minimum reload delay is the duration of the last media
	//   segment in the Playlist.  Media segment duration is specified by the
	//   EXTINF tag.
	var segments = new Array();
	var last_duration = 10;
	var cur_seq = 0;
	for ( var i=0;i<lines.length; i++ ) {
		console.log('M3U8 file line [' + lines[i] );
		if(lines[i] === '#EXTM3U') {
			console.log('Got firstline of M3U8');
			isM3U8 = true;
		}
		var pid_bw = patten1.exec(lines[i]);
		var maxduration = patten2.exec(lines[i]);
		var inf = patten3.exec(lines[i]);
		var seq = patten4.exec(lines[i]);
		//pid_bw[0] is the whole matched string
		if(pid_bw != null) {
			console.log('Show pid and bandwith' + pid_bw[1] + 'bandwith' + pid_bw[2]);
			var pid = new Object();
			pid.id = pid_bw[1];
			pid.bw = pid_bw[2];
			pid.pl = lines[i+1];
			pids.push(pid);
		}
		if(maxduration != null) {

		}
		if(seq != null) {
			cur_seq = seq[1];
			//compare seq with existing seq
		}
		if(inf != null) {
			last_duration = inf[1];
			segments.push(lines[i+1]);
			cur_seq ++;
		}

	};
	if(segments.length > 0) {

		pids[0].segments = segments;
		get_ts_file();
	}
};

//HTTP Response Callback
cb1 = function(res) {
	console.log('STATUS: ' + res.statusCode);
	console.log('HTTPVersion: ' + res.httpVersion);
	for (var header in res.headers) {
		var iValue = res.headers[header];
		console.log('HTTP Response header [' + header + ':' + iValue + '\]');
	};
	//res.setEncoding('utf8');
	res.on('data',cb_data);
	res.on('end', function () { console.log('end of response HTTP1');
			after_m3u8();
			});
	res.on('close',function () { console.log('close');});
};
cb2 = function(res) {
	console.log('STATUS: ' + res.statusCode);
	console.log('HTTPVersion: ' + res.httpVersion);
	for (var header in res.headers) {
		var iValue = res.headers[header];
		console.log('HTTP Response header [' + header + ':' + iValue + '\]');
	};
	//res.setEncoding('utf8');
	res.on('data',cb_data);
	res.on('end', function () { console.log('end of response HTTP2'); 
		 });
	res.on('close',function () { console.log('close');});
};
cb_data2 = function(chunk) {
	console.log('Receiving data');
}
var req = http.request(options, cb1);
req.on('error', function(e) {
		console.log('problem with request: ' + e.message);
		});

// write data to request body
//req.write('data\n');
//req.write('data\n');
var req2;
after_m3u8 = function() {

	//choose one bandwitdh
	var url = require('url'); 
	//var http2 = require('http');
	var options2 = url.parse(pids[0].pl);
	console.log(pids[0].pl);
	//options2.method = 'GET';
	console.log('dump options: host ' + options2.host +'path: ' + options2.path + 'method: ' + options2.method);
	pids[0].host = options2.host;
	req2 = http.request(options2,cb2);
	//req2.on('response',cb2);

	console.log('HERRY');
	req2.on('error', function(e) {
			console.log('problem with request2: ' + e.message);
			});
	req2.end();
};


get_ts_file = function() {

	//choose one media uri according with bandwitdh
	var url = require('url'); 
	//var http2 = require('http');
	var options2 = url.parse(pids[0].segments[0]);
	console.log(pids[0].segments[0]);
	//options2.method = 'GET';
	//options2.host = pids[0].host;
	console.log('dump options: host ' + options2.host +'path: ' + options2.path + 'method: ' + options2.method);
	//req2 = http.request(options2,cb2);
	//req2.on('response',cb2);

	console.log('HERRY');
	req2.on('error', function(e) {
			console.log('problem with request2: ' + e.message);
			});
	req2.end();
};
req.end();
