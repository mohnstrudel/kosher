$(document).on("turbolinks:load", function() {
  if($("body").hasClass("products") || $("body").hasClass("suppliers")){
    $("#category-select, #select-manufacturer").select2();
    
    
    var data_any = [{id: "any", text: "Любая подкатегория"}],
        data_categories = [];
    $("#select-subcategory optgroup").each(function(index){
        var category = {
            id: $(this).data("id"),
            name: $(this).attr("label"),
            subcat: []
        };
        category.subcat.push(data_any[0]);
        $(this).find("option").each(function(index){
            category.subcat.push(
            {
                id: $(this).val(),
                text: $(this).text()
            }
            );
        });
        data_categories.push(category);
    });
    $("#select-subcategory").html("");
    $("#select-subcategory").select2({ data: data_any});
    $("#category-select").on("change", function(){
        var val = $(this).val();
        $("#select-subcategory").select2('destroy');
        $("#select-subcategory").html("");
        if(val == "any")
            $("#select-subcategory").select2({ data: data_any});
        else
            data_categories.forEach(function(element, index, array){
                if(element.id == val){
                    $("#select-subcategory").select2({ data: data_categories[index].subcat});
                    return false;
                }
                    
            });
        
    });
    $("#filter-toggle").on("click", function(e){
        e.preventDefault();
        var $filters = $("#filters"),
            $wrapper = $("#products-wrapper");
            $("#filters").addClass("g-products__sidebar_visible")
            $wrapper.height($filters.outerHeight());                
        return false;
    });
    $("#filters-hide").on("click", function(e){
        e.preventDefault();
        var $filters = $("#filters"),
            $wrapper = $("#products-wrapper");
            $("#filters").removeClass("g-products__sidebar_visible")
            $wrapper.removeAttr("style")
        return false;
    });
  }
});