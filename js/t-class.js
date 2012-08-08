var Person = function(name) {
   this.name = name;
};
//Class function:
Person.run = function(speed) {
   console.log('Run with speed' + speed);
};
//Instance function:
Person.prototype.show_age = function (age) {
   console.log(this.name + " age is " + age);
};
var bob = new Person('bob');
if(bob instanceof Person) {
   console.log("Yes");
}
Person.fn = Person.prototype;
Person.fn.show_name = function () {
   console.log("Name " + this.name);
};
Person.run(50);
bob.show_name();
bob.show_age(50);
