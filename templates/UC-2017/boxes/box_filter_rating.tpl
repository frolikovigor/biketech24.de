{if $bBoxenFilterNach && $BoxenEinstellungen.navigationsfilter.bewertungsfilter_benutzen === 'box'}
    {nocache}
    {if $Suchergebnisse->Bewertung|@count > 0}
        <div class="filter-type__inner js-slide_toggle">
            <div class="filter-head js-slide_toggle__event">
                <h4 class="filter-type__title filter-type__title--sub">{lang key="Votes" section="global"}</h4>
                <div class="filter-choice"><span></span></div>
            </div>
            <div class="filter-parameters js-slide_toggle__block">
                <ul class="parameters__list parameters__list_rate">
                    {foreach name=bewertungen from=$Suchergebnisse->Bewertung item=oBewertung}
                        {if isset($NaviFilter->BewertungFilter) && $NaviFilter->BewertungFilter->nSterne == $oBewertung->nStern}
                            <li>
                                <a rel="nofollow" href="{$NaviFilter->URL->cAlleBewertungen}">
                                    <div class="filter-parameters-i">
                                        <div class="jq-checkbox checked"><div class="jq-checkbox__div"></div></div>
                                        <label for="itemRate">
                                            <div class="silver-star">
                                                <span class="gold-star" style="width: {$oBewertung->nStern * 100 / 5}%"></span>
                                            </div>
                                        </label>
                                        <span class="count">({$oBewertung->nAnzahl})</span>
                                    </div>
                                </a>
                            </li>
                        {else}
                            {if $oBewertung->nAnzahl >= 1 && $oBewertung->nStern > 0}
                                <li>
                                    <a rel="nofollow" href="{$oBewertung->cURL}">
                                        <div class="filter-parameters-i">
                                            <div class="jq-checkbox"><div class="jq-checkbox__div"></div></div>
                                            <label for="itemRate">
                                                <div class="silver-star">
                                                    <span class="gold-star" style="width: {$oBewertung->nStern * 100 / 5}%"></span>
                                                </div>
                                            </label>
                                            <span class="count">({$oBewertung->nAnzahl})</span>
                                        </div>
                                    </a>
                                </li>
                            {/if}
                        {/if}
                    {/foreach}
                </ul>
            </div>
        </div>
        <hr>
    {/if}
    {/nocache}
{/if}


