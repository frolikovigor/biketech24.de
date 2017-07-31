{if
    $Artikel->cBeschreibung|strlen > 0 ||
    $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y' ||
    ($Einstellungen.artikeldetails.merkmale_anzeigen === 'Y' && $Artikel->oMerkmale_arr|count > 1) ||

    ($Einstellungen.preisverlauf.preisverlauf_anzeigen === 'Y' && $bPreisverlauf) ||
    $verfuegbarkeitsBenachrichtigung == 1 ||
    ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YM' && $Artikel->cMedienDateiAnzeige !== 'beschreibung') || $Artikel->cMedienDateiAnzeige === 'tab') && $Artikel->cMedienTyp_arr|@count > 0 && $Artikel->cMedienTyp_arr)}
    {if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen !== 'N'}
        {assign var=tabanzeige value=true}
    {else}
        {assign var=tabanzeige value=false}
    {/if}


<div class="item-description__tabs col-md-5 col-sm-5 col-xs-12">

    <div class="item-description-title">
        <div class="item-description-title_active col-md-6 col-sm-6 col-xs-6 active">
            <span>Beschreibung</span>
        </div>
        <div class="item-description-title_active col-md-6 col-sm-6 col-xs-6">
            <span>Datenblatt</span>
        </div>
    </div>

    <div class="item-description-tab col-md-5 col-sm-5 col-xs-12">

        {* ARTIKELBESCHREIBUNG *}

            <span class="tabs span-active">
                  {assign var=cArtikelBeschreibung value=$Artikel->cBeschreibung}
                <div class="desc">
                    {$cArtikelBeschreibung}

                    {if ($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YA' && $Artikel->cMedienDateiAnzeige !== 'tab') || $Artikel->cMedienDateiAnzeige === 'beschreibung'}
                        {if !empty($Artikel->cMedienTyp_arr)}
                            {foreach name="mediendateigruppen" from=$Artikel->cMedienTyp_arr item=cMedienTyp}
                                <div class="media">
                                    {include file='productdetails/mediafile.tpl'}
                                </div>
                            {/foreach}
                        {/if}
                    {/if}
                </div>
            </span>

            <span class="tabs">
                {block name="tab-description-attributes"}
                    {include file="productdetails/attributes.tpl" tplscope="details"}
                {/block}
            </span>
    </div>
</div>
{/if}

