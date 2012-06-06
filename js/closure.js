var window;
function f1() {
   var msg = "haha";
   function f2() {
      console.log(msg);
   }
   f2();
   window.myF2 = f2;
}
f1();
//window.myF2();

