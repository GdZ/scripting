template = {
   data: null,
   load: function (s) {
      this.data = s;
   },
   render: function (model) {
      var copy = this.data + "";
      for(var k in model) {
         var r = new RegExp("{"+ k + "}", "g");
         copy = copy.replace(r,model[k]);
      }
      console.log(copy);
       return copy;
   },
};

t1 = Object.create(template);
t1.load("<div><h3>{last}</h3>Email is {email}</div>");
t1.render({last : "Joe", email : "joe@gmail.com"});

