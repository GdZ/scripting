function onConnect (rsp,textStatus,jqXHR) {
   if (rsp.error) {
      alert("error connecting: " + rsp.error);
      return;
   }
   var text = jqXHR.responseText;
   console.log(text);
   text = '<p>' + text + '</p>';
   $("#log").html(text);
   
}
function onSetting (rsp,textStatus,jqXHR) {
   if (rsp.error) {
      alert("error connecting: " + rsp.error);
      return;
   }
   var text = jqXHR.responseText;
   console.log(text);
   text = '<p>' + text + '</p>';
   $("#Setting").html(text);
   
}

$(document).ready(function() {

   $("#cmdButton").click(function () {

      var cmd = $("#command").attr("value");
      console.log(cmd);
      
      $.ajax({ cache: false
             , type: "GET" 
             , dataType: "text"
             , url: "/cmd"
             , data: { cmd_str:cmd }
             , error: function () {
                alert("error connecting to server");
             }
             , success: onConnect
      });
      return false;
   });
   $("#cmdClear").click(function () {
      $("#log").html(' ');
   });

   $("#sifButton").click(function () {

      var sif = $("#sifserver").attr("value");
      console.log(sif);
      
      $.ajax({ cache: false
             , type: "GET" 
             , dataType: "text"
             , url: "/setting"
             , data: { sifserver:sif }
             , error: function () {
                alert("error connecting to server");
             }
             , success: onSetting
      });
      return false;
   });
});

  

