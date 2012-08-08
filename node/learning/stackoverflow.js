var tcp_timeout = 12000; // time to wait for keep alives on http connection
var tcp_delimiter = '\r\n';
var tcp_conns = {};
var client_ids = []; // all client ids
var rids = []; // all request ids
var req_start = {}; // rid->time
var req_end = {}; // rid->time
var req_delay = {}; // rid->time
var req_map = {}; // rid->http_request - we check after the fact to see if all request connections close

var openConnections = function(callback){
   // create client ids to assign to tcp client connections
   for(var i = 0; i < argv.n; i++) { client_ids.push("sim_"+i); }

   var openTCPConnection = function(i) {
      if( i < client_ids.length ) {

         var openOne = function(i) {
            var conn = net.createConnection(TCP_PORT, HOSTNAME);
            conn.client_id = client_ids[i];
            conn.responsive = true; // for future testing use to simulate client failures
            conn.on('connect', function() {
               var add_msg = "{\"m\":\"add\",\"id\":\"}";
               conn.write(add_msg+tcp_delimiter);
            })
            .on('end', function() {
               this.connected = false;
            })
            .on('data', function(data){
               console.log("client.id="+this.client_id+" received: "+data)
               if(this.responsive){
                  try {
                     // HANDLE DIFFERENT CLIENT MESSAGE TYPES
                     result = JSON.parse(data);
                  } catch (err) {
                     console.log("Unable to parse JSON("+data+"):", err)
                  }

                  if('m' in result && result['m']=='keep_alive'){
                     conn.write("{\"m\":\"keep_alive\",\"success\":\"true\"}"+tcp_delimiter);
                     if(this.connected){
                        tcp_conns[this.client_id] = conn; // this is what the verification step checks
                     }
                  }
                  else if('m' in result && result['m']=='set'){
                     if('rid' in result) {
                        // We introduce delay into the response!

                        var delay = Math.floor(Math.random()*TCP_CLIENT_DELAY); // delay of 0-1000 ms
                        var rid = result['rid'];
                        req_delay[rid] = delay; // store the delay

                        setTimeout( function() {
                           var rid = result['rid'];
                           var delay = req_delay[rid];
                           conn.write("{\"m\":\"set\",\"rid\":\""+rid+"\"}"+tcp_delimiter);
                        }, delay ); // a random wait between 0 and 0.5
                     }
                  }
                  else if('success' in result && result['success']=='true'){ // on conn start
                     this.connected = true;
                     console.log("client.id="+this.client_id+" connected to server")
                  }
               }
            });
         }
         openOne(i);
         openTCPConnection(i+1);
      }
   }
   openTCPConnection(0);

   setTimeout( function() {
      console.log("Verifying Keep Alives")
      console.log("client_ids["+client_ids.length+"]: "+Object.keys(client_ids));
      console.log("tcp_conns["+Object.keys(tcp_conns).length+"]: "+Object.keys(tcp_conns));

      if(client_ids.length == Object.keys(tcp_conns).length) {
         console.log("All keep alives received");
         callback(null,'1');
      } else {
         console.log("Error, unable to establish all connections");
         process.exit(1);
      }
   }, tcp_timeout);
}














var doHTTP = function(callback){
   var state = 'foobar';
   var sid = 'foobar';

   // Do a M loops, foreach loop change state of all clients
   var count = 0;
   var num_loops = M;
   async.whilst(
      function () { return count < num_loops; },
      function (callback) {
         // fire off a deferred http request to each TCP client
         async.forEach(client_ids, 
                       function(clientId,callback) {
                          var rid = generateRID(12);
                          rids.push(rid);
                          var route = "/?rid="+rid+"&id="+clientId+"&json={%22m%22:%22set%22,%22state%22:%22"+state+"%22,%22sid%22:%22"+sid+"%22,%22rid%22:%22"+rid+"%22,%22id%22:%22"+clientId+"%22}";

                          req_start[rid] = Date.now();
                          deferredHTTPRequest(route).then( function(val){
                             console.log("response from clientId="+clientId+" val="+val);
                             req_end[rid] = Date.now();
                          })
                          .fail(function (error) {
                             console.log("ERR clientId="+clientId+" err="+error);
                          });

                          callback();
                       }, function(err){
                          if (err) {
                             // Handle an error
                          } else {
                             // done
                          }
                       });

                       count++;
                       setTimeout(callback, argv.l*1000);
      },
      function (err) {
         callback();
      }
   );
}

var deferredHTTPRequest = function(route) {
   // Deferred HTTP request
   console.log("deferredHTTPRequest: "+route);

   var defer = q.defer();

   var options = {
      host: argv.host,
      port: argv.proxy_http_port,
      path: route
   };

   http.get(options, function(resp){
      var str = '';
      resp.on('data', function (chunk) { str += chunk; });
      resp.on('close', function (err) { // conn closed before 'end' rcvd
         return defer.reject(err);
      });
      resp.on('end', function () {
         return defer.resolve(str);
      });
   }).on("error", function(err){
      return defer.reject(err);
   });

   return defer.promise;
}
