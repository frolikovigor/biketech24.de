<ul class="{if $Artikel->Bilder|@count > 1}bxslider-carddetail{else}bx-wrapper{/if}">
    {block name="product-image"}
        {foreach $Artikel->Bilder as $image}
            {strip}
                <li>
                    <a class="colorbox" rel="product-image" href="{$image->cPfadGross}">
                        <img src="{$image->cPfadNormal}" alt='{$image->cAltAttribut|escape:"quotes"}'  />
                    </a>
                </li>
            {/strip}
        {/foreach}
    {/block}
</ul>

{if $Artikel->Bilder|@count > 1}
    <div id="bx-pager-carddetail" class="bx-pager">
        {foreach $Artikel->Bilder as $index => $image}
            {strip}
                <a data-slide-index="{$index}" href=""><img src="" data-json='{$image->galleryJSON}' /></a>
            {/strip}
        {/foreach}

    </div>
{/if}

