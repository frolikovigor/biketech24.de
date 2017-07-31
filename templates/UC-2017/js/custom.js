var tabTimer = false;
var overflow = 0;
var tab_for_time = false;


let sliderCart;
let template = "";

$(".mehr").each(function () {
    let topPos = $(this).position().top;
    let parent = $(this).parent();
    let index = $(this).index();
    let amount = parent.children().length;
    let mehrId = $(this).data("mehr");
    let open = $("[data-mehr='"+mehrId+"']:not(.mehr)");

    if (amount > index) {

        open.removeClass("hidden");
        parent.css("height", topPos+"px");
        parent.css("overflow", "hidden");
        open.click(function () {
            parent.css("height", "auto");
            open.addClass("hidden");
        });
    }
});


$(document).ready(function () {
    $(".empty").click(function (e) {
        e.preventDefault();
    });

    template = $("#service_info").data("template");


    $(".catalog-items .goods").each(function () {
        let h = $(this).outerHeight();
        $(this).css("height", h + "px");
    });


    $(".parameters__list").each(function (index) {
        /*let elem = $(this);
        elem.attr("id", "parameters__list_"+index);
        let limit = parseInt(elem.data("limit"));
        elem.find("li").each(function (i) {
            if ($(this).hasClass("active")) {
                let clone = $(this).clone().prependTo("#parameters__list_"+index);
                $(this).remove();
            }
        });

        elem.find("li").each(function (i) {
            if (i>=limit) {
                if (!$(this).hasClass("li-plus"))
                    $(this).addClass("hide");
            }
        });

        if (!elem.find("li.hide").length) {
            elem.find(".li-plus").addClass("hide");
        }

        elem.find(".li-plus").mouseenter (function () {
            $(this).closest("ul").addClass("switch-ul")
        });

        $(".switch-ul-help").mouseleave (function () {
            $(".switch-ul").removeClass("switch-ul");
        });*/
    });




    $('.bikes_filters__slider').bxSlider({
        pagerCustom: '.bikes_filters-pager',
        controls: false,
        // auto: true
    });

    $('.bikes_brands__slider').bxSlider({
        minSlides: 1,
        maxSlides: 4,
        slideWidth: 280,
        pager: false,
        controls: false,
        slideMargin: 100,
        speed: 8000,
        pause: 2000,
        auto: true
    });

    $(".url").click(function () {
        var url = $(this).data("url");
        window.location.href = url;
    });

    jQuery("#sidebar_mobile").hamburger_uc({
        swipe_zone: ".sidebar_mobile_swipe",
        swipe_button: ".toggle_sidebar"
    });

    /* submenu */
    jQuery("[data-tab_for]").each(function () {
        var event = $(this).data("tab_event");
        event = event !== undefined ? event : "click";

        if (event == "click") {
            $(this).click(function () {
                var id = $(this).data("tab_for");
                var block=$(this).data("tab_block");
                $("[data-tab_block='"+block+"'][data-tab_for]").removeClass("active");
                $("[data-tab_block='"+block+"'][data-tab_for='"+id+"']").addClass("active");
            });
        }


        if (event == "hover") {
            $(this).hover(function () {
                if (tab_for_time !== false) {
                    clearTimeout(tab_for_time)
                }

                if (tabTimer !== false) {
                    clearTimeout(tabTimer);
                    tabTimer = false;
                }

                let elem = $(this);
                tab_for_time = setTimeout(function () {
                    tab_for_time = false;


                    let id = elem.data("tab_for");
                    let block=elem.data("tab_block");
                    $("[data-tab_block='"+block+"'][data-tab_for]").removeClass("active");
                    $("[data-tab_block='"+block+"'][data-tab_for='"+id+"']").addClass("active");

                    let elemBlock = $(".menu__sub_block[data-tab_block='"+block+"'][data-tab_for='"+id+"'] .preloader_block");

                    if (elem.hasClass("menu__item") && !elem.hasClass("brands_complete")) {
                        let path = template + "images/menu/brands/";
                        $.ajax({
                            url: "/get_brands_of_category.php",
                            method: "post",
                            dataType: 'json',
                            data: {
                                cat: id,
                                path: path
                            },
                            success: function(r){
                                elem.addClass("brands_complete");
                                let listBrands = '';

                                for(index in r) {
                                    if ((r[index].url !== undefined) && (r[index].seo !== undefined) && (r[index].image_exist !== undefined) && (r[index].image !== undefined)) {
                                        listBrands += '' +
                                            '<a href="'+r[index].url+'">' +
                                            '<div class="menu__sub_item">' +
                                            '<div class="menu__sub_img">' +
                                            (r[index].image_exist ? ('<img class="svg" src="' + r[index].image+ '">') : r[index].seo) +
                                            '</div>' +
                                            '</div>' +
                                            '</a>'
                                    }
                                }

                                elemBlock.find(".preloader_content").html(listBrands);
                                elemBlock.addClass("preloader_complete");
                            }
                        });

                    }

                },200);
            }, function () {
                if (tab_for_time !== false) {
                    clearTimeout(tab_for_time)
                }

                let this_ = $(this);
                tabTimer = setTimeout(function () {
                    let block = this_.data("tab_block");
                    $("[data-tab_block='"+block+"'][data-tab_for]").removeClass("active");
                    tabTimer = false;
                }, 300);
            });
        }
    });

    /* header scroll fixed */
    $(".header").attr("data-top", $(".header").offset().top);
    $(document).scroll(function () {
        let header = $(".header");
        var top = $(document).scrollTop();
        var topShift = header.data("top");

        if (!header.hasClass("not-fixed")) {
            if (header.hasClass("header-fixed")){
                if (top <= topShift) {
                    header.removeClass("header-fixed");
                    $(".jtl_search_results").removeClass("jtl_search_results-fixed");
                } else {
                    header.addClass("header-fixed");
                    $(".jtl_search_results").addClass("jtl_search_results-fixed");
                }
            } else {
                if (top >= topShift) {
                    header.addClass("header-fixed");
                    $(".jtl_search_results").addClass("jtl_search_results-fixed");
                } else {
                    header.removeClass("header-fixed");
                    $(".jtl_search_results").removeClass("jtl_search_results-fixed");
                }
            }
        }
    });
    $(document).scroll();

    $.getScript( "/dev/static/js/separate-js/jquery-ui.min.js", function() {
        if ($( ".slider" ).length){
            $( ".slider:not(.original)" ).each(function () {
                let slider = $(this);
                let steps = [0];
                let ajax = slider.data("ajax");

                if (ajax) {
                    $.ajax({
                        url: ajax,
                        dataType: 'json',
                        success: function(r){

                            if (typeof r === 'object') {
                                let stepsAjax = [0];
                                for(obj in r)
                                    if (r[obj].nVon !== undefined && r[obj].nBis !== undefined)
                                        stepsAjax.push(r[obj].nBis);

                                let from = !isNaN(slider.data('step_from_1')) ? parseInt(slider.data('step_from_1')) : 0;
                                let to = !isNaN(slider.data('step_to_1')) ? parseInt(slider.data('step_to_1')) : 0;
                                let from_index = 0;
                                let to_index = 0;

                                for(obj in stepsAjax) {
                                    let val = stepsAjax[obj];
                                    steps.push(val);

                                    if (val <= from) from_index = parseInt(obj);
                                    if (val <= to) to_index = parseInt(obj) + (val == to ? 0 : 1);
                                }
                                from_index = (stepsAjax[from_index] !== undefined) ? from_index : 0;
                                to_index = (stepsAjax[to_index] !== undefined) ? to_index : stepsAjax.length - 1;

                                UIslider(slider, stepsAjax, from_index, to_index);
                            }
                        }
                    });
                } else if ( !isNaN(slider.data('default'))) {
                    for(let index = 1; index<10; index++) {
                        if (!isNaN(slider.data('step_from_'+index)) && !isNaN(slider.data('step_to_'+index))) {
                            steps.push(parseInt(slider.data('step_to_'+index)));
                        } else break;
                    }

                    let from = parseInt(slider.data("from"));
                    let to = parseInt(slider.data("to"));

                    let from_index = 0;
                    let to_index = 0;

                    for(obj in steps) {
                        let val = steps[obj];
                        if (val <= from) from_index = parseInt(obj);
                        if (val <= to) to_index = parseInt(obj) + (val == to ? 0 : 1);
                    }
                    from_index = (steps[from_index] !== undefined) ? from_index : 0;
                    to_index = (steps[to_index] !== undefined) ? to_index : steps.length - 1;

                    UIslider(slider, steps, from_index, to_index);
                } else {
                    for(let index = 1; index<10; index++) {
                        if (!isNaN(slider.data('step_from_'+index)) && !isNaN(slider.data('step_to_'+index))) {
                            steps.push(parseInt(slider.data('step_to_'+index)));
                        } else break;
                    }

                    UIslider(slider, steps, 0, steps.length - 1);
                }
            });


        }
    });

    SVGElementsHover();

    $(document).on('mouseenter','.goods', function (event) {
        let preloader_block = $(this).find(".block-sizes.preloader_block");
        getListSizes(preloader_block);
    }).on('mouseleave','.goods',  function(){

    });

    if ($(".block-sizes_autoload").length) {
        $(".block-sizes_autoload").each(function () {
            getListSizes($(this));
        })
    }

    if ($(".spritespin").length && $(".bxslider-carddetail").length) {
        //
        // $('a.js-fullscreen').click(function(e){
        //     e.preventDefault();
        //     $('.spritespin').spritespin('api').requestFullscreen();
        // });
        $('a.js-zoom').click(function(e){
            e.preventDefault();
            $('.spritespin').spritespin('api').toggleZoom();
        });



        $(".spritespin").spritespin({
            // path to the source images.
            source: [
                "/dev/static/img/content/360/1.png",
                "/dev/static/img/content/360/2.png",
                "/dev/static/img/content/360/3.png",
                "/dev/static/img/content/360/4.png",
                "/dev/static/img/content/360/5.png",
                "/dev/static/img/content/360/6.png",
                "/dev/static/img/content/360/7.png",
                "/dev/static/img/content/360/8.png",
                "/dev/static/img/content/360/9.png",
                "/dev/static/img/content/360/10.png",
                "/dev/static/img/content/360/11.png",
                "/dev/static/img/content/360/12.png",
                "/dev/static/img/content/360/13.png",
                "/dev/static/img/content/360/14.png",
                "/dev/static/img/content/360/15.png",
                "/dev/static/img/content/360/16.png",
                "/dev/static/img/content/360/17.png",
                "/dev/static/img/content/360/18.png",
                "/dev/static/img/content/360/19.png",
                "/dev/static/img/content/360/20.png",
            ],
            width   : 520,  // width in pixels of the window/frame
            height  : 313,  // height in pixels of the window/frame
            loop: false,
            sizeMode: "fit",
            onLoad: function(){
                bxslider_carddetail();
            },
            mods: [
                // change frame on mouse move
                // 'move',
                'drag',
                // enable zoom module
                // toggle zoom with double click or use the API object
                'zoom',
                // display module
                '360'
            ],
            responsive: true,
        });
    }

    bxslider_carddetail();
    initColorBox();

    $(document).ajaxSuccess(function() {
        bxslider_carddetail();
    });

    $(".input__box").each(function () {
        let box = $(this);
        let inp = box.find(".input__data input[type='text']");
        let inpResult = $(".btn-blocks input[type='submit']");

        let min = inp.data("min") ? inp.data("min") : 20;
        let max = inp.data("max") ? inp.data("max") : 120;

        box.find(".input__count .count__increment").click(function () {
            inp.val(parseInt(inp.val()) +  1);
            inp.val((parseInt(inp.val()) < min) ? min :  inp.val());
            inp.val((parseInt(inp.val()) > max) ? max :  inp.val());
            inp.change();
        });

        box.find(".input__count .count__reduce").click(function () {
            inp.val(parseInt(inp.val()) -1);
            inp.val((parseInt(inp.val()) < min) ? min :  inp.val());
            inp.val((parseInt(inp.val()) > max) ? max :  inp.val());
            inp.change();
        });

        inp.keypress(function(e){
            // console.log(e.which);
            if(e.which != 8 && isNaN(String.fromCharCode(e.which))){
                e.preventDefault();
            }});

        inp.change(function() {
            inp.val((parseInt(inp.val()) < min) ? min :  inp.val());
            inp.val((parseInt(inp.val()) > max) ? max :  inp.val());

            var step = $('#step').val();
            // if(growth.length != 0 && weight.length != 0 && step.length != 0) {
            if(step.length != 0 ) {
                inpResult.removeAttr('disabled');
            } else {
                inpResult.attr('disabled','disabled');
            }
        });
    });

    $(".info-block .block__question").click(function (e) {
        e.preventDefault();
        $(".info-block .block__question").unbind();
        $(".info-block .block__question").remove();
        $(".info-block .btn-block__info").addClass("btn-block__info--js");
    });

    // $('div.good__title h2').each(function() {
    //     var text = $(this).text().replace('Ked ', '');
    //     $(this).text(text);
    // });

});

