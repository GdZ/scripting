var pcap = require("pcap"),
util = require("util"),
pcap_session = pcap.createSession("eth0", "port 80"),
matcher = /google/i;

console.log("Listening on " + pcap_session.device_name);

pcap_session.on('packet', function (raw_packet) {
   var packet = pcap.decode.packet(raw_packet);
   //console.log(util.inspect(packet));
   var data = packet.link.ipv6.tcp.data;

   if (data && matcher.test(data.toString())) {
      console.log(pcap.print.packet(packet));
      console.log(data.toString());
   }
});
