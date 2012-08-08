
console.log('iterate object property only 2 level');
var group = { 'Alice': { a: 'b', b: 'c', e: {a: 'g'} }, 'Bob': { a: 'd' }};
var people = Object.keys(group);
people.forEach(function(person) {
   var items = Object.keys(group[person]);
   items.forEach(function(item) {
      var value = group[person][item];
      console.log(person+': '+item+' = '+value);
   });
});

console.log('property is from an object higher up ');
var obj = { a: "value", b: false };
// different results when the property is from an object higher up in the prototype chain
console.log( !!obj.toString );
console.log( 'toString' in obj );
console.log( obj.hasOwnProperty('toString') );

console.log('nonexistent properties');
var obj = { a: "value", b: false };
console.log( !!obj.nonexistent );
console.log( 'nonexistent' in obj );
console.log( obj.hasOwnProperty('nonexistent') );

console.log('existent properties');
console.log( !!obj.a );
console.log( 'a' in obj );
console.log( obj.hasOwnProperty('a') );



console.log('Order of function definition within a scope does not matter, but when defining a function as a variable the order does matter');
console.log( doSomething() );
// console.log( doSomethingElse() );
// define the functions after calling them!
var doSomethingElse = function() { return 'doSomethingElse'; };
function doSomething() { return 'doSomething'; }


console.log('Functions are objects, so they can have properties attached to them.');
function doSomething() { return doSomething.value + 50; }
var doSomethingElse = function() { return doSomethingElse.value + 100; };
doSomething.value = 100;
doSomethingElse.value = 100;
console.log( doSomething() );
console.log( doSomethingElse() );

console.log("JSON ");
var obj = JSON.parse('{"hello": "world", "data": [ 1, 2, 3 ] }');
console.log(obj.data);
var obj_json = {ka: 'ka', kb: 'vb', kk: {kc: 'kc', kd: 'kd'}};
console.log(JSON.stringify(obj_json));

console.log('1. Variable scope is based on the nesting of functions. In other words, the position of the function in
the source always determines what variables can be accessed:');

console.log("scope");
console.log( '1. nested functions can access their parent.s variables:');
var a = "foo";
function parent() {
   var b = "bar";
   function nested() {
      console.log(a);
      console.log(b);
   }
   nested();
}
parent();
console.log('2. non-nested functions can only access the topmost, global variables:');
var a = "foo";
function parent() {
   var b = "bar";
}
function nested() {
   console.log(a);
   console.log(b);
}
parent();
//nested();

console.log('2. Defining functions creates new scopes:');
console.log('2.1. and the default behavior is to access previous scope:');
var a = "foo";
function grandparent() {
   var b = "bar";
   function parent() {
      function nested() {
         console.log(a);
         console.log(b);
      }
      nested();
   }
   parent();
}
grandparent();

console.log('2.2. but inner function scopes can prevent access to a previous scope by defining a variable with the same name:');
var a = "foo";
function grandparent() {
   var b = "bar";
   function parent() {
      var b = "b redefined!";
      function nested() {
         console.log(a);
         console.log(b);
      }
      nested();
   }
   parent();
}
grandparent();
