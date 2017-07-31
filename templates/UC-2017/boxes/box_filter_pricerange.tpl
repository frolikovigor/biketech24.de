{if $bBoxenFilterNach && $BoxenEinstellungen.navigationsfilter.preisspannenfilter_benutzen === 'box'}
    {if $Suchergebnisse->Preisspanne|@count > 0}
        <div class="filter-type__inner js-slide_toggle">
            <div class="filter-head js-slide_toggle__event">
                <h4 class="filter-type__title filter-type__title--sub">preis</h4>
                <div class="filter-choice"><span></span></div>
            </div>
            <div class="filter-parameters js-slide_toggle__block">
                <div class="price-input" data-for="slider-{lang key="rangeOfPrices" section="global"}">
                    <div class="price-input__i">
                        <input class="input-text slider_min" type="text" value="">&nbsp;-&nbsp;
                    </div>
                    <div class="price-input__i">
                        <input class="input-text slider_max" type="text" value="">&nbsp;€
                    </div>
                </div>

                {if isset($NaviFilter->PreisspannenFilter) && $NaviFilter->PreisspannenFilter->cWert}
                    {if $NaviFilter->PreisspannenFilter->fVon >= 0 && $NaviFilter->PreisspannenFilter->fBis > 0}
                        <div id="slider-{lang key="rangeOfPrices" section="global"}" class="slider"
                             data-ajax="{getAjaxPrice}&AJAX_NAVI=oSuchergebnisse-Preisspanne"
                             data-url="{$NaviFilter->URL->cAllePreisspannen}"
                             data-step_from_1 = "{$NaviFilter->PreisspannenFilter->fVon}"
                             data-step_to_1 = "{$NaviFilter->PreisspannenFilter->fBis}"
                        >
                            <span class="min-val"><span class="num"></span><span class="currency"> €</span></span>
                            <span class="max-val"><span class="num"></span><span class="currency"> €</span></span>
                        </div>
                    {/if}
                {else}
                    <div id="slider-{lang key="rangeOfPrices" section="global"}" class="slider"
                            {assign var = step value=1}
                            {foreach name=preisspannen from=$Suchergebnisse->Preisspanne item=oPreisspannenfilter}
                                data-step_from_{$step} = "{$oPreisspannenfilter -> nVon}"
                                data-step_to_{$step} = "{$oPreisspannenfilter -> nBis}"
                                data-url = "{$oPreisspannenfilter->cURL}"
                                {assign var = step value=$step + 1}
                            {/foreach}
                    >
                        <span class="min-val"><span class="num"></span><span class="currency"> €</span></span>
                        <span class="max-val"><span class="num"></span><span class="currency"> €</span></span>
                    </div>
                {/if}
            </div>
        </div>

        <hr>
    {/if}
{/if}


