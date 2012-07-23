//var window = function() {}; // It's ok
//var window = null;// <==== Doesn't work !
var window = new Object();// ok
function f1(name) {
   var msg = "Greeting: " + name;
   var sayName =  function (text) {
      console.log(msg + text);
   };
   window.myFun = sayName;
   return sayName;
};
var sayNihao = f1('Hello ');
sayNihao('More');
sayNihao("Less");
window.myFun('anything');

