{if !isset($bAjaxRequest) || !$bAjaxRequest}
    {include file='layout/header.tpl'}
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
{/if}
{* ------------- *}

<div id="result-wrapper">
    {include file='productlist/header.tpl'}
    {assign var="style" value="gallery"}
	{assign var="grid" value="col-xs-6 col-lg-4"}
    {if isset($oErweiterteDarstellung) && isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung) && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'}
        {if $oErweiterteDarstellung->nDarstellung == 1}
            {assign var="style" value="list"}
            {assign var="grid" value="col-xs-12"}
        {elseif $oErweiterteDarstellung->nDarstellung == 2}
            {assign var="style" value="gallery"}
            {assign var="grid" value="col-xs-6 col-lg-4"}
        {elseif $oErweiterteDarstellung->nDarstellung == 3}
            {assign var="style" value="mosaic"}
            {assign var="grid" value="col-xs-6 col-lg-3"}
        {/if}
    {/if}
    {if isset($Suchergebnisse->Fehler)}
        <p class="alert alert-danger">{$Suchergebnisse->Fehler}</p>
    {/if}
    <div class="row {if $style !== 'list'}row-eq-height row-eq-img-height{/if} {$style}">
        {foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}
            <div class="product-wrapper {$grid}">
                {if $style === 'list'}
                    {include file='productlist/item_list.tpl' tplscope=$style}
                {else}
                    {include file='productlist/item_box.tpl' tplscope=$style class='thumbnail'}
                {/if}
            </div>
        {/foreach}
    </div>
    {include file='productlist/footer.tpl'}
</div>
{if !isset($bAjaxRequest) || !$bAjaxRequest}
    {include file='layout/footer.tpl'}
{/if}