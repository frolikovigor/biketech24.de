{get_category_array categoryId=0 assign='categories'}
{if !isset($activeId)}
    {if isset($NaviFilter->Kategorie) && intval($NaviFilter->Kategorie->kKategorie) > 0}
        {$activeId = $NaviFilter->Kategorie->kKategorie}
    {elseif $nSeitenTyp == 1 && isset($Artikel)}
        {assign var='activeId' value=$Artikel->gibKategorie()}
    {elseif $nSeitenTyp == 1 && isset($smarty.session.LetzteKategorie)}
        {$activeId = $smarty.session.LetzteKategorie}
    {else}
        {$activeId = 0}
    {/if}
{/if}
{if !isset($activeParents) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
    {get_category_parents categoryId=$activeId assign='activeParents'}
{/if}

{foreach name='categories' from=$categories item='category'}
    <td class="menu__item {if $category->kKategorie == $activeId || (isset($activeParents[0]) && $activeParents[0]->kKategorie == $category->kKategorie)} current{/if}" data-tab_for="{$category->kKategorie}" data-tab_event="hover" data-tab_block="1">
        <a href="{$category->cURL}">{$category->cKurzbezeichnung}</a>
    </td>
{/foreach}

{get_navigation linkgroupIdentifier='Mehr' assign='links'}

{if !empty($links)}
    {foreach name='links' from=$links item='li'}

        {*<td class="menu__item {if $Link->kLink == $li -> kLink}current{/if}" data-tab_for="Mehr_{$li->URL}" data-tab_event="hover" data-tab_block="1">*}
            {*<a href="{$li->URL}">{$li->cName}</a>*}
        {*</td>*}
    {/foreach}
{/if}




