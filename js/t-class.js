//Construtor:
var Person = function(name) {
   this.name = name;
};
//Class function:
Person.run = function(speed) {
   console.log(' Run with speed: ' + speed);
};
//Instance function:
Person.prototype.showAge = function (age) {
   console.log(this.name + " age is " + age);
};
var bob = new Person('bob');
if(bob instanceof Person) {
   console.log("Yes, bob is an instance of Person");
}
//Alias Person's prototype to fn, less verbose
Person.fn = Person.prototype;
//Instance function:
Person.fn.showName = function () {
   console.log("Name: " + this.name);
};
Person.run(50);
//bob.run(30); //ERROR !
bob.showName();
bob.showAge(50);

/////////////////////////////////////////////

// function.apply() ???

var Class = function() {
   console.log("constructor of Class");
   var klass = function() {
      console.log("constructor of klass");
      this.init.apply(this,arguments);
   };
   klass.prototype.init = function(){console.log("------------------")};
   return klass;
};
var Book = new Class;//call construtor of Class

Book.prototype.init = function() {
   console.log("Book prototype init");
};
var book = new Book;//call constructor of Book

Book.find = function(id) {
   console.log("id " + id);
};
//book.find(2); Can't get find
var book2 = Book.find(1);
Book.prototype.save = function() {
   console.log("save");
};
var book3 = new Book;
book3.save();

console.log("split --------------------------------------");
//Novel inherit from Book
var Novel = function(){};
Novel.prototype = new Book;
Novel.prototype.editor = function() {
   console.log("editor");
};
var novel1 = new Novel;
novel1.editor();
novel1.save();
novel1.init();

console.log("split --------------------------------------");
var a = {
  x: 10,
  calculate: function (z) {
    return this.x + this.y + z
  }
};
 
var b = {
  y: 20,
  __proto__: a
};
 
var c = {
  y: 30,
  __proto__: a
};
 
// call the inherited method
console.log(b.calculate(30)); // 60
console.log(c.calculate(40)); // 80
