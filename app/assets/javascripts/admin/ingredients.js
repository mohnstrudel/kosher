$(".select2_ingredients").select2();

$('form').on('click', ".remove_record", function(event){
  $(this).prev('input[type=hidden]').val('1');
  $(this).closest('.ingredient_row').hide();
  return event.preventDefault();
});