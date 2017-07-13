$(document).on('turbolinks:load', function(){
  if($("body").hasClass("pictures")){
      var GammaSettings = {
      viewport : [ {
        width : 1100,
        columns : 7
      }, {
        width : 900,
        columns : 4
      }, {
        width : 500,
        columns : 3
      }, { 
        width : 320,
        columns : 2
      }, { 
        width : 0,
        columns : 2
      } ]
  };
      Gamma.init( GammaSettings);
      $("body").on("click", ".gamma-single-view", function(e){
          console.log($(this));
      if($(e.target).hasClass("gamma-single-view"))
          $(this).find(".gamma-btn-close").click();
      });
  }
});
  