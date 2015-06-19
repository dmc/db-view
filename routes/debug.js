/*
 * GET users listing.
 */

exports.log = function(obj) {


    Object.keys(obj).forEach(function(key) {
    var value = this[key];
    console.log([key, ':', value].join(' '));
    }, obj);


};
