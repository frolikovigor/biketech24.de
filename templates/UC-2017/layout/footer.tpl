    </div>
</section>


<div class="bikes-footer {if $Link->nLinkart == 5}bikes-footer__main{/if}">

    {load_boxes_raw type='bottom' assign='arrBoxBottom' array=true}
    {if isset($arrBoxBottom) && count($arrBoxBottom) > 0}


        <div class="container">
            <div class="bf-row">

                {foreach name=bottomBoxes from=$arrBoxBottom item=box}
                    {if isset($box.obj) && isset($box.tpl)}
                        {if $smarty.foreach.bottomBoxes.iteration < 10}
                            {assign var=oBox value=$box.obj}
                            {include file=$box.tpl}
                        {/if}
                    {/if}
                {/foreach}


                <div class="bf-col">
                    <span class="bf-title">biketech24</span>
                    <ul class="bf-list">
                    {get_category_array categoryId=0 assign='categories'}
                        {foreach name='sub_categories' from=$categories item='sub'}
                            <li><a href="{$sub->cURL}">{$sub->cName}</a></li>
                        {/foreach}
                    </ul>
                </div>

                {*<div class="bf-col bf-col_trust">*}
                    {*<span class="bf-title">TRUSTEDSHOPS-RATING</span><br>*}
                    {*<div class="trust-image">*}
                        {*<img src="/dev/static/img/content/bikes-footer-fgif.png">*}
                    {*</div>*}
                {*</div>*}

                <div class="bf-col bf-col_links">
                    <table class="bf-title bf-title_link">
                        <tr>
                            <td>
                                <i class="icons icons_delivery-car"></i>
                            </td>
                            <td>
                                <a href="/Versand-und-Zahlungsarten" target="_blank" rel="noindex nofollow">Versandkostenfrei AB 100 €</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <i class="icons icons_undo-link"></i>
                            </td>
                            <td>
                                <a href="/Widerrufsbelehrung" target="_blank" rel="noindex nofollow">60 Tage Rückgaberecht</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <i class="icons icons_telephone"></i>
                            </td>
                            <td>
                                <span>Hotline:</span>
                                {*<a href="tel:03521" target="_blank" rel="noindex nofollow">03521</a>*}
                                {*<span>/</span>*}
                                {*<a href="tel:7270300" target="_blank" rel="noindex nofollow">7270300</a>*}
                                <a href="tel:004935217270300" rel="noindex nofollow">03521 / 7270300</a>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="bf-col bf-col_social">
                    <div>
                        <span class="bf-title">SOZIAL</span>
                    </div>
                    <div class="social-icons">
                        <a href="https://www.facebook.com/biketech24" target="_blank" rel="noindex nofollow">
                            <i class="icons icons_bf-fb"></i>
                        </a>
                        <a href="https://twitter.com/biketech24" target="_blank" rel="noindex nofollow">
                            <i class="icons icons_bf-tw"></i>
                        </a>
                        <a href="https://www.instagram.com/biketech24.de/" target="_blank" rel="noindex nofollow">
                            <i class="icons icons_bf-in"></i>
                        </a>
                    </div>
                </div>
            </div>

            {foreach name=bottomBoxes from=$arrBoxBottom item=box}
                {if isset($box.obj) && isset($box.tpl)}
                    {if $smarty.foreach.bottomBoxes.iteration < 10}
                        {if $box['obj']->kBox == 216}
                            {$box['obj']->cInhalt}
                        {/if}
                    {/if}
                {/if}
            {/foreach}
        </div>
    {/if}


    {* partners *}
    {foreach name=bottomBoxes from=$arrBoxBottom item=box}
        {if isset($box.obj) && isset($box.tpl)}
            {if $smarty.foreach.bottomBoxes.iteration < 10}
                {if $box['obj']->kBox == 214}
                    {$box['obj']->cInhalt}
                {/if}
            {/if}
        {/if}
    {/foreach}

    <div class="container">
        <div class="bf-copyright">
            <span>&copy; Biketech24 - Vervielfältigung oder Wiedergabe, auch auszugsweise, nur mit Genehmigung.</span>
        </div>
    </div>
</div>

