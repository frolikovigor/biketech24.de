<div id="comment{$oBewertung->kBewertung}" class="comment">
    <div class="comment__name col-md-2 col-sm-3 col-xs-6">
        <span class="comment-big">Emma Bike</span>
        <span>{$oBewertung->Datum}</span>
    </div>
    <div class="comment__picture col-md-2 col-sm-2 col-xs-6">
        <div class="cp-frame">
            <img src="{$currentTemplateDir}images/avatar.png">
        </div>
    </div>
    <div class="comment__text col-md-8 col-sm-7 col-xs-12">
        <div>
            <span class="comment-big">{$oBewertung->cName}</span>
            {include file='productdetails/rating.tpl' total=$oBewertung->nSterne type="3"}
        </div>
        <span>
            <blockquote>
                <p itemprop="reviewBody">{$oBewertung->cText|nl2br}</p>
            </blockquote>
            <img itemprop="image" src="{$Artikel->cVorschaubild}" alt="{$oBewertung->cTitel}" class="hidden" />
        </span>
    </div>
</div>
