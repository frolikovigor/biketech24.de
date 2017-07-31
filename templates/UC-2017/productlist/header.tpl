{block name="productlist-header"}
    {if isset($oNavigationsinfo) && ($oNavigationsinfo->cName !== '' || $oNavigationsinfo->cBildURL)}
        <div class="title">{if $oNavigationsinfo->cName}<h1>{$oNavigationsinfo->cName}</h1>{/if}</div>
    {/if}
{/block}

    {if !isset($oNavigationsinfo) || isset($Suchergebnisse) && isset($oNavigationsinfo) && empty($oNavigationsinfo->cName)}
        <h1>{$Suchergebnisse->SuchausdruckWrite}</h1>
    {/if}

    {if !empty($hinweis)}
        <div class="alert alert-success">{$hinweis}</div>
    {/if}
    {if !empty($fehler)}
        <div class="alert alert-danger">{$fehler}</div>
    {/if}

    {if isset($Suchergebnisse->SucheErfolglos) && $Suchergebnisse->SucheErfolglos == 1}
        <div class="alert alert-info">{lang key="noResults" section="productOverview"}</div>
        <form id="suche2" action="navi.php" method="get" class="form">
            <fieldset>
                <ul class="list-unstyled">
                    <li class="form-group">
                        <label for="searchkey">{lang key="searchText" section="global"}</label>
                        <input type="text" class="form-control" name="suchausdruck" value="{if isset($Suchergebnisse->cSuche)}{$Suchergebnisse->cSuche|escape:'htmlall'}{/if}" id="searchkey" />
                    </li>
                    <li class="form-group">
                        <input type="submit" value="{lang key="searchAgain" section="productOverview"}" class="submit btn-d" />
                    </li>
                </ul>
            </fieldset>
        </form>
    {/if}

    {include file="snippets/extension.tpl"}

    {block name="productlist-subcategories"}
        {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'N' && $oUnterKategorien_arr|@count > 0}
            <div class="row row-eq-height content-cats-small clearfix">
                {foreach name=unterkats from=$oUnterKategorien_arr item=Unterkat}
                    <div class="col-xs-6 col-md-4 col-lg-3">
                        <div class="thumbnail">
                            <a href="{$Unterkat->cURL}">
                                {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'Y'}<img src="{$Unterkat->cBildURL}" alt="{$Unterkat->cName}" />{/if}</a>
                            {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'B'}<div class="caption text-center"><a href="{$Unterkat->cURL}">{$Unterkat->cName}</a></div>{/if}
                            {if $Einstellungen.navigationsfilter.unterkategorien_beschreibung_anzeigen === 'Y'}
                                <p class="item_desc small text-muted">{$Unterkat->cBeschreibung|strip_tags|truncate:68}</p>
                            {/if}
                            {if $Einstellungen.navigationsfilter.unterkategorien_lvl2_anzeigen === 'Y'}
                                {if isset($Unterkat->Unterkategorien) && $Unterkat->Unterkategorien|@count > 0}
                                    <hr class="hr-sm">
                                    <ul class="list-unstyled small subsub">
                                        {foreach from=$Unterkat->Unterkategorien item=UnterUnterKat}
                                            <li>
                                                <a href="{$UnterUnterKat->cURL}" title="{$UnterUnterKat->cName}">{$UnterUnterKat->cName}</a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                {/if}
                            {/if}
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}
    {/block}

    {include file="productwizard/index.tpl"}

    {if count($Suchergebnisse->Artikel->elemente) > 0}
        <form id="improve_search" action="navi.php" method="get" class="form-inline clearfix">
            {if isset($NaviFilter->Kategorie->kKategorie) && $NaviFilter->Kategorie->kKategorie > 0}
                <input type="hidden" name="k" value="{$NaviFilter->Kategorie->kKategorie}" />{/if}
            {if isset($NaviFilter->Hersteller->kHersteller) && $NaviFilter->Hersteller->kHersteller > 0}
                <input type="hidden" name="h" value="{$NaviFilter->Hersteller->kHersteller}" />{/if}
            {if isset($NaviFilter->Suchanfrage->kSuchanfrage) && $NaviFilter->Suchanfrage->kSuchanfrage > 0}
                <input type="hidden" name="l" value="{$NaviFilter->Suchanfrage->kSuchanfrage}" />{/if}
            {if isset($NaviFilter->MerkmalWert->kMerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert > 0}
                <input type="hidden" name="m" value="{$NaviFilter->MerkmalWert->kMerkmalWert}" />{/if}
            {if isset($NaviFilter->Suchspecial->kKey) && $NaviFilter->Suchspecial->kKey > 0}
                <input type="hidden" name="q" value="{$NaviFilter->Suchspecial->kKey}" />{/if}
            {if isset($NaviFilter->SuchspecialFilter->kKey) && $NaviFilter->SuchspecialFilter->kKey > 0}
                <input type="hidden" name="qf" value="{$NaviFilter->SuchspecialFilter->kKey}" />{/if}
            {if isset($NaviFilter->Suche->cSuche) && $NaviFilter->Suche->cSuche|count > 0}
                <input type="hidden" name="suche" value="{$NaviFilter->Suche->cSuche|escape:'htmlall'}" />{/if}
            {if isset($NaviFilter->Tag->kTag) && $NaviFilter->Tag->kTag > 0}
                <input type="hidden" name="t" value="{$NaviFilter->Tag->kTag}" />{/if}
            {if isset($NaviFilter->MerkmalFilter) && is_array($NaviFilter->MerkmalFilter)}
                {foreach name=merkmalfilter from=$NaviFilter->MerkmalFilter item=mmfilter}
                    <input type="hidden" name="mf{$smarty.foreach.merkmalfilter.iteration}" value="{$mmfilter->kMerkmalWert}" />
                {/foreach}
            {/if}
            {if isset($cJTLSearchStatedFilter_arr) && is_array($cJTLSearchStatedFilter_arr)}
                {foreach name=jtlsearchstatedfilter from=$cJTLSearchStatedFilter_arr key=key item=cJTLSearchStatedFilter}
                    <input name="fq{$key}" type="hidden" value="{$cJTLSearchStatedFilter}" />
                {/foreach}
            {/if}
            {if isset($NaviFilter->TagFilter) && is_array($NaviFilter->TagFilter)}
                {foreach name=tagfilter from=$NaviFilter->TagFilter item=tag}
                    <input type="hidden" name="tf{$smarty.foreach.tagfilter.iteration}" value="{$tag->kTag}" />
                {/foreach}
            {/if}
            {if isset($NaviFilter->SuchFilter) && is_array($NaviFilter->SuchFilter)}
                {foreach name=suchfilter from=$NaviFilter->SuchFilter item=oSuche}
                    <input type="hidden" name="sf{$smarty.foreach.suchfilter.iteration}" value="{$oSuche->kSuchanfrage}" />
                {/foreach}
            {/if}


            {include file='productlist/result_options.tpl'}



        </form>
    {/if}

    {if $Suchergebnisse->Artikel->elemente|@count <= 0 && isset($KategorieInhalt)}
        {if isset($KategorieInhalt->TopArtikel->elemente)}
            {lang key="topOffer" section="global" assign='slidertitle'}
            {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$KategorieInhalt->TopArtikel->elemente title=$slidertitle}
        {/if}

        {if isset($KategorieInhalt->BestsellerArtikel->elemente)}
            {lang key="bestsellers" section="global" assign='slidertitle'}
            <div class="item-description">
                {include file='snippets/product_slider.tpl' id='slider-bestseller-products' productlist=$KategorieInhalt->BestsellerArtikel->elemente title=$slidertitle}
            </div>

        {/if}
    {/if}

    {if $Suchergebnisse->GesamtanzahlArtikel > 0}
        <div class="row list-pageinfo top10">
            <div class="col-xs-4 page-current">
                <strong>{lang key="page" section="productOverview"} {$Suchergebnisse->Seitenzahlen->AktuelleSeite}</strong> {lang key="of" section="productOverview"} {$Suchergebnisse->Seitenzahlen->MaxSeiten}
            </div>
            <div class="col-xs-8 page-total text-right">
                {lang key="products" section="global"} {$Suchergebnisse->ArtikelVon} - {$Suchergebnisse->ArtikelBis} {lang key="of" section="productOverview"} {$Suchergebnisse->GesamtanzahlArtikel}
            </div>
        </div>
    {/if}
























