model = {
   collection : null,
   type : null,
   GUID : 0,
   all: function () {
      for(var i=0;i<this.collection.length;i++) {
         console.log("ONE");
         console.log(this.collection[i]);
      };

   },
   find: function (field, value) {
      for(var i = 0; i<this.collection.length;i++) {
         if(this.collection[i][field] === value) return this.collection[i];
      }
   },
   create : function (first,last,email) {
      var contact = new Object();
      this.GUID ++;
      contact.first = first;
      contact.last = last;
      contact.email = email;
      contact.id = this.GUID;
      return contact; 
   },
   add :  function (instance) {
      this.collection.push(instance);   
   },
   remove : function (instance) {},
   init : function(name) {
      this.collection = [];
      this.type = name;
   },
}

contact = Object.create(model);
contact.init('contact');
function test() {
   c1 = contact.create("Joe1","Smith1","joe1@gmail.com");
   contact.add(c1);
   c2 = contact.create("Joe2", "Smith2", "joe2@gmail.com");
   contact.add(c2);
   c3 = contact.create("Joe3","Smith3","joe3@gmail.com");
   contact.add(c3);
   contact.all();                            
   console.log(contact.type);
}
test()
