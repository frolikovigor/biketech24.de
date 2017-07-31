<li class="goods">
    <div class="goods__long">
        <div class="goods__photo">
            <a class="image-wrapper" href="{$Artikel->cURL}">
                {if isset($Artikel->Bilder[0]->cAltAttribut)}
                    {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
                {else}
                    {assign var="alt" value=$Artikel->cName}
                {/if}

                {include file="snippets/image.tpl" src=$Artikel->Bilder[0]->cPfadKlein alt=$alt}
            </a>
        </div>
        <div class="goods__desc">
            <!--<ul class="stock__list">
                <li>
                    <a href="#">
                        <span class="stock__name">2 Farbe<span class="slash">/</span></span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="stock__name"> 3 Gr��e</span><span>/</span>
                    </a>
                </li>
            </ul>-->

            <div class="silver-star silver-star_catalog">
                <span class="gold-star" style="width: {$Artikel->fDurchschnittsBewertung * 100 / 5}%"></span>
            </div>
            <hr>

            <div class="goods__brand">
                <span>{$Artikel->cHersteller}</span>
            </div>

            <div class="goods__title">
                <a href="{$Artikel->cURL}">
                    <h2>{$Artikel->cName}</h2>
                </a>

            </div>

            {assign var=price_image value=""}
            {if isset($Artikel->Preise->strPreisGrafik_Suche)}
                {assign var=$price_image value=$Artikel->Preise->strPreisGrafik_Suche}
            {/if}
            {include file="productdetails/price.tpl" Artikel=$Artikel price_image=$price_image tplscope=$tplscope}

            <div class="filter-parameters js-slide_toggle__block block-sizes preloader_block">
                <ul class="parameters__list parameters__list_size preloader_content">
                    {foreach name=Variationen from=$Artikel->Variationen key=i item=Variation}
                        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                            {if $Variation->cName == "Farbe"}
                                <li class="circle circle-wert circle_{transliteration($Variationswert->cName)}" data-varikindartikel="{$Variationswert -> oVariationsKombi -> kArtikel}" data-a="{$Artikel -> kArtikel}" data-eigenschaftwert_0="{$Variationswert->kEigenschaft}" data-eigenschaftwert_1="{$Variationswert->kEigenschaftWert}">
                                    <a href="#"></a>
                                </li>
                            {else}
                                <li class="circle-wert rectangle" data-varikindartikel="{$Variationswert -> oVariationsKombi -> kArtikel}" data-a="{$Artikel -> kArtikel}" data-eigenschaftwert_0="{$Variationswert->kEigenschaft}" data-eigenschaftwert_1="{$Variationswert->kEigenschaftWert}">
                                    <a href="#">
                                        <span>{$Variationswert -> cName}</span>
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    {/foreach}




                </ul>
                <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
            </div>
        </div>
    </div>
</li>


