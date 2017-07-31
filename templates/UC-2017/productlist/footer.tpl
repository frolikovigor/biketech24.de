{if $Suchergebnisse->Artikel->elemente|@count > 0}
    {if $Einstellungen.navigationsfilter.allgemein_tagfilter_benutzen === 'Y'}
        {if $Suchergebnisse->Tags|@count > 0 && $Suchergebnisse->TagsJSON}
            <hr>
            <div class="panel panel-default tags">
                <div class="panel-heading">{lang key="productsTaggedAs" section="productOverview"}</div>
                <div class="panel-body">
                    {foreach name=tagfilter from=$Suchergebnisse->Tags item=oTag}
                        <a href="{$oTag->cURL}" class="label label-primary tag{$oTag->Klasse}">{$oTag->cName}</a>
                    {/foreach}
                </div>
            </div>
        {/if}
    {/if}

    {if $Einstellungen.navigationsfilter.suchtrefferfilter_nutzen === 'Y'}
        {if $Suchergebnisse->SuchFilter|@count > 0 && $Suchergebnisse->SuchFilterJSON}
            {if empty($NaviFilter->SuchFilter->kSuchanfrage)}
                <hr>
                <div class="panel panel-default tags">
                    <div class="panel-heading">{lang key="productsSearchTerm" section="productOverview"}</div>
                    <div class="panel-body">
                        {foreach name=suchfilter from=$Suchergebnisse->SuchFilter item=oSuchFilter}
                            <a href="{$oSuchFilter->cURL}" class="label label-primary tag{$oSuchFilter->Klasse}">{$oSuchFilter->cSuche}</a>
                        {/foreach}
                    </div>
                </div>
            {/if}
        {/if}
    {/if}
{/if}

{if $Suchergebnisse->Seitenzahlen->maxSeite > 1 && !empty($oNaviSeite_arr) && $oNaviSeite_arr|@count > 0}
    <div class="row">
        <div class="col-xs-6 col-md-8 col-lg-9">
            <ul class="pagination">
                {if $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}
                    <li class="prev">
                        <a href="{$oNaviSeite_arr.zurueck->cURL}">&laquo; {lang key="previous" section="productOverview"}</a>
                    </li>
                {/if}

                {foreach name=seite from=$oNaviSeite_arr item=oNaviSeite}
                    {if !isset($oNaviSeite->nBTN)}
                        <li class="page {if !isset($oNaviSeite->cURL) || $oNaviSeite->cURL|strlen === 0}active{/if}">
                            {if !empty($oNaviSeite->cURL)}
                                <a href="{$oNaviSeite->cURL}">{$oNaviSeite->nSeite}</a>
                            {else}
                                <a href="#" onclick="return false;">{$oNaviSeite->nSeite}</a>
                            {/if}
                        </li>
                    {/if}
                {/foreach}

                {if $Suchergebnisse->Seitenzahlen->AktuelleSeite < $Suchergebnisse->Seitenzahlen->maxSeite}
                    {*
                    <li>
                        .. {lang key="of" section="productOverview"} {$Suchergebnisse->Seitenzahlen->MaxSeiten}
                    </li>
                    *}
                    <li class="next">
                        <a href="{$oNaviSeite_arr.vor->cURL}">{lang key="next" section="productOverview"} &raquo;</a>
                    </li>
                {/if}
            </ul>
        </div>
    </div>
{/if}

{block name="productlist-header"}
    {if isset($oNavigationsinfo->cName) && $oNavigationsinfo->cName !== '' || isset($oNavigationsinfo->cBildURL) && !empty($oNavigationsinfo->cBildURL)}

        <div class="desc clearfix">
            {if !empty($oNavigationsinfo->cBildURL) && $oNavigationsinfo->cBildURL !== 'gfx/keinBild.gif' && $oNavigationsinfo->cBildURL !== 'gfx/keinBild_kl.gif'}
                <div class="img pull-left">
                    <img src="{$oNavigationsinfo->cBildURL}" alt="{if isset($oNavigationsinfo->oKategorie->cBeschreibung)}{$oNavigationsinfo->oKategorie->cBeschreibung|strip_tags|truncate:40|escape:"html"}{elseif isset($oNavigationsinfo->oHersteller->cBeschreibung)}{$oNavigationsinfo->oHersteller->cBeschreibung|strip_tags|truncate:40|escape:"html"}{/if}" />
                </div>
            {/if}
            {if $Einstellungen.navigationsfilter.kategorie_beschreibung_anzeigen === 'Y' && isset($oNavigationsinfo->oKategorie) && $oNavigationsinfo->oKategorie->cBeschreibung|strlen > 0}
                <div class="item_desc custom_content">{$oNavigationsinfo->oKategorie->cBeschreibung}</div>
            {/if}
            {if $Einstellungen.navigationsfilter.hersteller_beschreibung_anzeigen === 'Y' && isset($oNavigationsinfo->oHersteller) && $oNavigationsinfo->oHersteller->cBeschreibung|strlen > 0}
                <div class="item_desc custom_content">{$oNavigationsinfo->oHersteller->cBeschreibung}</div>
            {/if}
            {if $Einstellungen.navigationsfilter.merkmalwert_beschreibung_anzeigen === 'Y' && isset($oNavigationsinfo->oMerkmalWert) && $oNavigationsinfo->oMerkmalWert->cBeschreibung|strlen > 0}
                <div class="item_desc custom_content">{$oNavigationsinfo->oMerkmalWert->cBeschreibung}</div>
            {/if}
        </div>
    {/if}
{/block}
