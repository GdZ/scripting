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
var sayHello = f1('Nihao ');
sayHello('More');
sayHello('Less');
window.myFun('anything');
var sayNihao = f1('Hello ');
sayNihao('More');
sayNihao("Less");
window.myFun('anything');

var myClass = function () {
   var foo = function (name) {
      console.log("in side foo with name " + name);
   };
   foo.abc = 4;
   return foo;
};

var my1 = new myClass;
var my2 = new myClass;
my1("my1");
console.log(my1.abc);
my2("my2");
var my3 = myClass();
my3("my3");
console.log(my3.abc);

console.log("-----------------------------------");
var num = 2;
var num = 3;
//JS will not prompt error/warning  when define the same var twice!
console.log(num);

// for loop doesn't create new scope
// so num is set to 2;
for (var i=0; i<3; ++i) {
   var num = i;
   setTimeout(function() {  console.log(num); }, 10);//2 2 2
}
//using 'with' statement, the block is created in new scope. 
for (var j=0; j<3; ++j) {
   // variables introduced in this statement 
   // are scoped to the block following it.
   with ({num :j}) {
      setTimeout(function() { console.log(num); }, 10);// 0 1 2
   }
}

// create new scope
for (var ii=0; ii<3; ++ii) {
   (function(num) {
      setTimeout(function() { console.log(num); }, 10);//0 1 2
   })(ii);
}

console.log("-----------------------------------");

Object.prototype.x = 10;

var w = 20;
var y = 30;

// in SpiderMonkey global object
// i.e. variable object of the global
// context inherits from "Object.prototype",
// so we may refer "not defined global
// variable x", which is found in
// the prototype chain

console.log(x); // 10

(function foo() {

   // "foo" local variables
   var w = 40;
   var x = 100;

   // "x" is found in the
   // "Object.prototype", because
   // {z: 50} inherits from it
   //https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Statements/with
   //Using with is not recommended, and is forbidden in ECMAScript 5 strict mode. The recommended alternative is to assign the object whose properties you want to access to a temporary variable.

   with ({z: 50,y:15}) {
      console.log(w, x, y , z); // 40, 10, 15, 50, NOT 40,10,30,50
   }

   // after "with" object is removed
   // from the scope chain, "x" is
   // again found in the AO of "foo" context;
   // variable "w" is also local
   console.log(x, w); // 100, 40
   //set w as gloabl, we will get 20, otherwise it's undefined. 
   //console.log(global.w);

})();

// the code of the "foo" function
// never changes, but the "this" value
// differs in every activation
(function test() { 
   function foo() {
      //console.log(this);
      console.log('inside foo');
   };

   // caller activates "foo" (callee) and
   // provides "this" for the callee
   console.log(1);
   foo(); // global object
   console.log(2);
   foo.prototype.constructor(); // foo.prototype

   var bar = {
      baz: foo
   };
   console.log(3);
   bar.baz(); // bar
   console.log(4);
   (bar.baz)(); // also bar
   console.log(5);
   (bar.baz = bar.baz)(); // but here is global object
   console.log(6);
   (bar.baz, bar.baz)(); // also global object
   console.log(7);
   (false || bar.baz)(); // also global object
   console.log(8);
   var otherFoo = bar.baz;
   otherFoo(); // again global object
}) ()
