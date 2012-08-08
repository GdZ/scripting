var system = require('system');

/**
 * Wait until the test condition is true or a timeout occurs. Useful for waiting
 * on a server response or for a ui change (fadeIn, etc.) to occur.
 *
 * @param testFx javascript condition that evaluates to a boolean,
 * it can be passed in as a string (e.g.: "1 == 1" or "$('#bar').is(':visible')" or
 * as a callback function.
 * @param onReady what to do when testFx condition is fulfilled,
 * it can be passed in as a string (e.g.: "1 == 1" or "$('#bar').is(':visible')" or
 * as a callback function.
 * @param timeOutMillis the max amount of time to wait. If not specified, 3 sec is used.
 */
function waitFor(testFx, onReady, timeOutMillis) {
    var maxtimeOutMillis = timeOutMillis ? timeOutMillis : 3001, //< Default Max Timeout is 3s
        start = new Date().getTime(),
        condition = false,
        interval = setInterval(function() {
            if ( (new Date().getTime() - start < maxtimeOutMillis) && !condition ) {
                // If not time-out yet and condition not yet fulfilled
                condition = (typeof(testFx) === "string" ? eval(testFx) : testFx()); //< defensive code
            } else {
                if(!condition) {
                    // If condition still not fulfilled (timeout but condition is 'false')
                    console.log("'waitFor()' timeout");
                    phantom.exit(1);
                } else {
                    // Condition fulfilled (timeout and/or condition is 'true')
                    console.log("'waitFor()' finished in " + (new Date().getTime() - start) + "ms.");
                    typeof(onReady) === "string" ? eval(onReady) : onReady(); //< Do what it's supposed to do once the condition is fulfilled
                    clearInterval(interval); //< Stop this interval
                }
            }
        }, 1000); //< repeat check every 100ms
};


if (system.args.length !== 2) {
    console.log('Usage: run-jasmine.js URL');
    phantom.exit();
}

var page = require('webpage').create();

// Route "console.log()" calls from within the Page context to the main Phantom context (i.e. current "this")
page.onConsoleMessage = function(msg) {
   
    console.log("HERRRY " + msg);

};

//page.onError = function(err) {
//   console.log("*****************");
//};
//phantom.onError = function(err, stack) {
//    console.log("phantom onError: "+err);
//};
page.open(system.args[1], function(status){
    if (status !== "success") {
        console.log("Unable to access network");
        phantom.exit();
    } else {
        waitFor(function(){
            return page.evaluate(function(){
                if (document.body.querySelector('.runner.running')) {
                    return false;
                } else if (document.body.querySelector('.runner .description')) {
                    return true;
                } else return false;
            });
        }, function(){
            page.evaluate(function(){
                run_spec = document.body.querySelector('div.jasmine_reporter > div.runner.failed');
		if(!run_spec) {
                	run_spec = document.body.querySelector('div.jasmine_reporter > div.runner.passed');
		}
                console.log("**********************************************************************");

                console.log('');
                console.log("---------------------------------------------------------------");
                console.log('              Summary :       ');
                console.log(run_spec.querySelector('.description').innerText);
                console.log(run_spec.querySelector('.finished-at').innerText);
                console.log("---------------------------------------------------------------");
                suite_list = document.body.querySelectorAll('div.jasmine_reporter > div.suite.failed');
                for (i = 0; i < suite_list.length; ++i) {
                    el = suite_list[i];
                    console.log('\n\n');
                    console.log("----------------------------------------------------");
                    console.log("                        Test Suite Description");
                    desc = el.querySelector('.description');
                    console.log('                        ' + desc.innerText);
                    console.log("----------------------------------------------------");
                    var spec_list = el.querySelectorAll('.spec.failed');
                    console.log('\n                      '+"Failed Test Case count:" + spec_list.length);
                    for( j = 0; j< spec_list.length; j++) {
                        console.log(spec_list[j].querySelector('.description').innerText);
                        console.log("Unexpected Result Message:");
                        var fail_msg_list = spec_list[j].querySelectorAll('.resultMessage.fail');
                        for(var ii =0; ii < fail_msg_list.length; ++ii) {
                           console.log(fail_msg_list[ii].innerText);
                        }
                        var stack_msg_list = spec_list[j].querySelectorAll('.stackTrace');
                        for(var ii =0; ii < stack_msg_list.length; ++ii) {
                           console.log("STACK TRACE");
                           console.log(stack_msg_list[ii].innerText);
                        }
                    }
                    var spec_pass_list = el.querySelectorAll('.spec.passed');
                    console.log('\n                       '+"Passed Test Case count: " + spec_pass_list.length);
                    for( var j = 0; j< spec_pass_list.length; ++ j) {
                        console.log(spec_pass_list[j].querySelector('.description').innerText);
                    }
                        
                }
                suite_pass_list = document.body.querySelectorAll('div.jasmine_reporter > div.suite.passed');
                for (i = 0; i < suite_pass_list.length; ++i) {
                    el = suite_pass_list[i];
                    console.log('');
                    console.log("----------------------------------------------------");
                    console.log("                  Test Suite Description");
                    desc = el.querySelector('.description');
                    console.log('                 ' + desc.innerText);
                    console.log("----------------------------------------------------");
                    spec_pass_list = el.querySelectorAll('.spec.passed');
                    console.log('\n                        '+"Passed Test Case count: " + spec_pass_list.length);
                    for( var j = 0; j< spec_pass_list.length; ++ j) {
                        console.log(" ", j+1+ ". ", spec_pass_list[j].querySelector('.description').innerText);
                    }
                        
                }
                console.log("**********************************************************************");
            });
            phantom.exit();
        },1200000);
    }
});
