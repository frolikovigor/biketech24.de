{if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0 && isset($Artikel->nIstVater)}
    {assign var="oVariationKombi_arr" value=$Artikel->getChildVariations()}

            {* add u-charged*}
            {assign var="needSelected" value=true}
            {* ------------ *}



            {foreach name=Variationen from=$Artikel->Variationen key=i item=Variation}
                {if $Variation->cName == "Größe" or $Variation->cName == "Dimension"}

                    <div class="helpo">
                        <div class="switch-ul-help">
                            <div class="block-sizes block-sizes_autoload preloader_block {if $Variation->cTyp !== 'FREIFELD' && !$showMatrix} required{/if}">

                                <div class="li-title">
                                    <h4>
                                        {$Variation->cName}

                                        {assign var='activeId' value=$Artikel->gibKategorie()}
                                        {get_category_parents categoryId=$activeId assign='activeParents'}
                                        {if ($activeParents[0]->kKategorie == 1) or ($activeId == 1)}
                                            <a class="item-filtered-sec__berater block__question" href="/Berater">hilfe mit größe?</a>
                                        {/if}
                                    </h4>
                                </div>

                                <ul class="parameters__list parameters__list_size preloader_content " data-limit="2">
                                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                        {assign var="bSelected" value=false}
                                        {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                            {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {/if}
                                        {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                            {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                        {/if}

                                        <li class="circle-wert rectangle {if $bSelected} active{/if}" data-varikindartikel="{$Variationswert -> oVariationsKombi -> kArtikel}" data-a="{$Artikel -> kArtikel}" data-eigenschaftwert_0="{$Variationswert->kEigenschaft}" data-eigenschaftwert_1="{$Variationswert->kEigenschaftWert}">
                                            <a href="#">
                                                <span>{$Variationswert -> cName}</span>
                                            </a>
                                            {if $bSelected} <input type="hidden" name="eigenschaftwert[{$Variation->kEigenschaft}]" value="{$Variationswert->kEigenschaftWert}" />{/if}
                                        </li>


                                    {/foreach}
                                    {*<li class="li-plus">
                                        <a href="#" class="rectangle">
                                            <span>+</span>
                                        </a>
                                    </li>*}
                                </ul>
                                <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
                            </div>
                        </div>
                    </div>

                {elseif $Variation->cName == "Farbe"}
                    <div class="helpo">
                        <div class="switch-ul-help block-sizes_autoload preloader_block {if $Variation->cTyp !== 'FREIFELD' && !$showMatrix} required{/if}">

                            <div class="li-title">
                                <h4>Farbe</h4>
                            </div>

                            <ul class="parameters__list parameters__list_color preloader_content" data-limit="2">
                                {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                    {assign var="bSelected" value=false}
                                    {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {/if}
                                    {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                        {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                    {/if}

                                    <li class="circle circle-wert  {if $bSelected} active{/if} circle_{transliteration($Variationswert->cName|escape:'html')}" data-varikindartikel="{$Variationswert -> oVariationsKombi -> kArtikel}" data-a="{$Artikel -> kArtikel}" data-eigenschaftwert_0="{$Variationswert->kEigenschaft}" data-eigenschaftwert_1="{$Variationswert->kEigenschaftWert}">
                                        <a href="#"></a>
                                    </li>

                                    {if $bSelected} <input type="hidden" name="eigenschaftwert[{$Variation->kEigenschaft}]" value="{$Variationswert->kEigenschaftWert}" />{/if}
                                {/foreach}
                                {*<li class="li-plus">
                                    <a href="#" class="circle">
                                        <span>+</span>
                                    </a>
                                </li>*}
                            </ul>
                            <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
                        </div>
                    </div>
                {else}
                    <dt>{$Variation->cName}{if $Variation->cTyp === 'IMGSWATCHES'} <span class="swatches-selected text-muted" data-id="{$Variation->kEigenschaft}"></span>{/if}</dt>
                    <dd class="form-group{if $Variation->cTyp !== 'FREIFELD' && !$showMatrix} required{/if}">
                        {if $Variation->cTyp === 'SELECTBOX'}
                            <div class="select-formstyler-content">
                                <select class="not-styler" title="{lang key="pleaseChooseVariation" section="productDetails"}" name="eigenschaftwert[{$Variation->kEigenschaft}]"{if !$showMatrix} required{/if}>
                                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                        {assign var="bSelected" value=false}
                                        {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                            {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {/if}
                                        {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                        $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                        !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                        {else}
                                            {include file="productdetails/variation_value.tpl" assign="cVariationsWert"}
                                            <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                                                    data-type="option"
                                                    data-original="{$Variationswert->cName}"
                                                    data-key="{$Variationswert->kEigenschaft}"
                                                    data-value="{$Variationswert->kEigenschaftWert}"
                                                    data-content="{changeQuotes($cVariationsWert|escape:'html')}"
                                                    {if !empty($Variationswert->cBildPfadMini)}
                                                        data-list='{prepare_image_details item=$Variationswert json=true}'
                                                        data-title='{$Variationswert->cName}'
                                                    {/if}
                                                    {if $bSelected}selected="selected"{/if}>
                                                {$cVariationsWert|trim}
                                            </option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        {elseif $Variation->cTyp === 'RADIO'}
                            {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                {assign var="bSelected" value=false}
                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                {/if}
                                {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                {else}
                                    <label class="variation" for="vt{$Variationswert->kEigenschaftWert}"
                                           data-type="radio"
                                           data-original="{$Variationswert->cName}"
                                           data-key="{$Variationswert->kEigenschaft}"
                                           data-value="{$Variationswert->kEigenschaftWert}">
                                        <input type="radio"
                                               name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                               id="vt{$Variationswert->kEigenschaftWert}"
                                               value="{$Variationswert->kEigenschaftWert}"

                                                {* add u-charged ----------- *}
                                                {*{getAvailability id=$Variationswert->oVariationsKombi->kArtikel assign='available'}*}

                                                {*{if count($oVariationKombi_arr)}*}
                                                {*{if $bSelected}checked="checked"{/if}*}
                                                {*{else}*}
                                                {*{if $available == '1'}*}
                                                {*data-available="1"*}
                                                {*{if $needSelected}checked="checked"{/if}*}
                                                {*{if $needSelected}*}
                                                {*{assign var="needSelected" value=false}*}
                                                {*{/if}*}

                                                {*{/if}*}
                                                {*{/if}*}
                                                {* ------------------------- *}


                                                {* comment u-charged *}
                                                {if $bSelected}checked="checked"{/if}


                                                {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                        >
                                        {include file="productdetails/variation_value.tpl"}
                                    </label>
                                {/if}
                            {/foreach}
                        {elseif $Variation->cTyp === 'IMGSWATCHES' || $Variation->cTyp === 'TEXTSWATCHES'}
                            <div class="btn-group swatches {$Variation->cTyp|lower}">
                                {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                    {assign var="bSelected" value=false}
                                    {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {/if}
                                    {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                    $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                    !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                        {* /do nothing *}
                                    {else}
                                        <label class="variation block btn btn-default{if $bSelected} active{/if}"
                                               data-type="swatch"
                                               data-original="{$Variationswert->cName}"
                                               data-key="{$Variationswert->kEigenschaft}"
                                               data-value="{$Variationswert->kEigenschaftWert}"
                                               for="vt{$Variationswert->kEigenschaftWert}">
                                            <input type="radio"
                                                   class="control-hidden"
                                                   name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                   id="vt{$Variationswert->kEigenschaftWert}"
                                                   value="{$Variationswert->kEigenschaftWert}"
                                                   {if $bSelected}checked="checked"{/if}
                                                    {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                            />
                                            <span class="label-variation">
                                            {if !empty($Variationswert->cBildPfadMini)}
                                                <img src="{$Variationswert->cBildPfadMini}" alt="{$Variationswert->cName|escape:'quotes'}"
                                                     data-list='{prepare_image_details item=$Variationswert json=true}'
                                                     title="{$Variationswert->cName}" />
                                            {else}
                                                {$Variationswert->cName}
                                            {/if}
                                        </span>
                                            {include file="productdetails/variation_value.tpl" hideVariationValue=true}
                                        </label>
                                    {/if}
                                {/foreach}
                            </div>
                        {elseif $Variation->cTyp === 'FREIFELD' || $Variation->cTyp === 'PFLICHT-FREIFELD'}
                            <input type="text"
                                   class="form-control"
                                   name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                   data-key="{$Variation->kEigenschaft}"{if $Variation->cTyp === 'PFLICHT-FREIFELD'} required{/if}>
                        {/if}
                    </dd>


                {/if}







            {/foreach}





{/if}