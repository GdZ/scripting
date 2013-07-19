var v_a = 'a';
var v = 'm';
var _in = 9;
function foo() {
   console.log("foo");
};
exports.get_a = function () {
   console.log(v_a);
}
exports.get_m = function () {
   console.log(v);
}
exports.set_m = function (m) {
   v = m;
}
exports.foo = foo;
exports.in = _in;
console.log("using module A");
