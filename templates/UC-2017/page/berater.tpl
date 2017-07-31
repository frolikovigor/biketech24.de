{beraterExecute()}

<section class="berater">
    <div class="steps-circle">

        <div class="line"></div>

        <div class="s-circle active s-circle_active" data-tab="1">
            <div class="num">
                <span>1</span>
            </div>
            <div class="check">
                <i class="icons icons_white-check"></i>
            </div>
        </div>

        <div class="s-circle" data-tab="2">
            <div class="num">
                <span>2</span>
            </div>
            <div class="check">
                <i class="icons icons_white-check"></i>
            </div>
        </div>

        <div class="s-circle" data-tab="3">
            <div class="num">
                <span>3</span>
            </div>
            <div class="check">
                <i class="icons icons_white-check"></i>
            </div>
        </div>
    </div>

    <form id="berater__form" method="post" action="/berater" class="berater-form">
        <input id="berater__gender_input" type="hidden" name="mf1" value="" />

        <div data-tab="1" data-tab_block="berater" class="active">
            <div class="gender">
                <h2>Wähle bitte dein Geschlecht:</h2>
                <ul>
                    <li>
                        <a href="#" class="gender__link gender__link_frau" data-id="10">Frau</a>
                    </li>
                    <li>
                        <a href="#" class="gender__link gender__link_man" data-id="11">Mann</a>
                    </li>
                    {*<li>*}
                        {*<a href="#" class="gender__link gender__link_kind" data-id="13">Kind</a>*}
                    {*</li>*}
                </ul>
            </div>
        </div>

        <div data-tab="2">
            <h2>Wähle bitte deine schrittgröße:</h2>
            <div class="berater-form__wrap">
                <img src="{$currentTemplateDir}images/berater.jpg" />
                <div class="berater-form__input">
                    <div class="input__box input__box_step">
                        <div class="input__data">
                            <label for="step">Schrittgröße cm</label>
                            <input type="text" name="step" id="step" class="check step" value="70" data-min="20" data-max="120">
                        </div>
                        <div class="input__count">
                            <div class="count__increment">
                                <input type="button" value="+">
                            </div>
                            <div class="count__reduce">
                                <input type="button" value="-">
                            </div>
                        </div>
                    </div>
                    <div class="btn-blocks">
                        <input id="btn-d" class="btn-d" type="button" value="Weiter">
                    </div>
                </div>
            </div>


        </div>


        <div data-tab="3">
            <input id="berater__category" type="hidden" name="k" value="1" />
            <input id="berater__category_cname" type="hidden" name="k_cname" value="Cityrader" />
            <h2>Wähle bitte dein gewünschten Fahrradtyp:</h2>
            {get_category_array categoryId=1 assign='categories'}

            {foreach name='sub_categories' from=$categories item='sub'}
                {assign var="translit" value=transliteration($sub->cKurzbezeichnung)}
                {assign var="url" value=fileExist("`$currentTemplateDir`images/menu/`$translit`.svg")}

                {if $translit == "Cityrader"
                    or $translit == "Crossrader"
                    or $translit == "Rennrader"
                    or $translit == "MTB_(Mountainbikes)"
                    or $translit == "Trekkingrader"
                }
                    <div class="berater__sub_item" data-img="{$translit}" data-id="{$sub->kKategorie}" data-name="{$translit}">
                        <div class="berater__sub_img" data-img="{$translit}">
                            <img class="svg" src="{$url}" />
                        </div>
                        <div class="berater__sub_title">
                            {$sub->cKurzbezeichnung}
                        </div>
                    </div>
                {/if}

            {/foreach}
        </div>
    </form>


</section>

<script>

    jQuery("[data-tab]").each(function () {
        $(this).click(function () {
            var active = jQuery("[data-tab].active").index();
            if ((jQuery(this).index() < active) || (active == -1)) {
                var id = $(this).data("tab");
                $("[data-tab]").removeClass("active");
                $("[data-tab='" + id + "']").addClass("active");
                active = id;
            }


            jQuery("[data-tab]").removeClass("s-circle_active").removeClass("s-circle_done");

            for(var index = active-1; index > 0; index--) {
                jQuery("[data-tab='"+index+"']").addClass("s-circle_done");
            }
            jQuery("[data-tab='"+active+"']").addClass("s-circle_active");
        });
    });

    jQuery(".berater .gender__link").click(function (e) {
        jQuery(".berater .gender__link").removeClass("active");
        jQuery(this).addClass("active");
        e.preventDefault();
        var id = jQuery(this).data("id");
        jQuery("#berater__gender_input").val(id);
        setTimeout(function () {
            $("[data-tab]").removeClass("active");
            jQuery("[data-tab='2']").click();
        },100);
    });

    jQuery("#btn-d").click(function () {
        setTimeout(function () {
            $("[data-tab]").removeClass("active");
            jQuery("[data-tab='3']").click();
        },100);
    });

    jQuery(".berater__sub_item").click(function () {
        var id = $(this).data("id");
        var name = $(this).data("name")
        var form = $("#berater__form");
        $("#berater__category").val(id);
        $("#berater__category_cname").val(name);

        location.href = form.attr("action") + "?request=" + encodeURIComponent($("#berater__form").serialize());
        //$("#berater__form").submit();
    });

</script>