{* JavaScripts *}
{block name="footer-js"}
    {assign var="isFluidContent" value=false}
    {if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout === 'fluid' && isset($Link) && $Link->bIsFluid}
        {assign var="isFluidContent" value=true}
    {/if}

    {if !$bExclusive && !$isFluidContent && isset($Einstellungen.template.theme.background_image) && $Einstellungen.template.theme.background_image !== ''}
        {if $Einstellungen.template.theme.background_image === 'custom'}
            {assign var="backstretchImgPath" value=$currentTemplateDir|cat:'themes/'|cat:$Einstellungen.template.theme.theme_default|cat:'/background.jpg'}
        {else}
            {assign var="backstretchImgPath" value=$currentTemplateDir|cat:'themes/base/images/backgrounds/background_'|cat:$Einstellungen.template.theme.background_image|cat:'.jpg'}
        {/if}
        <script>
            $(function() {
                $.backstretch('{$backstretchImgPath}');
            });
        </script>
    {/if} {if !empty($Einstellungen.global.global_google_analytics_id)}
    <script type="text/javascript">
        function gaOptout() {
            document.cookie = disableStr + '=true; expires=Thu, 31 Dec 2099 23:59:59 UTC; path=/';
            window[disableStr] = true;
        }

        var gaProperty = '{$Einstellungen.global.global_google_analytics_id}';
        var disableStr = 'ga-disable-' + gaProperty;
        if (document.cookie.indexOf(disableStr + '=true') > -1) {
            window[disableStr] = true;
        } else {
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', '{$Einstellungen.global.global_google_analytics_id}']);
            _gaq.push(['_gat._anonymizeIp']);
            _gaq.push(['_trackPageview']);
            (function () {ldelim}
                var ga = document.createElement('script'),
                    s;
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' === document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
                {rdelim})();
        }
    </script>
{/if}

    <script>
        jtl.load({strip}[
            {* evo js *}
            {if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
            {if isset($cPluginJsHead_arr)}
            {foreach from=$cPluginJsHead_arr item="cJS"}
            "{$cJS}?v={$nTemplateVersion}",
            {/foreach}
            {/if}
            {else}
            {if isset($cPluginJsHead_arr) && $cPluginJsHead_arr|@count > 0}
            "asset/plugin_js_head?v={$nTemplateVersion}",
            {/if}
            {/if}
            {if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
            {foreach from=$cJS_arr item="cJS"}
            "{$cJS}?v={$nTemplateVersion}",
            {/foreach}
            {if isset($cPluginJsBody_arr)}
            {foreach from=$cPluginJsBody_arr item="cJS"}
            "{$cJS}?v={$nTemplateVersion}",
            {/foreach}
            {/if}
            {else}
            "asset/jtl3.js?v={$nTemplateVersion}",
            {if isset($cPluginJsBody_arr) && $cPluginJsBody_arr|@count > 0}
            "asset/plugin_js_body?v={$nTemplateVersion}",
            {/if}
            {/if}

            {assign var="customJSPath" value=$currentTemplateDir|cat:'/js/custom.js'}
            {if file_exists($customJSPath)}
            "{$customJSPath}?v={$nTemplateVersion}",
            {/if}
        ]{/strip});
        {if (!isset($Einstellungen.template.general.use_cron) || $Einstellungen.template.general.use_cron === 'Y') && $smarty.now % 10 === 0}
        $.get('includes/cron_inc.php');
        {/if}
    </script>

    {*<script src="{$currentTemplateDir}js/bxslider/jquery.bxslider.min.js"></script>*}
    {*<script src="/dev/static/js/separate-js/spritespin.min.js"></script>*}
    {*<script src="{$currentTemplateDir}js/hamburger/hamburger.js"></script>*}
    {*<script src="/dev/static/js/separate-js/jquery.formstyler.min.js"></script>*}
    {*<script src="/dev/static/js/separate-js/snap.svg-min.js"></script>*}
    {*<script src="{$currentTemplateDir}js/fsbanner/fsbanner.js"></script>*}
    {*<script src="{$currentTemplateDir}js/colorbox/jquery.colorbox-min.js"></script>*}
    {*<script src="/dev/static/js/main.js"></script>*}

{/block}

</body>
</html>
