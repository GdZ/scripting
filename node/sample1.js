var http = require('http');
var net = require('net');
var options = {
  host: '172.22.30.184',
  port: 80,
  path: '/index.html',
  method: 'GET'
};

cb1 = function(res) {
  console.log('STATUS: ' + res.statusCode);
  console.log('HTTPVersion: ' + res.httpVersion);
 // console.log('HEADERS: ' + JSON.stringify(res.headers));
  for (var header in res.headers) {
	var iValue = res.headers[header];
	console.log('HTTP Response header [' + header + ':' + iValue + '\]');
  };
//  console.log('HEADERS: ' + res.headers.date);
  //res.setEncoding('utf8');
  res.on('data', function (chunk) {
    console.log('BODY: ' + chunk);
  });
  res.on('end', function () { console.log('end of response'); });
  res.on('close',function () { console.log('close');});
};

var req = http.request(options, cb1);
req.on('error', function(e) {
  console.log('problem with request: ' + e.message);
});

// write data to request body
//req.write('data\n');
//req.write('data\n');
req.end();
