var im = require('imagemagick');
im.readMetadata('../../public/pics/p1.jpg', function(err, metadata){
  if (err) throw err;
  console.log('Shot at '+metadata.exif.dateTimeOriginal);
  console.log(metadata.exif);
  console.log(metadata.exif.gpsInfo);
});


im.identify(['-format','%[EXIF:*GPS*]','../../public/pics/IMGP4471.JPG'], function(err, output){
  if (err) throw err;
  console.log(output);
})
im.convert(['../../public/pics/IMGP4471.JPG', '-resize', '400x300', 'thumb.jpg'], 
function(err, stdout){
  if (err) throw err;
  console.log('stdout:', stdout);
});
