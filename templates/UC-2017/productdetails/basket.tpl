{if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
 
    <div id="add-to-cart" class="product-buy{if $Artikel->nErscheinendesProdukt} coming_soon{/if}">

        {assign var="basket_items" value=[]}

        {foreach $smarty.session.Warenkorb->PositionenArr as $item}
            {$basket_items[$item->kArtikel] = $item->nAnzahl}
        {/foreach}

        {assign var="currentId" value=$Artikel->kArtikel}
        {if $Artikel->kVariKindArtikel}
            {assign var="currentId" value=$Artikel->kVariKindArtikel}
        {/if}

        {assign var="InTheBasket" value=isset($basket_items[$currentId])}

        {block name="add-to-cart"}
            {if $Artikel->nErscheinendesProdukt}
                <div class="{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}alert alert-warning coming_soon{/if} text-center">
                    {lang key="productAvailableFrom" section="global"}: <strong>{$Artikel->Erscheinungsdatum_de}</strong>
                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
                        ({lang key="preorderPossible" section="global"})
                    {/if}
                </div>
            {/if}

            {* add u-charged *}
            <script>
                var selectErrorFieldsStat = false;
                function selectErrorFields(element){
                    //check radio or select

                    $(".variations .required").each(function () {
                        let elem = $(this);

                        elem.addClass("error");
                        setTimeout(function () {
                            elem.removeClass("error");
                        }, 400);

                        $(this).find("input, select").each(function(){
                            if ($(this).val()) {
                                elem.removeClass("error");
                            }
                        });
                    });

                    if (!$(".variations .required.error").length) {
                        element.closest(".preloader_block").removeClass("preloader_complete");
                        element.closest("form").submit();
                    }
                }
            </script>


            {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}

                <p class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</p>

                <div class="form-inline">
                    <div id="quantity-grp" class="choose_quantity input-group selectErrorFields">
                        <span class="input-group-btn ipi-buttons preloader_block preloader_complete">
                            <input type="hidden" name="anzahl" value="1" />

                            {if $InTheBasket}<a href="{get_static_route id='warenkorb.php'}">{/if}
                            <button name="inWarenkorb" onclick="{if !$InTheBasket}selectErrorFields($(this)){/if}"
                                    type="button"
                                    value="{lang key="addToCart" section="global"}"
                                    class="submit btn-d disabled btn-item-product"
                            >
                                <div class="preloader_content">
                                    <span class="fa fa-shopping-cart visible-xs"></span>
                                    <span class="">
                                        {if $InTheBasket}
                                            im Korb ({$basket_items[$currentId]})
                                        {else}
                                            {lang key="addToCart" section="global"}
                                        {/if}
                                    </span>
                                </div>
                                <span class="preloader">Warten Sie bitte...</span>
                            </button>

                            {if $InTheBasket}</a>{/if}
                        </span>
                    </div>
                </div>

            {elseif $Artikel->inWarenkorbLegbar == 1 && !$Artikel->oKonfig_arr}

                {if !$showMatrix}
                    <div class="ipi-buttons preloader_block preloader_complete">
                        <input type="hidden" name="anzahl" value="1" />
                        {if $InTheBasket}
                            <a href="{get_static_route id='warenkorb.php'}">
                        {else}
                            <div id="quantity-grp" class="choose_quantity ">
                                <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}" min="0"{if $Artikel->fAbnahmeintervall > 0} required step="{$Artikel->fAbnahmeintervall}"{/if}
                                       id="quantity" class="quantity text-right" name="anzahl"
                                       value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}" />
                                {if $Artikel->cEinheit}
                                    <span class="unit">{$Artikel->cEinheit}</span>
                                {/if}
                            </div>
                        {/if}

                        <button class="submit btn-item-product" type="button" onclick="{if !$InTheBasket}selectErrorFields($(this)){/if}">
                            <div class="preloader_content">
                                {if $InTheBasket}
                                    im Korb ({$basket_items[$currentId]})
                                {else}
                                    {lang key="addToCart" section="global"}
                                {/if}
                            </div>
                            <span class="preloader">Warten Sie bitte...</span>
                        </button>

                        {if $InTheBasket}</a>{/if}

                        {if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
                            {include file="productdetails/actions.tpl"}
                        {/if}
                    </div>
                {/if}

                {if $Artikel->fMindestbestellmenge > 1 || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y') || $Artikel->fAbnahmeintervall > 0 || $Artikel->cTeilbar === 'Y' || (isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]) && $Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE] > 0)}
                    <div class="clearfix"></div>
                    <div class="purchase-info alert alert-info top10" role="alert">
                        {assign var="units" value=$Artikel->cEinheit}
                        {if empty($Artikel->cEinheit) || $Artikel->cEinheit|@count_characters == 0}
                            <p>{lang key="units" section="productDetails" assign="units"}</p>
                        {/if}

                        {if $Artikel->fMindestbestellmenge > 1 || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y')}
                            {lang key="minimumPurchase" section="productDetails" assign="minimumPurchase"}
                            <p>{$minimumPurchase|replace:"%d":$Artikel->fMindestbestellmenge|replace:"%s":$units}</p>
                        {/if}

                        {if $Artikel->fAbnahmeintervall > 0}
                            {lang key="takeHeedOfInterval" section="productDetails" assign="takeHeedOfInterval"}
                            <p>{$takeHeedOfInterval|replace:"%d":$Artikel->fAbnahmeintervall|replace:"%s":$units}</p>
                        {/if}

                        {if $Artikel->cTeilbar === 'Y'}
                            <p>{lang key="integralQuantities" section="productDetails"}</p>
                        {/if}

                        {if isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]) && $Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE] > 0}
                            {lang key="maximalPurchase" section="productDetails" assign="maximalPurchase"}
                            <p>{$maximalPurchase|replace:"%d":$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]|replace:"%s":$units}</p>
                        {/if}
                    </div>
                {/if}
            {/if}
        {/block}
    </div>
{/if}


{*{if !$Artikel->Variationen|@count}*}
    {*<div class="alert alert-warning text-transform_normal">*}
        {*der Artikel ist momentan nicht verfügbar*}
    {*</div>*}
{*{/if}*}