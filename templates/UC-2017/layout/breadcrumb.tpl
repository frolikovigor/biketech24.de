{strip}
{has_boxes position='left' assign='hasLeftBox'}
{*{if !empty($Brotnavi) && !$bExclusive && !$bAjaxRequest && $nSeitenTyp != 18 && $nSeitenTyp != 11 && $nSeitenTyp != 38}*}
{if !empty($Brotnavi) && !$bExclusive && $nSeitenTyp != 18 && $nSeitenTyp != 11 && $nSeitenTyp != 38}
    <ul class="breadcrumbs">
        {foreach name=navi from=$Brotnavi item=oItem}
            {if $smarty.foreach.navi.first}
                <li class="breadcrumbs__item">
                    <a href="{$oItem->url}" title="{$oItem->name|escape:"html"}" class="breadcrumbs__link">
                        <span class="">Start</span>
                    </a>
                </li>
            {elseif $smarty.foreach.navi.last}
                <li class="breadcrumbs__item">
                    <span class="breadcrumbs__link">
                        {if $oItem->name !== null}
                            {$oItem->name}
                        {elseif isset($Suchergebnisse->SuchausdruckWrite)}
                            {$Suchergebnisse->SuchausdruckWrite}
                        {/if}
                    </span>
                </li>
            {else}
                <li class="breadcrumbs__item">
                    <a href="{$oItem->url}" title="{$oItem->name|escape:"html"}" class="breadcrumbs__link">
                        <span>{$oItem->name}</span>
                    </a>
                </li>
            {/if}
        {/foreach}


    </ul>
{/if}
{/strip}
