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
        var pages_array = {
            main: "home",
            faq: "faqs",
            contact: "contact",
            photos: "pictures",
            products: "products"
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
            // e.preventDefault();
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
            // return false;
        });
        
        if($("body").hasClass(pages_array.contact)){
            mapboxgl.accessToken = 'pk.eyJ1Ijoic2NobmliYmEiLCJhIjoiMWEwYWI4YTA3YTAwYjVhYTY1YWZiZGFiZDk1Zjk5NGUifQ.ueMMb8kMdWxrP5N4iqx67Q';
            var long = $('#long_id').val(); 
            var lat = $('#lat_id').val();
            var name = $('#name_id').val();
            var map = new mapboxgl.Map({
                container: 'g-map',
                style: 'mapbox://styles/schnibba/ciw9f6qp500542qmkzdjjqd8o',
                center: [long, lat],
                zoom: 12,
                hash: false,
                interactive: false
            });

            // var nav = new mapboxgl.NavigationControl();
            
            map.on('load', function () {
              // map.addControl(nav, 'top-left');
              map.dragPan.enable();
              map.addSource("points", {
                  "type": "geojson",
                  "data": {
                      "type": "FeatureCollection",
                      "features": [{
                          "type": "Feature",
                          "geometry": {
                              "type": "Point",
                              "coordinates": [long, lat]
                          },
                          properties: {
                              "title": name,
                              "icon": "star",
                              "marker-color": "#3ca0d3",
                              "size": "large"

                          }
                      }
                      ]
                  }
              });

              map.addLayer({
                  "id": "points",
                  "type": "symbol",
                  "source": "points",
                  "layout": {
                      "icon-image": "{icon}-15",
                      "text-field": "{title}",
                      "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
                      "text-offset": [0, 0.6],
                      "text-anchor": "top"
                  }
              });
            });
            $(".g-input__field_select").select2();
        } else if($("body").hasClass(pages_array.products)){
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
            // $("#filters").on("submit", function(e){
            //     e.preventDefault();
            //     console.log("Pressed submit!"); 
            //     return false;
            // });
            
        } else if($("body").hasClass(pages_array.photos)){
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
        } else if($("body").hasClass(pages_array.faq)){
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
      var isTablet = window.matchMedia("(max-width: 1024px)");
      var isMobile = window.matchMedia("(max-width: 650px)");
        
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