
//
console.log("   Loop example ");
//Will print 5, 5, 5, 5
//for(var i = 0; i < 5; i++) {
//   setTimeout(function() {
//      console.log(i);
//   }, 100);
//}
//
//for(var i = 0; i < 5; i++) {
//   setTimeout(function() {
//      var j = i;
//      console.log(j);
//   }, 100);
//}
//
for(var i = 0; i < 5; i++) {
   var j = i;
   setTimeout(function() {
      console.log(j);
   }, 100);
}
for(var i = 0; i < 5; i++) {
   (function() {
      var j = i;
      setTimeout(function() {
         console.log(j);
      }, 100);
   })();
}

/*
7.2.3 Control flow pattern #1, #2, #3
It's very like Erlang/Haskell function programming concept.
1) define quit condition in iterration.
2) return itself, here function series(item).

*/
// Async task
function async(arg, callback) {
   console.log('do something with \''+arg+'\', return 1 sec later');
   setTimeout(function() { callback(arg * 2); }, 1000);
};
// Final task (same in all the examples)
function final() { console.log('Done', results); }
// A simple async series:
var items = [ 1, 2, 3, 4, 5, 6 ];
var results = [];
function series(item) {
   if(item) {
      async( item, function(result) {
         results.push(result);
         return series(items.shift());
      });
   } else {
      return final();
   }
};
//series(items.shift());

//forEach is part of JavaScript 1.6
//All browsers support it but IE !
// #2
//items.forEach(function(item) {
//   async(item, function(result){
//      results.push(result);
//      if(results.length == items.length) {
//         final();
//      }
//   })
//});



//#3


var running = 0;
var limit = 2;
function launcher() {
   while(running < limit && items.length > 0) {
      var item = items.shift();
      async(item, function(result) {
         results.push(result);
         running--;
         if(items.length > 0) {
            launcher();
         } else if(running == 0) {
            final();
         }
      });
      console.log("running " + running);
      running++;
   }
}
launcher();


function times2(x,callback) {
   setTimeout(function() {
      callback(x * 2)
      }, 500);
}
function plus3(x,callback) {
   setTimeout(function() {
      callback(x + 3);
      }, 500);
}
function displayResult(z) {
   console.log("The results is = ", z);
}
function plus3AndThenTimes2(x,callback) {
   plus3(x, function(y){
      times2(y,callback);
});
}

plus3AndThenTimes2(5,displayResult);
