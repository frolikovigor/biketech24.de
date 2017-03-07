{if !empty($cFehler)}
    <div class="alert alert-danger">{$cFehler}</div>
{/if}

{include file="productwizard/index.tpl"}

{* add u-charged *}
<script type="text/javascript">
    dataLayer.push({
        'event': 'rem',
        'ecomm_itemid': '',
        'ecomm_pagetype': 'home',
        'ecomm_totalvalue': ''
    });
</script>
{* ------------- *}

<div id="smallbanner">
	<div class="row">
		<div class="col-md-4 col-sm-6 col-sx-12">
			<a href="/Mulebar"><img class="img-responsive" src="/mediafiles/Bilder/smallbanner/20160603_mulebar.jpg"></a>
		</div>
		<div class="col-md-4 col-sm-6 col-sx-12">
			<a href="/Lazer"><img class="img-responsive" src="/mediafiles/Bilder/smallbanner/20160421_lazer.jpg"></a>
		</div>
		<div class="col-md-4 col-md-offset-0 col-sm-6 col-sm-offset-3 col-sx-12">
			<a href="/Nutrixxion"><img class="img-responsive" src="/mediafiles/Bilder/smallbanner/20160603_nutrixion.jpg"></a>
		</div>
	</div>
</div>

{get_category_list cKatAttrib='frontpage_bt24' cAssign='topArtikelCategory'}
{if $topArtikelCategory|@count > 0}
	<div id="topArtikel">
		{foreach name=topArtikelCategoryItem from=$topArtikelCategory item=CategoryItem}	
			{get_product_list kKategorie=$CategoryItem->kKategorie nLimit=$CategoryItem->KategorieAttribute.anzahl cAssign="topArtikel"}
			<div class="row">
				{foreach name=topArtikelItem from=$topArtikel item=Artikel}
					<div class="product-wrapper col-md-4 col-sm-6 col-xs-12">
						<div class="product-cell text-center">
							<div class="caption">    
								<h4 class="title"><a href="{$Artikel->cURL}">{$Artikel->cName|html_entity_decode|truncate:50}</a></h4>
							</div>{* /caption *}
							<a class="image-wrapper" href="{$Artikel->cURL}">
								{if isset($Artikel->Bilder[0]->cAltAttribut)}
									{assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|escape:"quotes"|truncate:60}
								{else}
									{assign var="alt" value=$Artikel->cName}
								{/if}

								{include file="snippets/image.tpl" src=$Artikel->Bilder[0]->cPfadNormal alt=$alt} 

							</a>
							<div class="produktbeschreibung">    
								{$Artikel->cKurzBeschreibung}
								<div class="fadeout"></div>
							</div>
							<div class="caption">    
								{if $Artikel->fDurchschnittsBewertung > 0}{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}{/if}<br>
								{include file="productdetails/price.tpl" Artikel=$Artikel price_image=$Artikel->Preise->strPreisGrafik_Suche tplscope=$tplscope}
							</div>{* /caption *}
							{if $Artikel->fUVP>$Artikel->Preise->fVKBrutto || $Artikel->Preise->Sonderpreis_aktiv}
								<div class="prozent">
									<span class="fa fa-certificate" aria-hidden="true"></span>
									<div class="prozent-wert">
										{if $Artikel->Preise->Sonderpreis_aktiv}
											{math assign="prozent" equation="(( x * 100 / y ) - 100 ) * -1" x=$Artikel->Preise->fVKNetto y=$Artikel->Preise->alterVKNetto}
										{else}
											{math assign="prozent" equation="(( x * 100 / y ) - 100 ) * -1" x=$Artikel->Preise->fVKBrutto y=$Artikel->fUVP}
										{/if}
										-{$prozent|round:0}%
									</div>
								</div>
							{/if}
						</div>
					</div>
				{/foreach}
			</div>
		{/foreach}
	</div>
{/if}

{if isset($StartseiteBoxen) && $StartseiteBoxen|@count > 0}
    <hr>
	{assign var='moreLink' value=null}
	{assign var='moreTitle' value=null}
    {foreach name=startboxen from=$StartseiteBoxen item=Box}
        {if isset($Box->Artikel->elemente) && count($Box->Artikel->elemente)>0 && isset($Box->cURL)}
            {if $Box->name === 'TopAngebot'}
                {lang key="topOffer" section="global" assign='title'}
				{lang key='showAllTopOffers' section='global' assign='moreTitle'}
            {elseif $Box->name === 'Sonderangebote'}
                {lang key="specialOffer" section="global" assign='title'}
				{lang key='showAllSpecialOffers' section='global' assign='moreTitle'}
            {elseif $Box->name === 'NeuImSortiment'}
                {lang key="newProducts" section="global" assign='title'}
				{lang key='showAllNewProducts' section='global' assign='moreTitle'}
            {elseif $Box->name === 'Bestseller'}
                {lang key="bestsellers" section="global" assign='title'}
				{lang key='showAllBestsellers' section='global' assign='moreTitle'}
            {/if}
            {assign var='moreLink' value=$Box->cURL}
			{include file='snippets/product_slider.tpl' productlist=$Box->Artikel->elemente title=$title hideOverlays=true moreLink=$moreLink moreTitle=$moreTitle}
        {/if}
    {/foreach}
{/if}

{block name="index-additional"}
{if isset($oNews_arr) && $oNews_arr|@count > 0}
    <hr>
    <h2>{lang key="news" section="news"}</h2>
    {foreach name=news from=$oNews_arr item=oNews}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <a href="{$oNews->cURL}">{$oNews->cBetreff}</a>&nbsp;-&nbsp;
                    {$oNews->dErstellt_de}{if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
                    |
                    <a href="{$oNews->cURL}#comments" title="{lang key="readComments" section="news"}">{$oNews->nNewsKommentarAnzahl} {if $oNews->nNewsKommentarAnzahl == 1}{lang key="newsComment" section="news"}{else}{lang key="newsComments" section="news"}{/if}{/if}</a>
                </h3>
            </div>
            <div class="panel-body">
                {if !empty($oNews->cPreviewImage)}
                    <div class="col-lg-4 col-xs-6">
                        <a href="{$oNews->cURL}">
                            <img src="{$ShopURL}/{$oNews->cPreviewImage}" alt="" class="img-responsive" />
                        </a>
                    </div>
                {/if}
                <div class="news-preview panel-strap">
                    {if $oNews->cVorschauText|strlen > 0}
                        {$oNews->cVorschauText}<span class="read-more">{$oNews->cMehrURL}</span>
                    {elseif $oNews->cText|strip_tags|strlen > 200}
                        {$oNews->cText|strip_tags|truncate:200:""}<span class="read-more">{$oNews->cMehrURL}</span>
					{else}
						{$oNews->cText}
					{/if}
				</div>
			</div>
		</div>
    {/foreach}
{/if}
{/block}