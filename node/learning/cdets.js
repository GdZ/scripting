var http = require('http');
var net = require('net');
var xml2js = require('xml2js');
var parser = new xml2js.Parser();
//var parser = new xml2js.Parser({ignoreAttrs:true});
var util = require('util');
var options = {
   host: 'cdetsng.cisco.com',
   port: 80,
   path: '/wsapi/2.1/api/bug/CSCua00003',
   method: 'GET',
   auth: 'hailwang:1D4D9A38605719369385100888C454B2B'
};
var output_xml = "";

cb1 = function(res) {
   console.log('STATUS: ' + res.statusCode);
   console.log('HTTPVersion: ' + res.httpVersion);
   for (var header in res.headers) {
      var iValue = res.headers[header];
      console.log('HTTP Response header [' + header + ':' + iValue + '\]');
   };
   //res.setEncoding('utf8');
   res.on('data', function (chunk) {
      //console.log('BODY: ' + chunk);
      output_xml = output_xml + chunk;
   });
   res.on('end', function () {
      //console.log('end of response' + output_xml); 
      parser.parseString(output_xml,function(err,result) { 
           var field = result['ns2:Defect']['ns2:Field'];
           //console.log(util.inspect(result,true,null));
           //console.log(util.inspect(field,true,null));
           //console.log(util.inspect(result,true,1));
           //console.log(util.inspect(result,true,2));
           for(var i=0; i<field.length; i++) {
               console.log( " " + field[i]['@'].name + " : " + field[i]['#']);
            } 
      });
   });
   res.on('close',function () { console.log('close');});
};

var req = http.request(options, cb1);
req.on('error', function(e) {
   console.log('problem with request: ' + e.message);
});

req.end();