function bxslider_carddetail() {
    $('.bxslider-carddetail:not(.bxslider-complete)').each(function () {
        let a = "bxSlider";

        $(this).bxSlider({
            pagerCustom: '#bx-pager-carddetail',
            controls: false,
            onSliderLoad: function(){
                bxslider_carddetail_mini();
                initColorBox();
            }
        });
        $(this).addClass("bxslider-complete");
    });

    $(".bxslider_default:not(.bxslider-complete)").each(function(){
        let bxSlider = $(this);
        bxSlider.bxSlider({
            minSlides: 1,
            maxSlides: 4,
            moveSlides: 1,
            slideWidth: 200,
            pager: false,
            onSliderLoad: function(){
                initColorBox();
            }
        });
        bxSlider.addClass("bxslider-complete");
    });
}

function bxslider_carddetail_mini() {
    $(".bx-pager").each(function () {
        $(this).find("img[data-json]").each(function () {
            let this_ = $(this);
            let json = $(this).data("json");
            if (json.xs !== undefined) {
                if (json.xs.src !== undefined) {
                    this_.attr("src", json.xs.src);
                }
            }
        });
    });
}

function initColorBox() {
    $(".colorbox:not(.colorbox-complete)").each(function () {
        $(this).colorbox({
            maxWidth:'95%',
            maxHeight:'95%'
        });
        $(this).addClass("colorbox-complete");
    });
}



