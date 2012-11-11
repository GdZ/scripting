var readFile = require("fs").readFile;
var http = require('http');
var querystring = require("querystring");
var exec = require("child_process").exec;

function start(response,postdata) {
   static(response,'/index.html');
}
function sif(res,p2,post) {
   var method = "GET";
   if(post) method = "POST";
   var req = "/VR5SIF/" + p2;
   var options = {
      host: sif_server,
      //host: 'ss-auto-centos-9.cisco.com',
      port: 8080,
      path: req,
      method: method,
   };
   if(post) {
      options.headers = {'Content-Type': 'application/x-www-form-urlencoded',
         'Content-Length': post.length,
      }
   }
   console.log("Request handler 'SIF' was called.");
   console.log(post);
   console.log(p2);
   console.log(options);
   console.log("sending request to sif");
   var req = http.request(options, function(response) {
      var output = '';
      response.setEncoding('utf8');
      response.on('data', function (chunk) {
         output = output + chunk;
         console.log("data : " + output);
      });
      response.on('end', function () {
         console.log('end of response' + output); 
         res.writeHead(200,{"Content-Type":"application/json;charset=UTF-8"});
         res.write(output);
         res.end();
      });
      response.on('close',function () { console.log('close');});
   });
   req.on('error', function(e) {
      console.log('problem with request: ' + e.message);
      res.writeHead(500,{"Content-Type":"text/plain"});
      res.write("Bad TIMS request");
      res.end();
   });
   if(post) {req.write(post)};
   req.end();

}
//Set SIF server
function setting(response,postdata) {
   console.log("Request handler 'setting' was called.");
   console.log("using sif server : " + querystring.parse(postdata).sifserver);
   sif_server = querystring.parse(postdata).sifserver;
   response.writeHead(200, {"Content-Type": "text/html"});
   response.write(sif_server);
   response.end();
}

