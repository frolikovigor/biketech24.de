{if !isset($bAjaxRequest) || !$bAjaxRequest}
    {include file='layout/header.tpl'}
{/if}

{assign var='style' value='gallery'}
{if isset($oErweiterteDarstellung->nDarstellung) && isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung) && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'  && $oErweiterteDarstellung->nDarstellung == 1
|| isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht == 1}
    {assign var='style' value='list'}
{/if}


{* add u-charged *}
{if !isset($oNavigationsinfo) || isset($Suchergebnisse) && isset($oNavigationsinfo) && empty($oNavigationsinfo->cName)}
    <script type="text/javascript">
        dataLayer.push({
            'event': 'rem',
            'ecomm_itemid': [{foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}'{$Artikel->kArtikel}'{if not $smarty.foreach.artikel.last},{/if}{/foreach}],
            'ecomm_pagetype': 'searchresults'
        });
    </script>

{else}
    <script type="text/javascript">
        dataLayer.push({
            'event': 'rem',
            'ecomm_itemid': [{foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}'{$Artikel->kArtikel}'{if not $smarty.foreach.artikel.last},{/if}{/foreach}],
            'ecomm_pagetype': 'category'
        });
    </script>
{/if}
{* ------------- *}

<div id="result-wrapper" class="result-wrapper"> <!--common section -->

    <div class="flex-wrap__mobile">
        <div class="filter-type">
            {include file='layout/sidebar.tpl'}
        </div>
    </div>
        {block name="header-breadcrumb"}
            {include file='layout/breadcrumb.tpl'}
        {/block}

    <div class="col-main">
        <div class="btn-filter">
            <i class="btn-filter__i"></i>
            <span class="btn-filter__text">filter</span>
        </div>
        <div class="col-main__wrap">
            {block name="productlist-header"}
                {include file='productlist/header.tpl'}
            {/block}

            <div class="catalog-items">
                <ul class="catalog-items__list">
                    {foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}
                        {if $style === 'list'}
                            {include file='productlist/item_list.tpl' tplscope=$style}
                        {else}
                            {include file='productlist/item_box.tpl' tplscope=$style class='thumbnail'}
                        {/if}
                    {/foreach}
                </ul>
            </div>

            {block name="productlist-footer"}
                {include file='productlist/footer.tpl'}
            {/block}

        </div>
    </div>
    <div class="filter-type">
        {include file='layout/sidebar.tpl'}
    </div>

    <div class="bike-page">

    </div>

</div>




{if !isset($bAjaxRequest) || !$bAjaxRequest}
    {include file='layout/footer.tpl'}
{/if}