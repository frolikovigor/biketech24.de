{if $BoxenEinstellungen.navigationsfilter.merkmalfilter_verwenden === 'box'}
    {if isset($Suchergebnisse) && $Suchergebnisse->MerkmalFilter|@count > 0}
        {foreach name=merkmalfilter from=$Suchergebnisse->MerkmalFilter item=Merkmal}
            {assign var=kMerkmal value=$Merkmal->kMerkmal}
            <section class="panel panel-default box box-filter-characteristics">
                {if ($Merkmal->cTyp === 'SELECTBOX') && $Merkmal->oMerkmalWerte_arr|@count > 1}
                    <div class="panel-heading dropdown">
                        <h5 class="panel-title">
                            {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' && !empty($Merkmal->cBildpfadKlein) && $Merkmal->cBildpfadKlein !== $BILD_KEIN_MERKMALBILD_VORHANDEN}
                                <img src="{$Merkmal->cBildpfadKlein}" alt="" class="vmiddle" />
                            {/if}
                            {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                                &nbsp;{$Merkmal->cName}
                            {/if}
                        </h5>
                    </div>
                    <div class="panel-body dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                            {$Merkmal->cName} &nbsp; <span class="fa fa-caret-down"></span>
                        </a>
                        {include file='snippets/filter/characteristic.tpl' Merkmal=$Merkmal class="dropdown-menu"}
                    </div>
                {else}

                    {if ($Merkmal->cName === 'Schuhgröße')}
                        <div class="filter-type__inner js-slide_toggle">
                            <div class="filter-head js-slide_toggle__event">
                                <h4 class="filter-type__title filter-type__title--sub">{$Merkmal->cName}</h4>
                                <div class="filter-choice"><span></span></div>
                            </div>
                            <div class="filter-parameters js-slide_toggle__block">
                                <ul class="parameters__list parameters__list_size">
                                    {foreach name=filter from=$Merkmal->oMerkmalWerte_arr item=MerkmalWert}
                                        <li>
                                            <a rel="nofollow" class="circle {if $MerkmalWert->nAktiv}active{/if}" href="{if !empty($MerkmalWert->cURL)}{$MerkmalWert->cURL}{else}#{/if}"{if $Merkmal->cTyp === 'BILD'} title="{$MerkmalWert->cWert}"{/if}>
                                                <span>{$MerkmalWert->cWert|escape:'html'}</span>
                                            </a>
                                        </li>
                                    {/foreach}

                                    <li class="off">
                                        <a href="#" class="circle">
                                            <span>s</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                        </div>

                        <hr>

                    {elseif ($Merkmal->cName === 'Farbe')}
                        <div class="filter-type__inner js-slide_toggle">
                            <div class="filter-head js-slide_toggle__event">
                                <h4 class="filter-type__title filter-type__title--sub">{$Merkmal->cName}</h4>

                                <div class="filter-choice"><span></span></div>
                            </div>
                            <div class="filter-parameters js-slide_toggle__block">
                                <ul class="parameters__list parameters__list_color">
                                    {foreach name=filter from=$Merkmal->oMerkmalWerte_arr item=MerkmalWert}
                                        <li class="circle circle_{transliteration($MerkmalWert->cWert|escape:'html')} {transliteration($MerkmalWert->cWert|escape:'html')} {if $MerkmalWert->nAktiv}active{/if}">
                                            <a rel="nofollow"  href="{$MerkmalWert->cURL}"{if $Merkmal->cTyp === 'BILD'} title="{$MerkmalWert->cWert|escape:'html'}"{/if}></a>
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>

                        <hr>
                    {else}
                        <div class="filter-type__inner js-slide_toggle">
                            <div class="filter-head js-slide_toggle__event">
                                <h4 class="filter-type__title filter-type__title--sub">{$Merkmal->cName}</h4>

                                <div class="filter-choice"><span></span></div>
                            </div>
                            <form method="POST" action="/" id="filterParametersFormEinsatzgebiet">
                                <div class="filter-parameters js-slide_toggle__block">
                                    <ul class="parameters__list">
                                        {include file='snippets/filter/characteristic.tpl' Merkmal=$Merkmal}
                                    </ul>
                                </div>
                            </form>

                            {if ($Merkmal->cName === 'Rahmenhöhe')}
                                <div class="info-block">
                                    <a href="#">
                                        <span class="block__question">Hilfe mit Größe?</span>
                                    </a>
                                    <div class="btn-block__info">
                                        <i class="icons icons_btn"></i>
                                        <a href="/Berater">
                                            <input class="btn-d btn_info" type="button" value="Zum Fahrradberater gehen">
                                        </a>
                                    </div>
                                </div>
                            {/if}
                        </div>
                    {/if}
                {/if}
            </section>
        {/foreach}
    {/if}
{/if}