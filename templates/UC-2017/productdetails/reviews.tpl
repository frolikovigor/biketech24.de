<div class="item-comments">

    <div class="item-description-title col-md-12 col-sm-12 col-xs-12">
        <span>Kundenmeinungen ({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl})</span>
    </div>

    <div class="rating col-md-12 col-sm-12 col-xs-12">
        <div class="fix-inb">



            <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" id="article_rating">
                {$jtl_token}



                <div class="rating-stars col-md-4 col-sm-5 col-xs-12">
                    <span>Gesamtwertung</span>

                    {include file='productdetails/rating.tpl' total=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt type="2"}

                    {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl == 0}
                        <p>{lang key="firstReview" section="global"}: </p>
                    {else}
                        <p>{lang key="shareYourExperience" section="product rating"}: </p>
                    {/if}
                    <input name="bfa" type="hidden" value="1" />
                    <input name="a" type="hidden" value="{$Artikel->kArtikel}" />
                    <input name="bewerten" type="submit" value="{lang key="productAssess" section="product rating"}" class="btn-rating" />
                </div>
                <div class="rating-bars col-md-8 col-sm-7 col-xs-12">

                    {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}

                        {foreach name=sterne from=$Artikel->Bewertungen->nSterne_arr item=nSterne key=i}
                            {assign var=int1 value=5}
                            {math equation='x - y' x=$int1 y=$i assign='schluessel'}
                            {assign var=int2 value=100}
                            {math equation='a/b*c' a=$nSterne b=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl c=$int2 assign='percent'}
                            <div class="bar-item">
                                <span>
                                    {if isset($bewertungSterneSelected) && $bewertungSterneSelected === $schluessel}
                                    <strong>
                                        {/if}
                                        {if $nSterne > 0 && (!isset($bewertungSterneSelected) || $bewertungSterneSelected !== $schluessel)}
                                            <a href="{$Artikel->cURLFull}?btgsterne={$schluessel}#tab-votes">{$schluessel} {if $i == 4}{lang key="starSingular" section="product rating"}{else}{lang key="starPlural" section="product rating"}{/if}</a>
                                        {else}
                                            {$schluessel} {if $i == 4}{lang key="starSingular" section="product rating"}{else}{lang key="starPlural" section="product rating"}{/if}
                                        {/if}
                                        {if isset($bewertungSterneSelected) && $bewertungSterneSelected === $schluessel}
                                    </strong>
                                    {/if}
                                </span>
                                <div class="bar-item_bar">
                                    <div class="star-bar" style="width: {$percent}%"></div>
                                </div>
                                <span class="bar-item_number">({$nSterne})</span>
                            </div>
                        {/foreach}
                    {/if}
                </div>
            </form>
        </div>
    </div>

    <div class="col-md-12 col-sm-12 col-xs-12">

        {if $ratingPagination->getPageItemCount() > 0}
            {include file="snippets/pagination_reviews.tpl" oPagination=$ratingPagination cThisUrl=$Artikel->cURLFull cAnchor='tab-votes'}
            <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" class="reviews-list">
                {$jtl_token}
                <input name="bhjn" type="hidden" value="1" />
                <input name="a" type="hidden" value="{$Artikel->kArtikel}" />
                <input name="btgsterne" type="hidden" value="{$BlaetterNavi->nSterne}" />
                <input name="btgseite" type="hidden" value="{$BlaetterNavi->nAktuelleSeite}" />

                {foreach name=artikelbewertungen from=$ratingPagination->getPageItems() item=oBewertung}
                    <div class="review panel panel-default {if $smarty.foreach.artikelbewertungen.last}last{/if}">
                        <div class="panel-body">
                            {include file="productdetails/review_item.tpl" oBewertung=$oBewertung}
                        </div>
                    </div>
                {/foreach}
            </form>
            {include file="snippets/pagination_reviews.tpl" oPagination=$ratingPagination cThisUrl=$Artikel->cURLFull cAnchor='tab-votes' showFilter=false}
        {/if}
    </div>
</div>











<div class="reviews row">
    <div class="col-xs-12">


        {if isset($Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich) &&
            $Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich > 0
        }
            <div class="review-wrapper reviews-mosthelpful panel">
                <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes">
                    {$jtl_token}
                    {block name="productdetails-review-most-helpful"}
                    <input name="bhjn" type="hidden" value="1" />
                    <input name="a" type="hidden" value="{$Artikel->kArtikel}" />
                    <input name="btgsterne" type="hidden" value="{$BlaetterNavi->nSterne}" />
                    <input name="btgseite" type="hidden" value="{$BlaetterNavi->nAktuelleSeite}" />
                    <div class="panel-wrap">
                        <div class="review panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">{lang key="theMostUsefulRating" section="product rating"}</h3>
                            </div>
                            <div class="panel-body">
                                {foreach name=artikelhilfreichstebewertungen from=$Artikel->HilfreichsteBewertung->oBewertung_arr item=oBewertung}
                                    {include file="productdetails/review_item.tpl" oBewertung=$oBewertung bMostUseful=true}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                    {/block}
                </form>
            </div>
        {/if}


    </div>{* /col *}
</div>{* /row *}




