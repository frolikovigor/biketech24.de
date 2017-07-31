{assign var='show_filters' value=false}
{if $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0 || count($Suchergebnisse->Artikel->elemente) >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab || $NaviFilter->nAnzahlFilter > 0}
    {assign var='show_filters' value=true}
{/if}



<div class="catalog-head">
    {block name="productlist-result-options-sort"}


        {if $show_filters}
            {if $NaviFilter->nAnzahlFilter > 0}
                <div class="filter-active">
                    <h3 class="title">Ihre Wahl:</h3>
                    <ul class="filter-active__list">
                        {if isset($NaviFilter->SuchspecialFilter->kKey) && $NaviFilter->SuchspecialFilter->kKey > 0 && (!isset($NaviFilter->Suchspecial) || $NaviFilter->Suchspecial->kKey != $NaviFilter->SuchspecialFilter->kKey)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAlleSuchspecials}" rel="nofollow" title="{lang key="specificProducts" section="global"} {lang key="delete" section="global"}">
                                    <span class="item__text">
                                         {if $NaviFilter->SuchspecialFilter->kKey == 1}
                                             {lang key="bestsellers" section="global"}
                                         {elseif $NaviFilter->SuchspecialFilter->kKey == 2}
                                             {lang key="specialOffer" section="global"}
                                         {elseif $NaviFilter->SuchspecialFilter->kKey == 3}
                                             {lang key="newProducts" section="global"}
                                         {elseif $NaviFilter->SuchspecialFilter->kKey == 4}
                                             {lang key="topOffer" section="global"}
                                         {elseif $NaviFilter->SuchspecialFilter->kKey == 5}
                                             {lang key="upcomingProducts" section="global"}
                                         {elseif $NaviFilter->SuchspecialFilter->kKey == 6}
                                             {lang key="topReviews" section="global"}
                                         {/if}
                                        &nbsp;
                                <span class="fa fa-trash-o"></span>
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                        {if !empty($NaviFilter->KategorieFilter->kKategorie)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAlleKategorien}" rel="nofollow" title="{lang key="category" section="global"} {lang key="delete" section="global"}" class="label label-info filter-type-category">
                                                                        <span class="item__text">
                                    {if $Einstellungen.navigationsfilter.kategoriefilter_anzeigen_als === 'HF' && !empty($NaviFilter->KategorieFilter->kKategorie) && $NaviFilter->KategorieFilter->kKategorie > 0}{$NaviFilter->KategorieFilter->cName}{else}{$Suchergebnisse->Kategorieauswahl[0]->cName}{/if}
                                                                            &nbsp;<span class="fa fa-trash-o"></span>
                                                                        </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                        {if !empty($NaviFilter->Hersteller->kHersteller) || !empty($NaviFilter->HerstellerFilter->kHersteller)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAlleHersteller}" rel="nofollow" title="{lang key="manufacturers" section="global"} {lang key="delete" section="global"}" class="label label-info filter-type-manufacturer">
                                    <span class="item__text">
                                    {$Suchergebnisse->Herstellerauswahl[0]->cName}
                                        &nbsp;<span class="fa fa-trash-o"></span>
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                        {if !empty($NaviFilter->PreisspannenFilter->fBis)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAllePreisspannen}" rel="nofollow" title="{lang key="rangeOfPrices" section="global"} {lang key="delete" section="global"}" class="label label-info  filter-type-pricerange">
                                    <span class="item__text">
                                    {$NaviFilter->PreisspannenFilter->cVonLocalized}
                                        - {$NaviFilter->PreisspannenFilter->cBisLocalized}
                                        &nbsp;<span class="fa fa-trash-o"></span>
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                        {if !empty($NaviFilter->BewertungFilter->nSterne)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAlleBewertungen}" rel="nofollow" title="{lang key="paginationOrderByRating" section="global"} {lang key="delete" section="global"}" class="label label-info filter-type-review">
                                    <span class="item__text">
                                    {lang key="from" section="productDetails"} {$NaviFilter->BewertungFilter->nSterne} {if $NaviFilter->BewertungFilter->nSterne > 1}{lang key="starPlural"}{else}{lang key="starSingular"}{/if}
                                        &nbsp;<span class="fa fa-trash-o"></span>
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                        {if !empty($NaviFilter->TagFilter[0]->kTag)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAlleTags}" rel="nofollow" title="{lang key="tags" section="global"} {lang key="delete" section="global"}" class="label label-info filter-type-tag">
                                    <span class="item__text">
                                    {$NaviFilter->TagFilter[0]->cName}
                                        &nbsp;<span class="fa fa-trash-o"></span>
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                        {foreach name=merkmalfilter from=$NaviFilter->MerkmalFilter item=Merkmal}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cAlleMerkmalWerte[$Merkmal->kMerkmalWert]}" rel="nofollow" title="{lang key="characteristics" section="comparelist"} {lang key="delete" section="global"}" class="label label-info filter-type-characteristic">
                                    <span class="item__text">
                                    {$Merkmal->cName|escape:'html'} &nbsp;<span class="fa fa-trash-o"></span>
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/foreach}
                        {if !empty($NaviFilter->URL->cNoFilter)}
                            {strip}
                                <li class="filter-active__item">
                                    <a class="item__link" href="{$NaviFilter->URL->cNoFilter}" title="{lang key="removeFilters" section="global"}" class="label label-warning">
                                    <span class="item__text">
                                    {lang key="removeFilters" section="global"}
                                    </span>
                                    </a>
                                </li>
                            {/strip}
                        {/if}
                    </ul>
                </div>
            {/if}
        {/if}

        <div class="catalog-sort">
            <select name="Sortierung" onchange="$('#improve_search').submit();" class="form-small">
                {if !isset($Suchergebnisse->Sortierung) || !$Suchergebnisse->Sortierung}
                    <option value="0">{lang key="sorting" section="productOverview"}</option>{/if}
                <option value="100" {if isset($smarty.session.Usersortierung) && isset($Sort) && $smarty.session.Usersortierung==$Sort->value}selected="selected"{/if}>{lang key="standard" section="global"}</option>
                {foreach name=sortierliste from=$Sortierliste item=Sort}
                    <option value="{$Sort->value}" {if $smarty.session.Usersortierung==$Sort->value}selected="selected"{/if}>{$Sort->angezeigterName}</option>
                {/foreach}
            </select>
            <select name="af" onchange="$('#improve_search').submit();" class="form-small">
                <option value="0"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 0} selected="selected"{/if}>{lang key="productsPerPage" section="productOverview"}</option>
                <option value="9"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 9} selected="selected"{/if}>9 {lang key="productsPerPage" section="productOverview"}</option>
                <option value="18"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 18} selected="selected"{/if}>18 {lang key="productsPerPage" section="productOverview"}</option>
                <option value="30"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 30} selected="selected"{/if}>30 {lang key="productsPerPage" section="productOverview"}</option>
                <option value="90"{if isset($smarty.session.ArtikelProSeite) && $smarty.session.ArtikelProSeite == 90} selected="selected"{/if}>90 {lang key="productsPerPage" section="productOverview"}</option>
            </select>
        </div>

        {if isset($oErweiterteDarstellung) && isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung) && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'}
            <div class="btn-group">
                <a href="{$oErweiterteDarstellung->cURL_arr[1]}" id="ed_list" class="btn btn-default btn-option ed list {if $oErweiterteDarstellung->nDarstellung == 1}active{/if}" role="button" title="{lang key="list" section="productOverview"}"><span class="fa fa-th-list"></span></a>
                <a href="{$oErweiterteDarstellung->cURL_arr[2]}" id="ed_gallery" class="btn btn-default btn-option ed gallery {if $oErweiterteDarstellung->nDarstellung == 2}active{/if}" role="button" title="{lang key="gallery" section="productOverview"}"><span class="fa fa-th-large"></span></a>
            </div>
        {/if}
    {/block}
</div>



