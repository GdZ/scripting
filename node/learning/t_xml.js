var http = require('http');
var XmlStream = require('xml-stream');
var options = { host: 'cloud.tfl.gov.uk',
   path: '/TrackerNet/LineStatus'
};
var twitter = { host: 'api.twitter.com',
   path: '/1/statuses/user_timeline.rss?screen_name=nwhite89'
}


var request = http.get(options).on('response', function(response) {

   response.setEncoding('utf8');
   var xml = new XmlStream(response);

   xml.on('updateElement: item', function(item) {

      item.title = item.title.match(/^[^:]+/)[0] + ' on ' +
         item.pubDate.replace(/ +[0-9]{4}/, '');
   });


   xml.on('text: item > pubDate', function(element) {

      element.$text = element.$text;

   }); 


   xml.on('data', function(data) {
      process.stdout.write(data);
   });
});
