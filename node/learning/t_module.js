var m_a = require('./module_a.js');
var m_b = require('./module_b.js');
var m_a2 = require('./module_a.js');
m_a.get_a();
m_b.get_b();
m_a.get_m();
m_b.get_m();
m_a.set_m('x');
m_a.get_m();
m_b.get_m();
m_a.foo();
console.log(m_a.in);
m_a2.get_m();


