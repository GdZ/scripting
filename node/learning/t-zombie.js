var Browser = require("zombie");
var assert = require("assert");

// Load the page from localhost
browser = new Browser()
browser.visit("http://www.google.com/", function () {

  console.log(browser.html());

});
