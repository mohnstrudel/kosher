(function($){

    var didScroll;
    var lastScrollTop = 0;
    var delta = 5;
    var navbarHeight = $('header').outerHeight();
    $(window).scroll(function(event){
        didScroll = true;
        if ($(this).scrollTop() > $(".g-header").outerHeight()) {
            $(".g-header").addClass("g-header_fixed")
        } else {
            $(".g-header").removeClass("g-header_fixed")
        }
    });

    setInterval(function() {
        if (didScroll) {
            hasScrolled();
            didScroll = false;
        }
    }, 250);

    function hasScrolled() {
        var st = $(this).scrollTop();

        // Make sure they scroll more than delta
        if(Math.abs(lastScrollTop - st) <= delta)
            return;

        // If they scrolled down and are past the navbar, add class .nav-up.
        // This is necessary so you never see what is "behind" the navbar.
        if (st > lastScrollTop && st > navbarHeight){
            // Scroll Down
            $('header').addClass('g-header_hidden');
        } else {
            // Scroll Up
            if(st + $(window).height() < $(document).height()) {
                $('header').removeClass('g-header_hidden');
            }
        }

        lastScrollTop = st;
    }

    document.documentElement.addEventListener('touchstart', function (event) {
      if (event.touches.length > 1) {
        event.preventDefault();
      }
    }, false);

    //Disable double tap on document
    var lastTouchEnd = 0;
    document.documentElement.addEventListener('touchend', function (event) {
      var now = (new Date()).getTime();
      if (now - lastTouchEnd <= 300) {
        event.preventDefault();
      }
      lastTouchEnd = now;
    }, false);

    function validateEmail(email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }

    $(document).ready(function(){
        var isTablet = window.matchMedia("(max-width: 1024px)");
        var isMobile = window.matchMedia("(max-width: 650px)");
        var pages_array = {
            main: "home",
            faq: "faq",
            contact: "contact",
            photos: "gallery",
            products: "suppliers"
        };

        $(".js-call-btn").on("click", function(e){
            $("#call-popup").fadeIn(300);
        });
        $(".js-search-btn").on("click", function(e){
            $("#search-popup").fadeIn(300);
        });
        $(".js-menu-btn").on("click", function(e){
            e.preventDefault();
            $("#menu").addClass("g-mobile-menu_visible");
            $(".g-body").addClass("g-body_fixed");
            return false;
        });
        $(document).on("click", function(e){
            if($(e.target).closest(".g-mobile-menu_visible").length == 0 || $(e.target).closest(".js-hide-menu").length == 1){
                $("#menu").removeClass("g-mobile-menu_visible");
                $(".g-body").removeClass("g-body_fixed");
            }
        });
        $(".js-input-phone").inputmask("+7 (999) 999-99-99");
        $(".g-popup").on("click", function(e){
            var $popup = $(this);
            if($(e.target).closest(".g-popup__content").length == 0 || $(e.target).closest(".js-close-popup").length == 1)
                $popup.fadeOut(300);
        });
        function setErrorInput($input, state){
            $input.parents(".g-input").toggleClass("g-input_error", state);
        }
        $(".js-input").on("focus", function(){
            setErrorInput($(this), false);
        });
        $(document).on("submit", ".g-form", function(e){
            e.preventDefault();
            var $inputs = $(this).find(".js-input"),
                error = false;
            $inputs.each(function(){
                switch($(this).attr("name")) {
                    case "name":
                        if($(this).val() == ""){
                            error = true;
                            setErrorInput($(this), true);
                        }
                        break;
                    case "company":
                        if($(this).val() == ""){
                            error = true;
                            setErrorInput($(this), true);
                        }
                        break;
                    case "email":
                        if(!validateEmail($(this).val())){
                            error = true;
                            setErrorInput($(this), true);
                        }
                        break;
                    case "phone":
                        if(!$(this).inputmask("isComplete")){
                            error = true;
                            setErrorInput($(this), true);
                        }
                    default:
                        break;
                };
            });
            if(!error){
                $inputs.each(function(){
                   if($(this).hasClass("g-input__field_select")){
                       $(this).select2("destroy");
                       $(this).find("option:first-child").attr("selected", true);
                       $(this).select2();
                   }else
                       $(this).val("");
                });
                if($(this).attr("action") == "subscribe")
                    $("#subscribe-popup").fadeIn(300);
                else if($(this).attr("action") == "call")
                    $("#call-popup").fadeOut(200,function(){
                        $("#call-success-popup").fadeIn(300);
                    });
                else if($(this).attr("action") == "contact"){
                    $("#contact-popup").fadeIn(300);
                }
            }
            return false;
        });

        if($("body").hasClass(pages_array.contact)){
            mapboxgl.accessToken = 'pk.eyJ1Ijoic2NobmliYmEiLCJhIjoiMWEwYWI4YTA3YTAwYjVhYTY1YWZiZGFiZDk1Zjk5NGUifQ.ueMMb8kMdWxrP5N4iqx67Q';
            var map = new mapboxgl.Map({
                container: 'g-map',
                style: 'mapbox://styles/schnibba/ciw9f6qp500542qmkzdjjqd8o',
                center: [37.608156, 55.789286],
                zoom: 7.5,
                hash: false,
                interactive: false
            });
            $(".g-input__field_select").select2();
        } else if($("body").hasClass(pages_array.main)){
            var $blog = $(".g-blog"),
                $posts = $blog.find(".g-blog__item"),
                $blog_wrapper = $("<div>", {class: 'g-blog-wrapper'}),
                counter = 3;
                if (isMobile.matches)
                    counter = 1;
                else if (isTablet.matches)
                    counter = 2;
                for(var i = 0; i < counter; i++)
                    $("<div>", {class: "g-blog-wrapper__item"}).appendTo($blog_wrapper);
                var $colums = $blog_wrapper.find(".g-blog-wrapper__item");
                $posts.each(function(idx){
                    $(this).appendTo(
                        $colums.eq(idx % counter)
                    );
                });
                $blog_wrapper.insertAfter($blog);
                $blog.remove();

        } else if($("body").hasClass(pages_array.products)){
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
                e.preventDefault();
                return false;
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
                    console.log(this);
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
            filterObject.init(window.productData);
        } else if($("body").hasClass(pages_array.photos)){

        } else if($("body").hasClass(pages_array.faq)){
            $(".g-faq__toggle").each(function(){
                $(this).height($(this).innerHeight());
            }).on("click", function(){
                $(this).parent().toggleClass("g-faq__item_open");
            });
            var rtime;
            var timeout = false;
            var delta = 200;
//            $(window).resize(function() {
//                $(".g-faq__toggle").each(function(){
//                    $(this).removeAttr("style").height($(this).innerHeight());
//                });
//            });
        }
        function stickyBlock(block, holder, boundaries, checkRequired, onSet, onUnset) {
            var isFixed = false;
            function updateSticky() {
                var $block = $(block),
                    $holder = $(holder),
                    $boundaries = $(boundaries);
                function unsetFixed() {
                    $block.css({
                        position: '',
                        top: '',
                        width: ''
                    });
                    if (isFixed && typeof onUnset == 'function') {
                        onUnset();
                    }
                    isFixed = false;
                }
                function setFixed(top) {
                    $block.css({
                        position: 'fixed',
                        top: top,
                        width: $holder.width()
                    });
                    if (!isFixed && typeof onSet == 'function') {
                        onSet();
                    }
                    isFixed = true;
                }
                if (typeof checkRequired == 'function' && !checkRequired()) {
                    unsetFixed();
                    return;
                }
                if (window.pageYOffset < $holder.offset().top) {
                    unsetFixed();
                    return;
                }
                var top = Math.min(0,($boundaries.offset().top + $boundaries.height())-(window.pageYOffset+$block.outerHeight()));
                setFixed(top);
            }
            $(window).on('resize scroll', updateSticky);
            updateSticky();
        }
        var rem;

        var $sticky = $(".js-sticky");
        if($sticky.length != 0)
            stickyBlock(
                $sticky,
                $sticky.parent(),
                $sticky.closest('.g-wrapper'),
                function () {
                    return !isTablet.matches
                }
            );
        var mainSlider,
            partnersSlider,
            partnersSliderSlide,
            mainSliderSlide;
        function mobile(){
            if($("body").hasClass(pages_array.main))
                mainSlider = $("#main-slider").bxSlider();
        }
        function tablet(){
            if($("body").hasClass(pages_array.main))
                mainSlider = $("#main-slider").bxSlider();
            partnersSlider = $("#partners-slider").bxSlider({
                                minSlides: 4,
                                maxSlides: 4,
                                moveSlides: 1,
                                slideWidth: 260,
                                slideMargin: 0,
                                mouseDrag: true
                            });
        }
        function desktop(){
            if($("body").hasClass(pages_array.main))
                mainSlider = $("#main-slider").bxSlider();

            if (window.innerWidth > 1280) {
                partnersSlider = $("#partners-slider").bxSlider({
                                minSlides: 6,
                                maxSlides: 6,
                                moveSlides: 1,
                                slideWidth: 200,
                                slideMargin: 0,
                                mouseDrag: true
                            });
            } else{
                partnersSlider = $("#partners-slider").bxSlider({
                                minSlides: 4,
                                maxSlides: 4,
                                moveSlides: 1,
                                slideWidth: 260,
                                slideMargin: 0,
                                mouseDrag: true
                            });
            }
        }
        function reset() {
            if(mainSlider){
                mainSliderSlide = mainSlider.getCurrentSlide();
                mainSlider.destroySlider();
            }
            if(partnersSlider){
                partnersSliderSlide = partnersSlider.getCurrentSlide();
                partnersSlider.destroySlider();
            }
        }
        function run() {
            rem = parseFloat(getComputedStyle($("html")[0]).fontSize);
            if (isMobile.matches) {
                mobile();
            } else if (isTablet.matches) {
                tablet();
            } else {
                desktop();
            }
        }
        run();
        $(window).on('resize', function () {
            reset();
            run();
        });
    })
})(jQuery)