function UIslider(slider, steps, from, to) {
    let id = slider.attr("id");
    let minInp = $("[data-for='"+id+"']").find("input.slider_min");
    let maxInp = $("[data-for='"+id+"']").find("input.slider_max");
    let minSpan = slider.find(".min-val .num");
    let maxSpan = slider.find(".max-val .num");
    let url = slider.data("url");
    let url_type = slider.data("url_type");

    slider.slider({
        range: true,
        min: 0,
        max: steps.length - 1,
        values: [ from, to ],
        slide: function( event, ui ) {
            minInp.val(addSpace(steps[ui.values[ 0 ]]));
            maxInp.val(addSpace(steps[ui.values[ 1 ]]));
        },
        change: function ( event, ui ) {
            let newPF = "";

            if ((steps[ui.values[ 0 ]] !== undefined) && (steps[ui.values[ 1 ]] !== undefined)) {
                newPF = steps[ui.values[ 0 ]]+"_"+steps[ui.values[ 1 ]];

                if ((ui.values[ 0 ] == 0) && (ui.values[ 1 ] == (steps.length - 1)))
                    if (url_type == "1") {} else newPF = "";
            } else {
                newPF = "";
            }

            if (url_type == "1") {
                window.location.href = url + newPF;
            } else {
                if (newPF == "") setAttr("pf", newPF, url);
                else
                if (ui.values[ 0 ] !== ui.values[ 1 ])
                    setAttr("pf", newPF, url);
            }
        }
    });

    minInp.val(addSpace(steps[from]));
    maxInp.val(addSpace(steps[to]));

    minSpan.html(0);
    maxSpan.html(addSpace(steps[steps.length - 1]));
}



