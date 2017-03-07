{if isset($boxes)}{* only available in shop versions > 3.19 *}
    {has_boxes position='left' assign='hasLeftBox'}
{/if}
{nocache}
    {if !empty($hinweis)}
        {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
            {include file='productdetails/pushed_success.tpl' type='alert'}
        {else}
            <div class="alert alert-success">
                {$hinweis}
            </div>
        {/if}
    {/if}
    {if !empty($fehler)}
        <div class="alert alert-danger">
            {$fehler}
        </div>
    {/if}
    {if !empty($ProdukttagHinweis)}
        <div class="alert alert-success">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            {$ProdukttagHinweis}
        </div>
    {/if}
	{if isset($PositiveFeedback) && count($PositiveFeedback) > 0}
        {foreach name=feedback from=$PositiveFeedback item=Feedback}
            <div class="alert alert-success">{$Feedback}</div>
        {/foreach}
    {/if}
    {if isset($Artikelhinweise) && count($Artikelhinweise) > 0}
        {foreach name=hinweise from=$Artikelhinweise item=Artikelhinweis}
            <div class="alert alert-danger">{$Artikelhinweis}</div>
        {/foreach}
    {/if}
{/nocache}

<div class="h1 visible-xs text-center">
	{$Artikel->cName}
</div>

<div class="product-headline hidden-xs">
	{block name="productdetails-info-product-title"}
	<h1 class="fn product-title" itemprop="name">{$Artikel->cName}</h1>
	{/block}
</div>

<form id="buy_form" method="post" action="{$Artikel->cURLFull}">
    {$jtl_token}
    <div class="row product-primary" itemscope itemtype="http://schema.org/Product" id="product-offer">

        {* Add u-charged *}
        <meta itemprop="name" content="{$Artikel->cName}">
		
        <div class="product-gallery {if $hasLeftBox}col-sm-8{else}col-sm-8{/if}">
			{if $lit_magic360_images_large|count > 0}
				<a class="Magic360" id="spin" href="{$lit_magic360_startimage_large}" data-options="{$lit_magic360_data_options}"><img src="{$lit_magic360_startimage_small}" alt=""/></a>
				<script type="text/javascript">
					Magic360.start('spin')
				</script>
			{else}
				{include file="productdetails/image.tpl"}
			{/if}
        </div>

        <div class="product-info {if $hasLeftBox}col-sm-4{else}col-sm-4{/if}">
			
			{include file="productdetails/price_test.tpl" Artikel=$Artikel price_image=$priceImage tplscope="detail"}
			
			{block name="productdetails-info"}
            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
                {block name="product-info-manufacturer"}
				<div class="manufacturer-row text-right small">
                    <a href="{$Artikel->cHerstellerSeo}"{if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'} data-toggle="tooltip" data-placement="left" title="{$Artikel->cHersteller}"{/if}>
                        {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'Y' && (!empty($Artikel->cBildpfad_thersteller) || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B') && isset($Artikel->cHerstellerBildKlein)}
                            <img src="{$Artikel->cHerstellerBildKlein}" alt="{$Artikel->cHersteller}" class="img-sm">
                        {/if}
                        {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
                            {$Artikel->cHersteller}
                        {/if}
                    </a>
                </div>
				{/block}
            {/if}
            
            {if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr)}
                <div class="info-essential row">
					{block name="productdetails-info-essential"}
                    {if isset($Artikel->cArtNr) || isset($Artikel->dMHD)}
                        <div class="col-xs-8">
                            <span class="text-muted product-sku">{lang key="sortProductno" section="global"}: <span itemprop="sku">{$Artikel->cArtNr}</span></span>
                            {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                                <p title="{lang key='productMHDTool' section='global'}" class="best-before text-muted">{lang key="productMHD" section="global"}: <span itemprop="best-before">{$Artikel->dMHD_de}</span></p>
                            {/if}
                        </div>
                    {/if}
                    {if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
                        <div class="rating-wrapper col-xs-4 text-right" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                        <span itemprop="ratingValue"
                              class="hidden">{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}</span>
                        <span itemprop="reviewCount" class="hidden">{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}</span>
                        <a href="{$Artikel->cURLFull}#tab-votes" id="jump-to-votes-tab">
                            {include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                        </a>
                        </div>{* /rating-wrapper*}
                    {/if}
					{/block}
                </div>
                <div class="clearfix top10"></div>
            {/if}

			{include file="productdetails/stock.tpl"}
			
            {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y'}
				{block name="productdetails-info-category"}
                <p class="product-category">
                    <span class="text-muted">{lang key="category" section="global"}: </span>
                    {assign var=i_kat value=$Brotnavi|@count}{assign var=i_kat value=$i_kat-2}
                    <a href="{$Brotnavi[$i_kat]->url}">{$Brotnavi[$i_kat]->name}</a>
                </p>
				{/block}
            {/if}
            
			{/block}
			
			
            <div class="product-offer" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
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
				{/block}
                <input type="hidden" name="kSprache" value="{$smarty.session.kSprache}" />
                <!-- VARIATIONEN -->
					
				<div class="panel panel-basket">				
				
					{include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
					
					{include file="productdetails/staffelpreise.tpl"}
					
					{include file="productdetails/basket.tpl"}
					
				</div>
            </div>
			
			{if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
				{include file="productdetails/actions.tpl"}
			{/if}
			
			
        </div>{* /product-info *}
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
		
    </div>{* /row *}

</form>

<div class="center-block text-center">
	<hr>
	<ul class="list-inline">
		{if $oPlugin_lit_rahmenberechner}
			{if $LIT_KategorieListe|count > 0}
				{foreach from=$LIT_KategorieListe item=KategorieName}
					{if $KategorieName->cName|regex_replace:"/[^a-zA-Z0-1]/":"" == "Fahrrder"}
						<li><img src="/mediafiles/Bilder/logos/vorteile_rahmenberechner.png" alt="Rahmenhoehe berechnen">&nbsp;<a href="/{$oPlugin_lit_rahmenberechner->oPluginFrontendLink_arr[0]->oPluginFrontendLinkSprache_arr[0]->cSeo}?exclusive_content=1" rel="nofollow" class="popup">{$lit_rahmenberechner_rahmengroesse_berechnen}</a></li>
					{/if}
				{/foreach}
			{/if}
		{/if}
		<li><img src="/mediafiles/Bilder/logos/vorteile_hotline.png" alt="Hotline"><span data-toggle="tooltip" data-placement="bottom" title="Wir sind f&uuml;r Sie Mo. bis Fr. von 9:00 bis 17:00 Uhr telefonisch zu erreichen."> Hotline: <a href="tel:+4935217270300">03521 / 7270300</a></span></li>
		<li><img src="/mediafiles/Bilder/logos/vorteile_rabatt.png" alt="Rabatt"> 2% Rabatt bei Zahlung per Vorkasse</li>
		<li><img src="/mediafiles/Bilder/logos/vorteile_rueckgabe.png" alt="60 Tage Rückgabe"><span data-toggle="tooltip" data-placement="bottom" title="Sie k&ouml;nnen unbenutzte Artikel innerhalb von 60 Tagen an uns zur&uuml;cksenden."> 60 Tage R&uuml;ckgaberecht</span></li>
		<li><img src="/mediafiles/Bilder/logos/vorteile_versand.png" alt="Versand"><span data-toggle="tooltip" data-placement="bottom" title="Wir schenken unseren Kunden die Versandkosten innerhalb Deutschlands ab 100 &euro; Warenwert. (ausgenommen Sperrgut)"> 0 &euro; Versand ab 100 &euro;</span></li>
	</ul>
	<hr>
</div>


{if $LIT_KategorieListe|count > 0}
	{foreach from=$LIT_KategorieListe item=KategorieName}
		{if $KategorieName->cName|regex_replace:"/[^a-zA-Z0-1]/":"" == "Fahrrder"}
			<div id="fahrradversand">
				<div class="alert alert-success" role="alert">
					<span class="fa fa-thumbs-up pull-left hidden-xs" aria-hidden="true"></span>
					{lang key="FahrradVersand" section="custom"}
				</div>
			</div>
		{/if}
	{/foreach}
{/if}

{include file="productdetails/download.tpl"}
{include file="productdetails/tabs.tpl"}

<div class="clearfix"></div>

<!-- SLIDERS -->
{if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0}
    <div class="partslist">
        {lang key='listOfItems' section='global' assign='slidertitle'}
        {include file='snippets/product_slider.tpl' id='slider-partslist' productlist=$Artikel->oStueckliste_arr title=$slidertitle showPartsList=true}
    </div>
{/if}

{if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen == 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0}
    <div class="bundle">
        {include file="productdetails/bundle.tpl" ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
    </div>
{/if}

{if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
    <div class="recommendations">
        {block name="productdetails-recommendations"}

            {* Add u-charged *}
            {if isset($Xselling->Similars->Artikel) && count($Xselling->Similars->Artikel) > 0}
                {lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
                {include file='snippets/product_slider.tpl' class='x-sell' id='slider-xsells' productlist=$Xselling->Similars->Artikel title='&Auml;hnliche Artikel'}
            {/if}
            {* -------------*}


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
		{/block}
    </div>
{/if}

<div id="article_popups">
    {include file='productdetails/popups.tpl'}
</div>