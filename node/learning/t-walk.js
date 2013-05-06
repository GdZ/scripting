var walk = require('walk'); 
var directoryPath = ".";

var walker  = walk.walk(directoryPath, { followLinks: false });

walker.on("directories", function (root, dirStatsArray, next) {
   // dirStatsArray is an array of `stat` objects with the additional attributes
   // * type
   // * error
   // * name
   //console.log(root);
   //console.log(dirStatsArray);

   next();
});

console.log("end");
var filter = "/*.jpg/";
var files = [];
walker.on('file', function(root, stat, next) {
   if (stat.name.match(filter) != null){
      console.log("match !!!");
      return next();
   }

   var file = {
      type: stat.type,
      name: stat.name,
      root: root
   };
//
//{ 
//    type: 'file',
//    name: 'Buffer.js',
//    root: './node_modules/exif/lib/exif'
//},
//
   files.push(file);
   next();

});

walker.on('end', function() {
   console.log(files);
});