function SVGElementsHover() {
    let Objects = [];
    let getObjects = document.getElementsByClassName("svg_element");
    Array.prototype.filter.call(getObjects, function(Object){
        let typeObj = Object.getAttribute("type");
        if (Object.getAttribute("type").indexOf("svg") != -1) Objects.push(Object);
    });

    let objectTimer = setInterval(function () {
        overflow++;
        if (overflow > 50) clearInterval(objectTimer);

        if (!$("object:not(.complete)").length){
            clearInterval(objectTimer);


            Array.prototype.filter.call(Objects, function(Object, i){
                let svg = $(Object.contentDocument);
                let parent = findAncestor(Object, "svg_element_parent");
                parent = $(parent);
                parent.attr("data-id", i);
                if (!parent.find(".svg_tooltip").length) {
                    $('<div class="svg_tooltip" />').css({
                        position: 'absolute',
                        zIndex: 999,
                        display: 'none'
                    }).appendTo(".svg_element_parent[data-id='"+i+"']");
                }

                let tooltip = parent.find(".svg_tooltip");

                let inp = parent.find("input[type='hidden']");
                let SLIDE = {};
                SLIDE.elements = [];
                SLIDE.color_default = inp.data("color_default");

                let timeHide = false;

                let getStyle = svg.find("style").html();
                svg.find("style").html(getStyle + " path.select {fill: #444;} path.hover {fill: #1B11EA; cursor: pointer;}");

                svg.find("path").each(function (i) {
                    let element = $(this);

                    element.attr("data-id", i);

                    let accordance = (inp.data("accordance_"+i) !== undefined) ? inp.data("accordance_"+i) : "";
                    SLIDE.elements[i] = {
                        title: accordance ? inp.data("title_"+accordance) : "",
                        url: accordance ? inp.data("url_"+accordance) : "",
                        element: element
                    };
                });

                tooltip.hover(function () {
                    if (timeHide !== false) {
                        clearTimeout(timeHide);
                        timeHide = false;
                    }
                }, function () {
                    timeHide = setTimeout(function () {
                        svg.find(".hover").removeClass("hover");
                        tooltip.hide();
                        timeHide = false;
                    }, 300);
                });

                for(let index in SLIDE.elements) {
                    let element = SLIDE.elements[index].element;
                    element.addClass("select");
                    element.mousemove(function (e) {
                        let shift = (parent.width() - Object.offsetWidth) / 2;
                        let topT = e.pageY;
                        if ((SLIDE.elements[i].top !== undefined) && (SLIDE.elements[i].top !== false)){
                            topT = SLIDE.elements[i].top;
                        } else {
                            SLIDE.elements[i].top = e.pageY;
                        }

                        let leftT = e.pageX;
                        if ((SLIDE.elements[i].left !== undefined) && (SLIDE.elements[i].left !== false)) {
                            leftT = SLIDE.elements[i].left;
                        } else {
                            SLIDE.elements[i].left = leftT;
                        }

                        tooltip.css({
                            top: topT + 'px',
                            left: leftT + 15 + shift + 'px'
                        });
                    }).hover(function () {
                        svg.find(".hover").removeClass("hover");
                        let getTitle = SLIDE.elements[index].title;

                        if (timeHide !== false) {
                            clearTimeout(timeHide);
                            timeHide = false;
                        }
                        tooltip.hide();

                        if (getTitle) {
                            element.addClass("hover");

                            if (SLIDE.elements[index].title) {
                                tooltip.show().html("<div>"+SLIDE.elements[index].title+"</div><a href='"+SLIDE.elements[index].url+"'>Shoppen</a>");
                            }
                        }

                    }, function () {
                        SLIDE.elements[i].top = false;
                        SLIDE.elements[i].left = false;
                        timeHide = setTimeout(function () {
                            svg.find(".hover").removeClass("hover");
                            tooltip.hide();
                            timeHide = false;
                        }, 300);
                    }).click(function () {
                        let url = SLIDE.elements[index].url;
                        if (url) location.href = SLIDE.elements[index].url;
                    });
                }
            });
        } else {
            Array.prototype.filter.call(Objects, function(Object){
                let svg = $(Object.contentDocument);

                if (svg.find("path").length) {
                    Object.classList.add("complete");
                }
            });
        }
    },100);
}

