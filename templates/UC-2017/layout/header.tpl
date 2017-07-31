<!DOCTYPE html>
<html lang="{$meta_language}">
<head>

    {block name="head-meta"}
    <meta http-equiv="content-type" content="text/html" charset=windows-1252>
    <meta name="description" content={block name="head-meta-description"}"{$meta_description|truncate:1000:"":true}{/block}">
    <meta name="keywords" content="{block name="head-meta-keywords"}{$meta_keywords|truncate:255:"":true}{/block}">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="robots" content="{if $bNoIndex === true  || (isset($Link->cNoFollow) && $Link->cNoFollow === 'Y')}noindex{else}index, follow{/if}">
    {/block}

    <title>{block name="head-title"}{$meta_title}{/block}</title>

    {if !empty($cCanonicalURL)}
        <link rel="canonical" href="{$cCanonicalURL}">
    {/if}

	{block name="head-base"}
		<base href="{$ShopURL}/">
	{/block}

	{block name="head-icons"}
		<link type="image/x-icon" href="{$currentTemplateDir}themes/base/images/{if !empty($Einstellungen.template.theme.favicon)}{$Einstellungen.template.theme.favicon}{else}favicon.ico{/if}" rel="shortcut icon">
		<link href="{$currentTemplateDir}themes/base/images/apple-touch-icon.png" rel="apple-touch-icon">
		{if $nSeitenTyp == 1 && isset($Artikel) && !empty($Artikel->Bilder)}
			{*<link rel="image_src" href="{$ShopURL}/{$Artikel->Bilder[0]->cPfadGross}">*}
            <meta property="og:image" content="{$ShopURL}/{$Artikel->Bilder[0]->cPfadGross}" />
            <meta property="og:type" content="article" />
		{/if}
	{/block}



	<script src="/dev/static/js/separate-js/jquery-2.2.4.min.js"></script>


    {*<link href="/dev/static/css/separate-css/jquery.formstyler.css" rel="stylesheet" type="text/css" />*}
    {*<link href="/dev/static/css/separate-css/jquery.formstyler.theme.css" rel="stylesheet" type="text/css" />*}
    {*<link href="{$currentTemplateDir}js/bxslider/jquery.bxslider.css" rel="stylesheet" type="text/css" />*}
    {*<link href="{$currentTemplateDir}js/fsbanner/fsbanner.css" rel="stylesheet" type="text/css"/>*}
    {*<link href="/dev/static/css/separate-css/jquery-ui.css" rel="stylesheet" type="text/css"/>*}
    {*<link href="{$currentTemplateDir}js/colorbox/colorbox.css" rel="stylesheet" type="text/css">*}


    {block name="head-resources"}
        {* css *}
        {if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
            {foreach from=$cCSS_arr item="cCSS"}
                <link type="text/css" href="{$cCSS}?v={$nTemplateVersion}" rel="stylesheet">
            {/foreach}

            {if isset($cPluginCss_arr)}
                {foreach from=$cPluginCss_arr item="cCSS"}
                    <link type="text/css" href="{$cCSS}?v={$nTemplateVersion}" rel="stylesheet">
                {/foreach}
            {/if}
        {else}
            <link type="text/css" href="asset/{$Einstellungen.template.theme.theme_default}.css?v={$nTemplateVersion}" rel="stylesheet">
            {if isset($cPluginCss_arr) && $cPluginCss_arr|@count > 0}
                <link type="text/css" href="asset/plugin_css?v={$nTemplateVersion}" rel="stylesheet">
            {/if}
        {/if}
        {* RSS *}
        {if isset($Einstellungen.rss.rss_nutzen) && $Einstellungen.rss.rss_nutzen === 'Y'}
            <link rel="alternate" type="application/rss+xml" title="Newsfeed {$Einstellungen.global.global_shopname}" href="rss.xml">
        {/if}
        {* Languages *}
        {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
            {foreach item=oSprache from=$smarty.session.Sprachen}
                {if $oSprache->kSprache != $smarty.session.kSprache}
                    <link rel="alternate" hreflang="{$oSprache->cISO639}" href="{$oSprache->cURL}">
                {elseif $oSprache->kSprache == $smarty.session.kSprache && $oSprache->cStandard === 'Y' && isset($oSprache->cURL)}
                    <link rel="alternate" hreflang="x-default" href="{$oSprache->cURL}">
                {/if}
            {/foreach}
        {/if}
    {/block}



    {*<link href="/dev/static/css/main.css?v=1" rel="stylesheet" type="text/css">*}
    {*<link href="{$currentTemplateDir}css/custom.css?v=1" rel="stylesheet" type="text/css" />*}


    {include file='layout/header_inline_js.tpl'}

</head>


{block name="body-tag"}
<body data-page="{$nSeitenTyp}" class="body-offcanvas"{if isset($Link) && !empty($Link->cIdentifier)} id="{$Link->cIdentifier}"{/if}>


<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KLKMZ39"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->


<input type="hidden" id="service_info" data-template="{$currentTemplateDir}" />

<div class="visible-sm visible-xs">
    <div id="sidebar_mobile">
        <div class="toggle_sidebar">
            <ul><li></li><li></li><li></li></ul>
        </div>

        <div class="sidebar">
            <div class="bottom__client">
                <nav class="navbar-offcanvas" id="navbar-offcanvas">
                    {strip}
                        <div class="container-fluid">
                            <div class="sidebar-offcanvas in">
                                <div class="navbar-categories">
                                    <ul class="nav navbar-nav">
                                        {include file='snippets/categories_recursive.tpl' i=0 categoryId=0 limit=2 caret='right'}
                                    </ul>
                                </div>
                                {block name="megamenu-manufacturers"}
                                    {if isset($Einstellungen.template.megamenu.show_manufacturers) && $Einstellungen.template.megamenu.show_manufacturers !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && $Einstellungen.global.global_sichtbarkeit != 3}
                                        {get_manufacturers assign='manufacturers'}
                                        {if !empty($manufacturers)}
                                            <hr>
                                            <div class="navbar-manufacturers">
                                                <ul class="nav navbar-nav navbar-right">
                                                    <li class="dropdown">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{lang key="manufacturers" section="global"} <span class="fa fa-caret-down pull-right"></span></a>
                                                        <ul class="dropdown-menu keepopen">
                                                            {foreach name='hersteller' from=$manufacturers item='hst'}
                                                                <li role="presentation">
                                                                    <a role="menuitem" tabindex="-1" href="{$hst->cSeo}"">{$hst->cName|escape:"html"}</a>
                                                                </li>
                                                            {/foreach}
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </div>
                                        {/if}
                                    {/if}
                                {/block}{* megamenu-manufacturers *}
                                {block name="megamenu-pages"}
                                    {if isset($Einstellungen.template.megamenu.show_pages) && $Einstellungen.template.megamenu.show_pages !== 'N'}
                                        <hr>
                                        <ul class="nav navbar-nav">
                                            {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
                                        </ul>
                                    {/if}
                                {/block}{* megamenu-pages *}
                                {block name="navbar-top-cms"}
                                    {if !empty($linkgroups->Kopf)}
                                        <hr>
                                        <ul class="nav  navbar-nav">
                                            {foreach name=kopflinks from=$linkgroups->Kopf->Links item=Link}
                                                {if $Link->cLocalizedName|has_trans}
                                                    <li class="{if isset($Link->aktiv) && $Link->aktiv == 1}active{/if}">
                                                        <a href="{$Link->URL}">{$Link->cLocalizedName|trans}</a>
                                                    </li>
                                                {/if}
                                            {/foreach}
                                        </ul>
                                    {/if}
                                {/block}{* /navbar-top *}
                            </div>
                        </div>
                    {/strip}
                </nav>
            </div>




        </div>
        <div class="sidebar_mobile_swipe"></div>
    </div>
    <div class="toggle_sidebar">
        <ul><li></li><li></li><li></li></ul>
    </div>
</div>

<header class="header {$fixed_header}">
    <div class="container container_header">
        <table class="main-nav">
            <tr>
                <td rowspan="2" class="logo">
                    <a href="/">
                        <img src="/dev/static/img/content/logo.svg" alt="Main logo">
                    </a>
                </td>

                <td colspan="5" class="actions_td">
                    <div class="actions">
                        {include file='layout/header_shop_nav.tpl'}
                    </div>
                </td>
            </tr>
            <tr>
                {include file='snippets/categories_mega.tpl'}
            </tr>
        </table>

        {include file='snippets/subcategories_mega.tpl'}


    </div>
</header>

{if $Link->nLinkart == 5}
    <section class="video-section">

        <video class="video-bg" poster="/dev/static/img/content/video-fallback.jpg" id="bgvid" playsinline autoplay muted loop>
            <source src="/dev/static/img/content/video/video-i.mp4?v=1" type="video/mp4">
            <source src="/dev/static/img/content/video/video-i.webm" type="video/webm">
        </video>

        <div class="video-section__fallback-mob">
            <img src="/dev/static/img/content/video-fallback-mob.jpg">
        </div>
    </section>
{/if}

<section class="content"> <!--common section -->
    <div class="container">



{/block}
