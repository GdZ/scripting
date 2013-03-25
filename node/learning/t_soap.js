var soap = require('soap');
var url = 'http://vs-centos-13.cisco.com/ContentManager/webservices/search-service?wsdl';
var args = {bundleTypeName:'Logical Video'};
soap.createClient(url, function(err, client) {
   client.setSecurity(new WSSecurity('wsuser', 'wsuser'));
   client.describe();
   //client.findAllBundleTypes("", function(err, result) {
   client.findBundleTypeByName(args, function(err, result) {
      console.log(result);
   });
});
