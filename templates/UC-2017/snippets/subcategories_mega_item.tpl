{assign var="translit" value=transliteration($sub->cKurzbezeichnung)}
{assign var="url" value=fileExist("`$currentTemplateDir`images/menu/`$translit`.svg")}

<li class="col-md-1" >
    <a href="{$sub->cURL}{$url_prefix}">
        <div class="menu__sub_item" data-img="{$translit}">
            {if $image_enabled}
                <div class="menu__sub_img" data-img="{$translit}">
                    {if $url}<img class="svg" src="{$url}" />{/if}
                </div>
            {/if}

            <div class="menu__sub_title">
                {$sub->cKurzbezeichnung}
            </div>
        </div>
    </a>
</li>