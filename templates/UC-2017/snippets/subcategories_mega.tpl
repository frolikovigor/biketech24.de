{get_category_array categoryId=0 assign='categories'}

{foreach name='categories' from=$categories item='category'}
    {if $category->bUnterKategorien}
        {if !empty($category->Unterkategorien)}
            {assign var=sub_categories value=$category->Unterkategorien}
        {else}
            {get_category_array categoryId=$category->kKategorie assign='sub_categories'}
        {/if}



        {if $category->cKurzbezeichnung == "Teile"}

            <div class="menu__sub_block" data-tab_for="{$category->kKategorie}" data-tab_block="1" data-tab_event="hover">
                <div class="menu__sub_fahrrader svg_element_parent">
                    <object class="svg_element" type="image/svg+xml" data="{$currentTemplateDir}images/svg/teiles.svg"></object>

                    <input type="hidden"
                           data-color_default = "#333"
                            {assign var="sub_categories_index" value=0}
                            {foreach name='sub_categories' from=$sub_categories item='sub'}
                                data-title_{$sub -> kKategorie} = "{$sub->cKurzbezeichnung}"
                                data-url_{$sub -> kKategorie} = "{$sub->cURL}"
                                {assign var="sub_categories_index" value=$sub_categories_index+1}
                            {/foreach}


                           data-accordance_1 = "389"
                           data-accordance_2 = "263"
                           data-accordance_3 = "374"
                           data-accordance_4 = "311"
                           data-accordance_5 = "372"
                           data-accordance_6 = "373"
                           data-accordance_7 = "380"
                           data-accordance_8 = "100"
                           data-accordance_10 = "103"
                           data-accordance_11 = "34"
                           data-accordance_12 = "381"
                           data-accordance_13 = "130"
                    />
                </div>
            </div>
        {elseif $category->cKurzbezeichnung == "Bekleidung"}
            <div class="menu__sub_block" data-tab_for="{$category->kKategorie}" data-tab_block="1" data-tab_event="hover">
                <table>
                    <tr>
                        <td class="menu__sub_sex">
                             <ul>
                                <li class="active" data-tab_for="{$category->kKategorie}1" data-tab_block="{$category->kKategorie}2">
                                    <img class="svg" src="{$currentTemplateDir}images/menu/man_.svg" />
                                    <img class="svg hover" src="{$currentTemplateDir}images/menu/man_hover.svg" />
                                </li>
                                <li data-tab_for="{$category->kKategorie}2" data-tab_block="{$category->kKategorie}2">
                                    <img class="svg" src="{$currentTemplateDir}images/menu/woman_.svg" />
                                    <img class="svg hover" src="{$currentTemplateDir}images/menu/woman_hover.svg" />
                                </li>
                                <li data-tab_for="{$category->kKategorie}3" data-tab_block="{$category->kKategorie}2">
                                    <img class="svg menu__sub_block_sm" class="menu__sub_block_sm" src="{$currentTemplateDir}images/menu/child_.svg" />
                                    <img class="svg menu__sub_block_sm hover" src="{$currentTemplateDir}images/menu/child_hover.svg" />
                                </li>
                            </ul>
                        </td>
                        <td valign="top">
                            <div class="menu__sub_items active eight-cols" data-tab_for="{$category->kKategorie}1" data-tab_block="{$category->kKategorie}2">
                                <ul class="">
                                    {assign var="url_prefix" value="__Herren"}
                                    {assign var="image_enabled" value=true}
                                    {foreach name='sub_categories' from=$sub_categories item='sub'}
                                        {include file='snippets/subcategories_mega_item.tpl'}
                                    {/foreach}
                                </ul>
                            </div>
                            <div class="menu__sub_items eight-cols" data-tab_for="{$category->kKategorie}2" data-tab_block="{$category->kKategorie}2">
                                <ul class="">
                                    {assign var="url_prefix" value="__Damen"}
                                    {assign var="image_enabled" value=true}
                                    {foreach name='sub_categories' from=$sub_categories item='sub'}
                                        {include file='snippets/subcategories_mega_item.tpl'}
                                    {/foreach}
                                </ul>
                            </div>
                            <div class="menu__sub_items eight-cols" data-tab_for="{$category->kKategorie}3" data-tab_block="{$category->kKategorie}2">
                                <ul class="">
                                    {assign var="url_prefix" value="__Unisex"}
                                    {assign var="image_enabled" value=true}
                                    {foreach name='sub_categories' from=$sub_categories item='sub'}
                                        {include file='snippets/subcategories_mega_item.tpl'}
                                    {/foreach}
                                </ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        {elseif $category->cKurzbezeichnung == "Fahrräder"}
            <div class="menu__sub_block" data-tab_for="{$category->kKategorie}" data-tab_block="1" data-tab_event="hover">
                <table>
                    <tr>
                        <td valign="top">
                            <div class="menu__sub_items active seven-cols">
                                <ul class="">
                                    {assign var="image_enabled" value=true}
                                    {foreach name='sub_categories' from=$sub_categories item='sub'}
                                        {include file='snippets/subcategories_mega_item.tpl'}
                                    {/foreach}
                                </ul>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td valign="top" colspan="7">
                            <div class="menu__sub_items menu__sub_brands active seven-cols logos preloader_block">
                                <div class="logos__box preloader_content"></div>
                                <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        {else}
            <div class="menu__sub_block block--item " data-tab_for="{$category->kKategorie}" data-tab_block="1" data-tab_event="hover">
                <table>
                    <tr>
                        <td valign="top">
                            <div class="menu__sub_items active seven-cols">
                                <ul class="">
                                    {assign var="image_enabled" value=false}
                                    {foreach name='sub_categories' from=$sub_categories item='sub'}
                                        {include file='snippets/subcategories_mega_item.tpl'}
                                    {/foreach}
                                </ul>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td  valign="top" colspan="7">
                            <div class="menu__sub_items menu__sub_brands active seven-cols logos preloader_block">
                                <div class="logos__box preloader_content"></div>
                                <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
                            </div>
                        </td>
                    </tr>

                </table>
            </div>
        {/if}

    {/if}
{/foreach}


