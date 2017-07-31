
<div class="item-filtered-sec">

        <div class="item-product-sec-big">

            {include file='layout/breadcrumb.tpl'}
            <form id="buy_form" method="post" action="{$Artikel->cURLFull}" >
                {$jtl_token}

                <div class="item-product    product-primary" itemscope itemtype="http://schema.org/Product" id="product-offer">
                    <div class="item-product-title col-md-12 col-sm-12 col-xs-12">
                    <span>
                        {block name="productdetails-info-product-title"}
                            <h1 class="fn product-title" itemprop="name">{$Artikel->cName}</h1>
                        {/block}
                    </span>
                    </div>

                    {if isset($Artikel->cArtNr) || isset($Artikel->dMHD)}
                        <div class="col-xs-8">
                            <span class="text-muted product-sku">{lang key="sortProductno" section="global"}: <span itemprop="sku">{$Artikel->cArtNr}</span></span>
                            {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                                <p title="{lang key='productMHDTool' section='global'}" class="best-before text-muted">{lang key="productMHD" section="global"}: <span itemprop="best-before">{$Artikel->dMHD_de}</span></p>
                            {/if}
                        </div>
                    {/if}

                    <div class="item-product-slider col-md-6 col-sm-6 col-xs-12">
                        {include file="productdetails/image.tpl"}
                    </div>

                    <div class="item-product-info col-md-6 col-sm-6 col-xs-12">

                        {include file='productdetails/rating.tpl' total=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}


                        {assign var=price_image value=""}
                        {if isset($Artikel->Preise->strPreisGrafik_Suche)}
                            {assign var=$price_image value=$Artikel->Preise->strPreisGrafik_Suche}
                        {/if}
                        {include file="productdetails/price_card.tpl" Artikel=$Artikel price_image=$price_image tplscope=$tplscope}

                        {include file="productdetails/stock.tpl"}
                        {include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}

                        <div class="ipi-filters variations {if $simple}simple{else}switch{/if}-variations">

                            {block name="productdetails-info-hidden"}
                                <link itemprop="url" href="{$Artikel->cURLFull}" />
                                <input type="submit" name="inWarenkorb" value="1" class="hidden" />
                                {if $Artikel->kArtikelVariKombi > 0}
                                    <input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
                                {/if}
                                {if isset($Artikel->kVariKindArtikel)}
                                    <input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}" />
                                {/if}
                                {if isset($smarty.get.ek)}
                                    <input type="hidden" name="ek" value="{$smarty.get.ek|intval}" />
                                {/if}
                                <input type="hidden" id="AktuellerkArtikel" class="current_article" name="a" value="{$Artikel->kArtikel}" />
                                <input type="hidden" name="wke" value="1" />
                                <input type="hidden" name="show" value="1" />
                                <input type="hidden" name="kKundengruppe" value="{$smarty.session.Kundengruppe->kKundengruppe}" />
                                <input type="hidden" name="kSprache" value="{$smarty.session.kSprache}" />
                            {/block}

                            <!-- VARIATIONEN -->

                            {include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}

                            {include file="productdetails/basket.tpl"}

                        </div>

                        {if $Artikel->bHasKonfig}
                            <div id="product-configurator" class="product-actions top10">
                                <!-- KONFIGURATOR -->
                                {if isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELKONFIG_TPL]) && file_exists("tpl_inc/{$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELKONFIG_TPL]}")}
                                    {include file='tpl_inc/'|cat:$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELKONFIG_TPL]}
                                {else}
                                    {include file="productdetails/config.tpl"}
                                {/if}
                            </div>
                        {/if}
                    </div>
                </div>

                {include file="productdetails/matrix.tpl"}
            </form>


            <div class="item-description">
                {include file="productdetails/tabs.tpl"}

                {if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
                    {if count($Xselling->Standard->XSellGruppen) > 0 || count($Xselling->Kauf->Artikel) > 0 || count($oAehnlicheArtikel_arr)>0}
                        {block name="productdetails-recommendations"}
                            <div class="item-description__slaiders col-md-7 col-sm-7 col-xs-12">
                                {if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
                                    {foreach name=Xsell_gruppen from=$Xselling->Standard->XSellGruppen item=Gruppe}
                                        {include file='snippets/product_slider.tpl' class='x-supplies' id='slider-xsell-group-'|cat:$smarty.foreach.Xsell_gruppen.iteration productlist=$Gruppe->Artikel title=$Gruppe->Name}
                                    {/foreach}
                                {/if}

                                {if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
                                    {lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
                                    {include file='snippets/product_slider.tpl' class='x-sell' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
                                {/if}


                                {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr)>0}
                                    {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                                    {include file='snippets/product_slider.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
                                {/if}
                            </div>
                        {/block}
                    {/if}
                {/if}

            </div>
            {include file='productdetails/reviews.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}

        </div>
        <!--<div class="whitebox col-md-12 col-sm-12 col-xs-12">
    <span>Ihr Bike Ist</span>
    <span>Hier</span><img src="/dev/static/img/content/wbbike.png">
    <form class="bluebox">
        <span>HABEN SIE NICHTS GEFUNDEN?</span>
        <span>Schreiben uns und  wir Ihnen mit Wahl helfen.</span>
        <span>Sie werden werden zufrieden sein!</span>

        <input type="text" name="email" value="" placeholder="Schreiben Ihr E-Mail Addresse">
        <input type="text" name="email" value="" placeholder="Frage">
    </form>
</div>-->

</div>




<div id="article_popups">
    {include file='productdetails/popups.tpl'}
</div>






