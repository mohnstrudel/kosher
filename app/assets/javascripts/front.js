//= require jquery/dist/jquery.min
//= require rails-ujs


//= require_tree ../../../vendor/assets/javascripts/front/first/.

//= require front/second/jquery.bxslider

//= require inputmask/dist/inputmask/inputmask
//= require inputmask/dist/inputmask/jquery.inputmask

//= require front/second/jquery.masonry.min

//= require front/second/jquery.history
//= require front/second/js-url.min
//= require front/second/jquerypp.custom
//= require front/second/lightbox.min


//= require select2/dist/js/select2

//= require_self

//= require front/common
//= require front/faq
//= require front/products
//= require front/social_scripts
//= require front/static_pages


$(document).ready(function(){
  $('.g-filters__submit').on('click', function(){
    console.log('clicked!');
  });
});