{strip}
{if $productlist|@count > 0}
    {if !isset($tplscope)}
        {assign var='tplscope' value='slider'}
    {/if}

    <div class="item-description-title">
        {if $title|strlen > 0}
            <span>
                {$title}
                {if !empty($moreLink)}
                    <a class="more pull-right" href="{$moreLink}" title="{$moreTitle}" data-toggle="tooltip" data-placement="auto right">
                        <i class="fa fa-arrow-circle-right"></i>
                    </a>
                {/if}
            </span>
        {/if}
    </div>


    <ul class="bxslider_default item-description-list fix-inb">
        {foreach name="sliderproducts" from=$productlist item='product'}
            <li class="col-md-4 col-sm-4 col-xs-4">
                {include file='productlist/item_slider.tpl' Artikel=$product tplscope=$tplscope class=''}
            </li>
        {/foreach}
    </ul>




{/if}
{/strip}