function addSpace(nStr){
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ' ' + '$2');
    }
    return x1 + x2;
}

function findAncestor (el, cls) {
    while ((el = el.parentElement) && !el.classList.contains(cls));
    return el;
}

function setAttr(prmName, val, url, response){
    response = response ? response : false;
    var res = '';
    var d = url ? url.split("#")[0].split("?") : location.href.split("#")[0].split("?");
    var base = d[0];
    var query = d[1];
    if(query) {
        var params = query.split("&");
        for(var i = 0; i < params.length; i++) {
            var keyval = params[i].split("=");
            if(keyval[0] != prmName) {
                res += params[i] + '&';
            }
        }
    }
    res += (val !== '') ? prmName + '=' + val : "";
    if (response) return base + '?' + res;
    else window.location.href = base + '?' + res;
    return false;
}

function getListSizes(preloader_block){
    $("body").on("click", ".off", function () {
        return false;
    });

    if(!preloader_block.hasClass("preloader_complete")){

        if (preloader_block.find(".circle-wert").length) {
            let operation = {
                variationDisableAll: function () {
                    let elem = preloader_block.find(".circle-wert");
                    elem.addClass("off");
                    elem.removeClass("loading");
                    preloader_block.addClass("preloader_complete");
                },
                variationEnable: function (id_, id) {
                    preloader_block.find(".circle-wert[data-eigenschaftwert_1='"+id+"']").removeClass("off");
                },
                variationActive: function () {},
                variationInfo: function () {},
                setArticleContent: function (id_, id, url) {
                    let elem = preloader_block.find(".circle-wert[data-varikindartikel='"+id+"']");
                    elem.find("a").attr("href", url);
                    elem.removeClass("loading");
                    if (!preloader_block.find(".loading").length)
                        preloader_block.addClass("preloader_complete");
                }
            };

            let first = preloader_block.find(".circle-wert:first");
            let varikindartikel = first.data("varikindartikel");
            let a = first.data("a");
            let eigenschaftwert_0 = first.data("eigenschaftwert_0");
            let eigenschaftwert_1 = first.data("eigenschaftwert_1");
            let jtl_token = $(".jtl_token").val();
            let eigenschaftwert = {};
            eigenschaftwert[eigenschaftwert_0] = eigenschaftwert_1;
            let eigenschaftwertE = {};
            eigenschaftwertE[eigenschaftwert_0] = "";

            let data = {
                "name": "checkVarkombiDependencies",
                "params": [{
                    "jtl_token": jtl_token,
                    "a": a,
                    "wke": "1",
                    "show": "1",
                    "kKundengruppe": "1",
                    "kSprache": "1",
                    "eigenschaftwert": eigenschaftwertE
                }, 0, 0]
            };

            $.ajax({
                url: "/io.php",
                method: "post",
                dataType: 'json',
                data: {io: JSON.stringify(data)},
                success: function(r){
                    for(index in r.js) {
                        let func = r.js[index];
                        func = func.replace("$.evo.article()", "operation");
                        eval(func);
                    }

                    preloader_block.find(".circle-wert:not(.off)").each(function () {
                        let varikindartikel_ = $(this).data("varikindartikel");
                        let a_ = $(this).data("a");
                        let eigenschaftwert_0_ = $(this).data("eigenschaftwert_0");
                        let eigenschaftwert_1_ = $(this).data("eigenschaftwert_1");
                        let eigenschaftwert_ = {};
                        eigenschaftwert_[eigenschaftwert_0_] = eigenschaftwert_1_;

                        let data_ = {
                            "name": "checkVarkombiDependencies",
                            "params": [{
                                "jtl_token": jtl_token,
                                "a": a_,
                                "wke": "1",
                                "show": "1",
                                "kKundengruppe": "1",
                                "kSprache": "1",
                                "eigenschaftwert": eigenschaftwert_,
                            }, eigenschaftwert_0_, eigenschaftwert_1_]
                        };

                        $.ajax({
                            url: "/io.php",
                            method: "post",
                            dataType: 'json',
                            data: {io: JSON.stringify(data_)},
                            success: function(r){
                                for(index in r.js) {
                                    let func = r.js[index];
                                    func = func.replace("$.evo.article()", "operation");
                                    eval(func);
                                }

                            }
                        });
                    });

                },
                cache: false
            });
        } else {
            preloader_block.addClass("preloader_complete");
        }
    }
}

