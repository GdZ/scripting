var http = require('http');
var net = require('net');
var options = {
host: 't.live.cntv.cn',
      port: 80,
      path: '/m3u8/cctv-news.m3u8',
      method: 'GET'
};
var pids = new Array();
var myAgent = new http.Agent({maxSockets: 1});
//HTTP data body call back
cb_data = function (chunk) {

	console.log('BODY: ' + chunk);
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
		//console.log('M3U8 file line [' + lines[i] );
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
		//TODO: always pick up the first bw
		pids[0].segments = segments;
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
	var type = res.headers['content-type']; 
	//res.setEncoding('utf8');
	res.on('data',cb_data);
	res.on('end', function() {
			after_m3u8();
			console.log('End of response HTTP2');
			});
	res.on('close',function () { console.log('close');});
};
//2nd HTTP Client, get 2nd M3U8 and TS files 
cb2 = function(res) {
	console.log('STATUS: ' + res.statusCode);
	console.log('HTTPVersion: ' + res.httpVersion);
	for (var header in res.headers) {
		var iValue = res.headers[header];
		console.log('HTTP Response header [' + header + ':' + iValue + '\]');
	};
	//res.setEncoding('utf8');
	res.on('data',cb_data);
	res.on('end', function () { 
			get_ts_file();
			console.log('End of response HTTP2'); 
			});
	res.on('close',function () { console.log('close');});
};
fs = require('fs');
var index_ts_files = 0;
cb3 = function(res) {
	console.log('STATUS: ' + res.statusCode);
	console.log('HTTPVersion: ' + res.httpVersion);
	for (var header in res.headers) {
		var iValue = res.headers[header];
		console.log('HTTP Response header [' + header + ':' + iValue + '\]');
	};
	index_ts_files ++;
	//res.setEncoding('utf8');
	res.on('data',cb_ts_data);
	res.on('end', function () { 
			console.log('End of response HTTP2'); 
			});
	res.on('close',function () { console.log('close');});
};
cb_ts_data = function(chunk) {
	console.log('Receiving data length '+ chunk.length);
	//var buffer = [];
	//var bodyLen = 0;
	//buffer.push(chunk);
	//bodyLen += chunk.length;
	var filename = index_ts_files + '.ts';
	var fd = fs.openSync(filename,'a+',undefined);
	fs.writeSync(fd,chunk,0,chunk.length,0,function(err,written,buffer){
			if(err) throw err;
			console.log(written+'bytes written');
			});
	fs.closeSync(fd);

	//ws = fs.createWriteStream(index_ts_files+'.ts');
	//ws.write(chunk);

}
var req = http.request(options, cb1);
req.on('error', function(e) {
		console.log('problem with request: ' + e.message);
		});
req.end();

// write data to request body
//req.write('data\n');
//req.write('data\n');
after_m3u8 = function() {

	//choose one bandwitdh
	var url = require('url'); 
	var options2 = url.parse(pids[0].pl);
	console.log(pids[0].pl);
	//options2.method = 'GET';
	console.log('dump options: host ' + options2.host +' path: ' + options2.path + ' method: ' + options2.method);
	pids[0].host = options2.host;
	options2.agent = myAgent;
	var req2 = http.request(options2,cb2);
	console.log('HERRY1');
	req2.on('error', function(e) {
			console.log('problem with request2: ' + e.message);
			});
	req2.end();
};


get_ts_file = function() {

	//choose one media uri according with bandwitdh
	var url = require('url'); 
	for (var i=0; i< pids[0].segments.length; i++) {
		var options2 = url.parse(pids[0].segments[i]);
		console.log(options2.path);
		//options2.method = 'GET';
		options2.host = pids[0].host;
		options2.agent = myAgent;
		console.log('dump options: host ' + options2.host +' path: ' + options2.path + ' method: ' + options2.method);
		var req2 = http.request(options2,cb3);
		console.log('HERRY2');
		req2.on('error', function(e) {
				console.log('problem with request2: ' + e.message);
				});
		req2.end();}
};
