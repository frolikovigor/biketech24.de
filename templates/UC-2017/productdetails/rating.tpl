{assign var="starType" value="1"}
{if $type}{assign var="starType" value=$type}{/if}

{if $starType == "1"}
    <div class="ipi-name">
        <div class="silver-star silver-star_catalog">
            <span class="gold-star" style="width: {$total * 100 / 5}%"></span>
        </div>
    </div>

{elseif $starType == "2"}
    <div>
        <div class="silver-star-small">
            <span class="yellow-star" style="width: {$total * 100 / 5}%"></span>
        </div>
        <span>{$total} von 5 Sternen</span>
    </div>

{elseif $starType == "3"}
        <div class="silver-star-small">
            <span class="yellow-star" style="width: {$total * 100 / 5}%"></span>
        </div>
{/if}