function submitFeedback() {
    let elem = $("#feedback");
    elem.addClass("feedback_preloader");
    $.ajax({
        url: "/feedback/feedback.php",
        method: "post",
        dataType: 'json',
        data: elem.serialize(),
        success: function(r) {
            elem.find(".error").removeClass("error");
            if (r.stat !== undefined) {
                if (r.stat == "error") {
                    if (r.errors !== undefined) {
                        for(i in r.errors) {
                            elem.find("[name='"+r.errors[i]+"']").addClass("error");
                        }
                    }
                }

                if (r.stat == "success") {
                    elem.find(".feedback_form").slideUp("fast",function () {
                        elem.find(".feedback_success").slideDown("fast");
                    });
                }
            }

            setTimeout(function () {
                elem.removeClass("feedback_preloader");
            }, 1000);
        }
    });


}

function checkoutAjax(elem) {
    let action = elem.attr("action");
    action = setAttr("AJAX","1",action,true);
    let cAjax = $(".checkbox_ajax");
    cAjax.unbind();
    cAjax.click(function () {
        $(".checkbox_ajax [type='submit']").removeClass("hidden");
        $(".checkout_ajax_content").slideUp(function () {
            $(".checkout_ajax_content").html("");
        });
    });


    cAjax.addClass("feedback_preloader");

    $.ajax({
        url: action,
        method: "post",
        dataType: 'html',
        data: elem.serialize(),
        success: function (r) {
            $(".checkbox_ajax [type='submit']").addClass("hidden");
            $(".checkout_ajax_content").html("");
            $(".checkout_ajax_content").slideDown(function(){
                $(this).html(r);
            });

            cAjax.removeClass("feedback_preloader");
            $(".checkout_ajax_content input[type='radio']:first").prop("checked", true);
            $('input:not(.not-styler), select:not(.not-styler)').styler();
        }
    });
}
