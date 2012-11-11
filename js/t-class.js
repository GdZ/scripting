//Constrctor:
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
   console.log("Yes");
}
//Alias Person's prototype to fn, less verbose
Person.fn = Person.prototype;
//Instance function:
Person.fn.showName = function () {
   console.log("Name: " + this.name);
};
Person.run(50);
bob.showName();
bob.showAge(50);

/////////////////////////////////////////////

// function.apply() ???

var Class = function() {
   var klass = function() {
      this.init.apply(this,arguments);
   };
   klass.prototype.init = function(){};
   return klass;
};
var Book = new Class;
Book.prototype.init = function() {
};
var book = new Book;

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


var Novel = function(){};
Novel.prototype = new Book;
Novel.prototype.editor = function() {
   console.log("editor");
};
var novel1 = new Novel;
novel1.editor();
novel1.save();

