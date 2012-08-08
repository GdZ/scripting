
console.log("using bubble sorting");
var unsorted = [ 2, 5, 2,10, 3, 1, 9,4,12,0];
console.log(unsorted);
var len = unsorted.length;
for(var i = 0; i < len; i++) {
   for(var j = 0; j < (len - i); j++) {
       if(unsorted[j] > unsorted[j+1]) {
            //swtich
          var tmp = unsorted[j+1];
          unsorted[j+1] = unsorted[j];
          unsorted[j] = tmp;
       }
      
   }
   console.log(unsorted);
}
console.log(unsorted);

//quick sort

console.log("using quick sorting");

var unsorted = [ 2, 5, 2,10, 3, 1, 9,4,12,0];

var tmp_list = [];
function qsort(data) {
   console.log("iteration");
   if (data.length <= 1) return data;
   var pivot = data.shift();
   var less = [],greater = [];
   data.forEach(function(x) {
      if(x <= pivot) less.push(x)
         else greater.push(x);
   });
   return qsort(less).concat(pivot,qsort(greater));
}
var sorted = qsort(unsorted);
console.log(sorted);

console.log("using in-place quick sorting");
function partition(data,left,right,pivot_idx) {
   var pivot = data[pivot_idx];
   var tmp = data[right];
   data[right] = data[left];
   data[left] = tmp;
   var store_idx = left;
   for(var i = left; i < right-1; i ++) {
      if(data[i] < pivot) {
         tmp = data[store_idx];
         data[store_idx] = data[i];
         data[i] = tmp;
         store_idx ++;
      }
   }
   tmp = data[right];
   data[right] = data[store_idx];
   data[store_idx] = tmp;

   return store_idx;
}

function quicksort(data,left, right) {
   if(left < right ) {
      var pivot_idx = left;
      var new_pivot_idx = partition(data,left, right, pivot_idx);
      quicksort(data,left,new_pivot_idx-1);
      quicksort(data,new_pivot_idx+1,right);
   }
}

var unsorted = [ 2, 5, 2,10, 3, 1, 9,4,12,0];
quicksort(unsorted,0,unsorted.length-1);

console.log(unsorted);





//for(var i = 0; i < len; i ++ ) {
//   tmp_list.push(unsorted[i]);
//   for(var j = 0; j < len; j++) {
//         if(unsorted[j] > tmp_list[i]) {
//            tmp_list.unshift(unsorted[j])
//         } else {
//            tmp_list.push(unsorted[j]);
//         }
//   }
//   console.log(tmp_list);
//
//}
      

var unsorted = [ 2, 5, 2,10, 3, 1, 9,4,12,0];
console.log(unsorted);
function partial_reverse(A, i, j) {
    if (i >= (A.length -1) || j >= (A.length -1) ) return A;
    if( i >= j ) { return A };
    var left = A.slice(0, i);
   console.log("lefdt" + left);
    var revert = [];
    var right = A.slice(j+1);
   console.log(right);
    for (var k = j; k > i-1; k-- ) {
        //revert the array A[i] - A[j]
   console.log(revert);
        revert.push(A[k]);
    }
   console.log(revert);
    return left.concat(revert, right);
    
    }

console.log("dfdf");
var result  = partial_reverse(unsorted, 3, 6);
console.log(result);
