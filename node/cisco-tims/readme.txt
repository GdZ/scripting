Re-use SIF's team's html and javascript
1) caller.html
2)cisco-sif-api-quickview.js
Design:
a. proxy VR5 request to SIF server. In router.js, when VR5SIF? is seen, one special handle will be invoked.
b. in the handler, http client instance will be used to call SIF api and get back the response (JSON)
c. in client side code, cisco-sif-api-quickview.js, JSON will be displayed in html
d. caller.html will show the result.
e. pretty print. It takes some efforts to deal with PP.
solution1: Using Prettyprint
http://code.google.com/p/google-code-prettify/
But i can't make it work perfectly with quickview. Maybe it's embeded under <pre> section.
solution2: Using json-util.js
http://jrosocha.blogspot.com/2012/04/json-to-east-to-read-html-via.html
It works, but the JSON table is not perffect.
solution3: Using stringify
http://stackoverflow.com/questions/4810841/json-pretty-print-using-javascript
It works perfectly. a) add css file in caller.html b) adding function syntaxHightlight() in cisco-sif-api-quickview.js c) hack ajaxCall and loadContents functions.
var text = jqXHR.responseText;
console.log(text);
var output = JSON.parse(text);// turn text to JSON object
console.log(output);
var new_text = JSON.stringify(output,undefined,4); //stringify the JSON object to text
//var json = new JsonUtil?();
//cntntHdlr.html(json.tableifyObject(output));
new_text = syntaxHighlight(new_text); //syntax highlight (working with css)
//new_text = '<pre>' + new_text + '</pre>';
//new_text = '<pre class="prettyprint">' + new_text + '</pre>';
cntntHdlr.html(new_text);
f. how to use multipe SIF ?
adding one additional function called 'setting' to change the global var named sif_server. It's a bad design.
The problem is, when multiple user trying to call diffrent SIF server. Conflict happens.