function cmd(response,postdata) {
   console.log("Request handler 'cmd' was called.");
   //var shell_cmd = postdata.text;
   var shell_cmd = querystring.parse(postdata).cmd_str;
   console.log(postdata);
   exec(shell_cmd,function (error, stdout, stderr){
      response.writeHead(200, {"Content-Type": "text/plain"});
      response.write(stdout);
      response.end();
   });
}
//TODO
function upload(response,postdata) {
   console.log("Request handler 'upload' was called.");
   response.writeHead(200, {"Content-Type": "text/plain"});
   response.write("Herry Said: " + querystring.parse(postdata).text);
   response.end();
}
function extname (path) {
   var index = path.lastIndexOf(".");
   return index < 0 ? "" : path.substring(index);
}
//access static files
function static(response,filename) {
   filename = filename.substr(1);
   var content_type = mime.lookupExtension(extname(filename));
   console.log("Loading " + filename + "...");
   readFile(filename,function(err,data){
      if (err) {
         console.log("Error loadind file " + filename);
         response.writeHead(404, {"Content-Type": "text/plain"});
         response.write("Bad 404 Not Found");
         response.end();
         console.log("No request handler found for " + filename);
      }
      else {
         body = data;
         headers = { "Content-Type": content_type
            , "Content-Length": body.length
         };
         response.writeHead(200,headers);
         response.write(body)
         response.end();
      }
   });

}
var mime = {
   lookupExtension : function(ext,fallback) {
      return mime.TYPES[ext.toLowerCase()] || fallback || 'application/octet-stream';
   },

   TYPES : { ".3gp"   : "video/3gpp"
      , ".a"     : "application/octet-stream"
      , ".ai"    : "application/postscript"
      , ".aif"   : "audio/x-aiff"
      , ".aiff"  : "audio/x-aiff"
      , ".asc"   : "application/pgp-signature"
      , ".asf"   : "video/x-ms-asf"
      , ".asm"   : "text/x-asm"
      , ".asx"   : "video/x-ms-asf"
      , ".atom"  : "application/atom+xml"
      , ".au"    : "audio/basic"
      , ".avi"   : "video/x-msvideo"
      , ".bat"   : "application/x-msdownload"
      , ".bin"   : "application/octet-stream"
      , ".bmp"   : "image/bmp"
      , ".bz2"   : "application/x-bzip2"
      , ".c"     : "text/x-c"
      , ".cab"   : "application/vnd.ms-cab-compressed"
      , ".cc"    : "text/x-c"
      , ".chm"   : "application/vnd.ms-htmlhelp"
      , ".class"   : "application/octet-stream"
      , ".com"   : "application/x-msdownload"
      , ".conf"  : "text/plain"
      , ".cpp"   : "text/x-c"
      , ".crt"   : "application/x-x509-ca-cert"
      , ".css"   : "text/css"
      , ".csv"   : "text/csv"
      , ".cxx"   : "text/x-c"
      , ".deb"   : "application/x-debian-package"
      , ".der"   : "application/x-x509-ca-cert"
      , ".diff"  : "text/x-diff"
      , ".djv"   : "image/vnd.djvu"
      , ".djvu"  : "image/vnd.djvu"
      , ".dll"   : "application/x-msdownload"
      , ".dmg"   : "application/octet-stream"
      , ".doc"   : "application/msword"
      , ".dot"   : "application/msword"
      , ".dtd"   : "application/xml-dtd"
      , ".dvi"   : "application/x-dvi"
      , ".ear"   : "application/java-archive"
      , ".eml"   : "message/rfc822"
      , ".eps"   : "application/postscript"
      , ".exe"   : "application/x-msdownload"
      , ".f"     : "text/x-fortran"
      , ".f77"   : "text/x-fortran"
      , ".f90"   : "text/x-fortran"
      , ".flv"   : "video/x-flv"
      , ".for"   : "text/x-fortran"
      , ".gem"   : "application/octet-stream"
      , ".gemspec" : "text/x-script.ruby"
      , ".gif"   : "image/gif"
      , ".gz"    : "application/x-gzip"
      , ".h"     : "text/x-c"
      , ".hh"    : "text/x-c"
      , ".htm"   : "text/html"
      , ".html"  : "text/html"
      , ".ico"   : "image/vnd.microsoft.icon"
      , ".ics"   : "text/calendar"
      , ".ifb"   : "text/calendar"
      , ".iso"   : "application/octet-stream"
      , ".jar"   : "application/java-archive"
      , ".java"  : "text/x-java-source"
      , ".jnlp"  : "application/x-java-jnlp-file"
      , ".jpeg"  : "image/jpeg"
      , ".jpg"   : "image/jpeg"
      , ".js"    : "application/javascript"
      , ".json"  : "application/json"
      , ".log"   : "text/plain"
      , ".m3u"   : "audio/x-mpegurl"
      , ".m4v"   : "video/mp4"
      , ".man"   : "text/troff"
      , ".mathml"  : "application/mathml+xml"
      , ".mbox"  : "application/mbox"
      , ".mdoc"  : "text/troff"
      , ".me"    : "text/troff"
      , ".mid"   : "audio/midi"
      , ".midi"  : "audio/midi"
      , ".mime"  : "message/rfc822"
      , ".mml"   : "application/mathml+xml"
      , ".mng"   : "video/x-mng"
      , ".mov"   : "video/quicktime"
      , ".mp3"   : "audio/mpeg"
      , ".mp4"   : "video/mp4"
      , ".mp4v"  : "video/mp4"
      , ".mpeg"  : "video/mpeg"
      , ".mpg"   : "video/mpeg"
      , ".ms"    : "text/troff"
      , ".msi"   : "application/x-msdownload"
      , ".odp"   : "application/vnd.oasis.opendocument.presentation"
      , ".ods"   : "application/vnd.oasis.opendocument.spreadsheet"
      , ".odt"   : "application/vnd.oasis.opendocument.text"
      , ".ogg"   : "application/ogg"
      , ".p"     : "text/x-pascal"
      , ".pas"   : "text/x-pascal"
      , ".pbm"   : "image/x-portable-bitmap"
      , ".pdf"   : "application/pdf"
      , ".pem"   : "application/x-x509-ca-cert"
      , ".pgm"   : "image/x-portable-graymap"
      , ".pgp"   : "application/pgp-encrypted"
      , ".pkg"   : "application/octet-stream"
      , ".pl"    : "text/x-script.perl"
      , ".pm"    : "text/x-script.perl-module"
      , ".png"   : "image/png"
      , ".pnm"   : "image/x-portable-anymap"
      , ".ppm"   : "image/x-portable-pixmap"
      , ".pps"   : "application/vnd.ms-powerpoint"
      , ".ppt"   : "application/vnd.ms-powerpoint"
      , ".ps"    : "application/postscript"
      , ".psd"   : "image/vnd.adobe.photoshop"
      , ".py"    : "text/x-script.python"
      , ".qt"    : "video/quicktime"
      , ".ra"    : "audio/x-pn-realaudio"
      , ".rake"  : "text/x-script.ruby"
      , ".ram"   : "audio/x-pn-realaudio"
      , ".rar"   : "application/x-rar-compressed"
      , ".rb"    : "text/x-script.ruby"
      , ".rdf"   : "application/rdf+xml"
      , ".roff"  : "text/troff"
      , ".rpm"   : "application/x-redhat-package-manager"
      , ".rss"   : "application/rss+xml"
      , ".rtf"   : "application/rtf"
      , ".ru"    : "text/x-script.ruby"
      , ".s"     : "text/x-asm"
      , ".sgm"   : "text/sgml"
      , ".sgml"  : "text/sgml"
      , ".sh"    : "application/x-sh"
      , ".sig"   : "application/pgp-signature"
      , ".snd"   : "audio/basic"
      , ".so"    : "application/octet-stream"
      , ".svg"   : "image/svg+xml"
      , ".svgz"  : "image/svg+xml"
      , ".swf"   : "application/x-shockwave-flash"
      , ".t"     : "text/troff"
      , ".tar"   : "application/x-tar"
      , ".tbz"   : "application/x-bzip-compressed-tar"
      , ".tcl"   : "application/x-tcl"
      , ".tex"   : "application/x-tex"
      , ".texi"  : "application/x-texinfo"
      , ".texinfo" : "application/x-texinfo"
      , ".text"  : "text/plain"
      , ".tif"   : "image/tiff"
      , ".tiff"  : "image/tiff"
      , ".torrent" : "application/x-bittorrent"
      , ".tr"    : "text/troff"
      , ".txt"   : "text/plain"
      , ".vcf"   : "text/x-vcard"
      , ".vcs"   : "text/x-vcalendar"
      , ".vrml"  : "model/vrml"
      , ".war"   : "application/java-archive"
      , ".wav"   : "audio/x-wav"
      , ".wma"   : "audio/x-ms-wma"
      , ".wmv"   : "video/x-ms-wmv"
      , ".wmx"   : "video/x-ms-wmx"
      , ".wrl"   : "model/vrml"
      , ".wsdl"  : "application/wsdl+xml"
      , ".xbm"   : "image/x-xbitmap"
      , ".xhtml"   : "application/xhtml+xml"
      , ".xls"   : "application/vnd.ms-excel"
      , ".xml"   : "application/xml"
      , ".xpm"   : "image/x-xpixmap"
      , ".xsl"   : "application/xml"
      , ".xslt"  : "application/xslt+xml"
      , ".yaml"  : "text/yaml"
      , ".yml"   : "text/yaml"
      , ".zip"   : "application/zip"
   }


}
var querystring = require('querystring');
//TIMS upload function
function tims (res,query) { 
   var test_case_desc = query.testcase_desc;
   var folder_id = query.folder_id;
   var userstory_id = query.userstory_id;
   var result = query.testresult;
   var test_config = query.test_config;
   var req = http.request(TimsOptions, function(response) {
      var output_xml = '';
      console.log('STATUS: ' + response.statusCode);
      console.log('HTTPVersion: ' + response.httpVersion);
      for (var header in response.headers) {
         var iValue = response.headers[header];
         console.log('HTTP Response header [' + header + ':' + iValue + '\]');
      };
      response.on('data', function (chunk) {
         output_xml = output_xml + chunk;
      });
      response.on('end', function () {
         console.log('end of response' + output_xml); 
         res.writeHead(200,{"Content-Type":"text/plain"});
         res.write(output_xml);
         res.end();
      });
      response.on('close',function () { console.log('close');});
   });
   req.on('error', function(e) {
      console.log('problem with request: ' + e.message);
      res.writeHead(500,{"Content-Type":"text/plain"});
      res.write("Bad TIMS request");
      res.end();
   });
   //Construre XML
   var header1 = '<?xml version="1.0" encoding="ISO-8859-1"?> <Tims xsi:schemaLocation="http://tims.cisco.com/namespace \
   http://tims.cisco.com/xsd/Tims.xsd" \
   xmlns="http://tims.cisco.com/namespace" \
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
   xmlns:xlink="http://www.w3.org/1999/xlink"> \
   <Credential user="cannie" \
   token="7C000000000000054911000000000036"/> \
   <Result \
   xlink:href="http://tims.cisco.com/xml/Ttv69p/entity.svc"> \
   <ID xlink:href="http://tims.cisco.com/xml/Td26477792r/entity.svc">Td26477792r</ID> \
   <Title> \
   ';
   var title = ' <![CDATA[ Result For: ' + userstory_id + test_case_desc + ' ]]> </Title>';
   var header2 = ' \
   <ListFieldValue multi-value="true"> \
   <FieldName> \
   <![CDATA[ Requirements Tested ]]> \
   </FieldName> \
   <Value> \
   ';
   var test_case_us =  '<![CDATA[ ' + userstory_id + ']]>' + '</Value>  </ListFieldValue>';
   var header3 =  ' \
   <ListFieldValue multi-value="true"> \
   <FieldName> \
   <![CDATA[ Project Tags ]]> \
   </FieldName> \
   <Value>\
   <![CDATA[ VCF-R.01-S1 ]]> \
   </Value> \
   </ListFieldValue> \
   <Description/> \
   <ProjectID \
   xlink:href="http://tims.cisco.com/xml/Ttv69p/project.svc">Ttv69p</ProjectID> \
   <DatabaseID \
   xlink:href="http://tims.cisco.com/xml/SPVTG/database.svc">SPVTG</DatabaseID> \
   <FolderID \
   ';
   var folder_id_str = ' xlink:href="http://tims.cisco.com/xml/Ttv5033167f/entity.svc">' + folder_id + '</FolderID>';
   var config_id = '<ConfigID xlink:href="http://tims.cisco.com:80/xml/Ttv5234323g/entity.svc" >' + test_config + '</ConfigID>';
   var result_str = '<Status>' + result + '</Status>';
   var end1 = ' </Result> </Tims> ';
   var xml_data = header1 + title + header2 + test_case_us + header3 + folder_id_str + result_str + config_id + end1;
   req.write(xml_data);
   req.end();
}

var TimsOptions = {
   host: 'tims.cisco.com',
   port: 80,
   path: '/xml/Ttv69p/update.svc',
   method: 'POST',
};
var sif_server = 'ss-auto-centos-9.cisco.com';

/* 
Input
*/

exports.start = start;
exports.cmd = cmd;
exports.tims = tims;
exports.static = static;
exports.sif = sif;
exports.setting = setting;
