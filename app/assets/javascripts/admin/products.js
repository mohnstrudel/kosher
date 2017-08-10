$(".select2_categories").select2();
$(".select2_manufacturers").select2();
$(".select2_labels").select2();
$(".select2_search_categories").select2();
$(".select2_search_manufacturers").select2();

$('form').on('click', ".remove_record", function(event){
  $(this).prev('input[type=hidden]').val('1');
  $(this).closest('.barcode_row').hide();
  return event.preventDefault();
});