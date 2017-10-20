$(document).on("turbolinks:load", function() {
  if($("body").hasClass('suppliers')) {
    var filter_json;
    // $.getJSON('http://api.kosher.yadadya.net/v1/filters', function(data) {
    //   filter_json = data;
    // });

    $.ajax({
      // The source URL
      url: "http://api.kosher.yadadya.net/v1/filters",

      // Tell jQuery you're doing JSON-P
      dataType: "json",

      // Include some data with the request if you like;
      // this example doesn't actually *use* the data
      // data: {some: "data"},

      // You can control the name of the callback, but
      // usually you don't want to and jQuery will handle
      // it for you. I have to here because I'm doing this
      // example on JSBin.
      // jsonpCallback: "exampleCallback",

      // Success callback
      success: function(data) {
        filter_json = data;
      },

      // Error callback      
      error: function(jxhr, status, err) {
        console.log("Error, status = " + status + ", err = " + err);
      }
    });

    // $.get('/v1/filters', function(data){ 
    //   filter_json = data;
    //   // alert(data); 
    // });

    window.productData = data;
  }
});