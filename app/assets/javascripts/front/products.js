$(document).ready(function(){
	if($("body").hasClass('suppliers')){
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
			$("#filters").on("submit", function(e){
					// e.preventDefault();
					// return false;
			});
			var filterObject = {
					data:{
							categories: [],
							categories_empty: [{id: "any", text: "Любая"}],
							subcategories: {},
							subcategories_empty: [{id: "any", text: "Любая"}],
							manufacturers: [],
							manufacturers_empty: [{id: "any", text: "Любой"}],
							labels: []
					},
					options:{
							flag: false,
							$categories: $("#category-select"),
							$subcategories: $("#subcategory-select"),
							$subcategories_block: $("#subcategories-block"),
							$manufacturers: $("#manufacturer-select"),
							$labels: $("#labels-block"),
							$clear: $("#clear_filters")
					},
					init: function(dataArray){
						console.log('initialized! with: ' + dataArray);
						console.log('window.productData is: ' + window.productData);
							var self = this;
							dataArray = dataArray.data;
							dataArray.forEach(function(cat, idx){
									var category = {id: cat.id, text: cat.attributes.title, labels: [], manufacturers: []};
									cat.attributes.manufacturers.forEach(function(man){
											var filter = self.data.manufacturers.filter(function(elem){ return man.id == elem.id});
											if(filter.length)
													filter[0].categories.push(cat.id)
											else
													self.data.manufacturers.push({id: man.id, text: man.title, categories: [cat.id]});
											category.manufacturers.push(man.id);
									});
									cat.attributes.labels.forEach(function(label){
											var filter = self.data.labels.filter(function(elem){ return label.id == elem.id});
											if(filter.length)
													filter[0].categories.push(cat.id);
											else
													self.data.labels.push({id: label.id, text: label.title, categories: [cat.id]});
											category.labels.push(label.id);
									});
									self.data.subcategories["cat_" + cat.id] = [];
									cat.attributes.subcategories.forEach(function(sub){
											self.data.subcategories["cat_" + cat.id].push({id: sub.id, text: sub.title});
									});
									self.data.categories.push(category);
							});

							var params = {};
							window.location.search.replace("?", "").split("&").forEach(function(elem){
									var param = elem.split("=");
									params[param[0]] = param[1];
							});
							if(typeof params.manufacturer != "undefined")
									self.options.$categories.select2({data: self.data.categories_empty.concat(self.getCategoryByManufacture(params.manufacturer))});
							else
									self.options.$categories.select2({data: self.data.categories_empty.concat(self.data.categories)});
							if(typeof params.category != "undefined"){
									self.options.$categories.val(params.category).trigger("change");
									self.options.$subcategories_block.show();
									self.options.$subcategories.select2({data: self.data.subcategories_empty.concat(self.data.subcategories["cat_" + params.category])})
									if(typeof params.subcategory != "undefined"){
											self.options.$subcategories.val(params.subcategory).trigger("change");
									}
							} else {
									self.options.$subcategories_block.hide();
							}

							if(typeof params.category != "undefined")
									self.options.$manufacturers.select2({data: self.data.manufacturers_empty.concat(self.getManufactureByCategory(params.category))});
							else
									self.options.$manufacturers.select2({data: self.data.manufacturers_empty.concat(self.data.manufacturers)});
							if(typeof params.manufacture != "undefined"){
									self.options.$manufacturers.val(params.manufacture).trigger("change");
							}

							self.data.labels.forEach(function(elem){
									self.options.$labels.append($("<input>", { type: "checkbox", class: "g-check-list__check", name: "label[]", value: elem.id, id: "label_" + elem.id}));
									self.options.$labels.append($("<label>", {class: "g-check-list__label", for: "label_" + elem.id, text: elem.text}));
							});
							if(typeof params.labels != "undefined"){
									var labels = params.labels.split(",");
									labels.forEach(function(elem){
													self.options.$labels.find("input[value='" + elem + "']").prop("checked", true);
									});

							}
							self.options.$labels.find("input[type='checkbox']").on("change", function(){self.filtersRestruc("labels")});
							self.options.$manufacturers.on("change", function(){self.filtersRestruc("manufacturers")});
							self.options.$categories.on("change", function(){self.filtersRestruc("categories")});
							// console.log(this);
					},
					filtersRestruc: function(from){
							var self = this,
									current_cat = self.options.$categories.val(),
									current_man = self.options.$manufacturers.val();
							switch (from) {
									case "labels":
											// var current_cats = [];
											// self.options.$labels.find("input:checked").each(function(idx){
											//     var val = $(this).val();
											//     self.getLabelById(val).categories.forEach(function(elem){
											//         var cat = self.getCategoryById(elem);
											//         if($.inArray(cat, current_cats) === -1 ) current_cats.push(cat);
											//     });
											// });
											// console.log(self.options.$categories.select2("destroy").html(""));
											// self.options.$categories.select2({data: self.data.categories_empty.concat(current_cats)});
											// // self.options.$manufacturers.select2({data: self.data.manufacturers_empty.concat(self.data.manufacturers)});
											break;
									case "manufacturers":
											if(self.options.flag){
													self.options.flag = false;
											} else {
													self.options.flag = true;
													if(current_man == "any"){
															self.options.$categories.select2("destroy").html("");
															self.options.$categories.select2({data: self.data.categories_empty.concat(self.data.categories)}).val(current_cat).trigger("change");
													} else {
															self.options.$categories.select2("destroy").html("");
															self.options.$categories.select2({data: self.data.categories_empty.concat(self.getCategoryByManufacture(current_man))}).val(current_cat).trigger("change");
													}
											}
											break;
									case "categories":
											if(self.options.flag){
													self.options.flag = false;
											} else {
													self.options.flag = true;
													if(current_cat == "any"){
															self.options.$manufacturers.select2("destroy").html("");
															self.options.$manufacturers.select2({data: self.data.manufacturers_empty.concat(self.data.manufacturers)}).val(current_man).trigger("change");
															self.options.$subcategories_block.hide(300);
															self.options.$subcategories.select2("destroy").html("");
													} else {
															self.options.$manufacturers.select2("destroy").html("");
															self.options.$manufacturers.select2({data: self.data.manufacturers_empty.concat(self.getManufactureByCategory(current_cat))}).val(current_man).trigger("change");
															self.options.$subcategories_block.fadeIn(250, function(){
																	if(self.options.$subcategories.hasClass("select2-hidden-accessible"))
																			self.options.$subcategories.select2("destroy").html("");
																	self.options.$subcategories.select2({data: self.data.subcategories_empty.concat(self.data.subcategories["cat_" + current_cat])});
															});
													}

											}
											break;
									default:

							}
					},
					getLabelById: function(id){
							for (var i = 0; i < this.data.labels.length; i++) {
									if(this.data.labels[i].id == id)
											return this.data.labels[i];
							}
					},
					getCategoryById: function(id){
							for (var i = 0; i < this.data.categories.length; i++) {
									if(this.data.categories[i].id == id)
											return this.data.categories[i]
							}
					},
					getManufactureById: function(id){
							for (var i = 0; i < this.data.manufacturers.length; i++) {
									if(this.data.manufacturers[i].id == id)
											return this.data.manufacturers[i]
							}
					},
					getCategoryByManufacture: function(current_man){
							var self = this;
							var current_categories = [];

							self.getManufactureById(current_man).categories.forEach(function(elem){
									var cat = self.getCategoryById(elem);
									if($.inArray(cat, current_categories) === -1) current_categories.push(cat);
							});
							return current_categories;
					},
					getManufactureByCategory: function(current_cat){
							var self = this;
							var current_manufacturers = []
							self.getCategoryById(current_cat).manufacturers.forEach(function(elem){
									var man = self.getManufactureById(elem);
									if($.inArray(man, current_manufacturers) === -1) current_manufacturers.push(man);
							});
							return current_manufacturers;
					}
			}

			// Забираем аяксом данные и вызываем при успехе функцию filterObject.init
			$.ajax({
				// Tell jQuery you're doing JSON-P
	      dataType: "json",
	      // The source URL
	      url: "http://api.kosher.yadadya.net/v1/filters/categories",

	      
	      method: 'GET',
	      // Success callback
      	
      	success: function(data) {
        	console.log('ajax call is run');
        	filter_json = data;
        	window.productData = filter_json;
        	filterObject.init(window.productData);
      	},

      	// Error callback      
      	error: function(jxhr, status, err) {
        	console.log("Error, status = " + status + ", err = " + err);
      	}
    	});
		}
		
});