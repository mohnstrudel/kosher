$(document).ready(function(){
  if($("body").hasClass('faqs')){
    $(".g-faq__toggle").each(function(){
        $(this).height($(this).innerHeight());
    }).on("click", function(){
        $(this).parent().toggleClass("g-faq__item_open");
    });
    var rtime;
    var timeout = false;
    var delta = 200;
    $(window).resize(function() {
        $(".g-faq__toggle").each(function(){
            $(this).removeAttr("style").height($(this).innerHeight());
        });
    });
}  
});
