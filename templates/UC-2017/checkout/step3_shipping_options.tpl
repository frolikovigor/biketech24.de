{if !empty($hinweis)}
    <div class="alert alert-danger">
        {$hinweis}
    </div>
{/if}
<div class="row">
    <div class="col-xs-12">
        {block name="checkout-shipping-options"}
        <div class="panel-wrap">
            {block name="checkout-shipping-options-body"}
            <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form">
                {$jtl_token}
                <fieldset>
                    {if !isset($Versandarten)}
                        <div class="alert alert-danger">{lang key="noShippingMethodsAvailable" section="checkout"}</div>
                    {else}
                        <ul class="list-group">
                            {foreach name=shipment from=$Versandarten item=versandart}
                                <li id="shipment_{$versandart->kVersandart}" class="list-group-item">
                                    <div class="radio">
                                        <label for="del{$versandart->kVersandart}" class="btn-block">
                                            <div class="row">
                                                <div class="col-xs-7 col-md-9 col-lg-9">
                                                    <p>
                                                        <input name="Versandart" value="{$versandart->kVersandart}" type="radio" id="del{$versandart->kVersandart}"{if $Versandarten|@count == 1} checked{/if}{if $smarty.foreach.shipment.first} required{/if}>
                                                        &nbsp;{if $versandart->cBild}
                                                            <img src="{$versandart->cBild}" alt="{$versandart->angezeigterName|trans}">
                                                        {else}
                                                            <strong>{$versandart->angezeigterName|trans}</strong>
                                                        {/if}
                                                    </p>
                                                </div>
                                                <div class="col-xs-5 col-md-3 col-lg-3">
                                                    <span class="badge pull-right">{$versandart->cPreisLocalized}</span>
                                                </div>
                                            </div>
                                            {if isset($versandart->specificShippingcosts_arr)}
                                                    {foreach name=specificShippingcosts from=$versandart->specificShippingcosts_arr item=specificShippingcosts}
                                                        <div class="row">
                                                            <div class="col-xs-8 col-md-9 col-lg-9">
                                                                <ul>
                                                                    <li>
                                                                        <small>{$specificShippingcosts->cName|trans}</small>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-xs-4 col-md-3 col-lg-3 text-right">
                                                                <small>
                                                                    {$specificShippingcosts->cPreisLocalized}
                                                                </small>
                                                            </div>
                                                        </div>
                                                    {/foreach}
                                            {/if}
                                                {if !empty($versandart->angezeigterHinweistext|trans) && $versandart->angezeigterHinweistext|has_trans}
                                                    <p>
                                                        <small>{$versandart->angezeigterHinweistext|trans}</small>
                                                    </p>
                                                {/if}
                                                {if !empty($versandart->Zuschlag->fZuschlag)}
                                                    <p>
                                                        <small>{$versandart->Zuschlag->angezeigterName|trans}
                                                            (+{$versandart->Zuschlag->cPreisLocalized})
                                                        </small>
                                                    </p>
                                                {/if}

                                                {if !empty($versandart->cLieferdauer|trans) && $Einstellungen.global.global_versandermittlung_lieferdauer_anzeigen === 'Y'}
                                                    <p>
                                                        <small>{lang key="shippingTimeLP" section="global"}
                                                            : {$versandart->cLieferdauer|trans}</small>
                                                    </p>
                                                {/if}
                                        </label>
                                    </div>
                                </li>
                            {/foreach}
                        </ul>
                    {/if}

                    {if isset($Verpackungsarten) && $Verpackungsarten|@count > 0}
                        <div class="form-group">
                            {foreach name=zusatzverpackungen from=$Verpackungsarten item=oVerpackung}
                                <div class="checkbox">
                                    <label for="pac{$oVerpackung->kVerpackung}">
                                        <input name="kVerpackung[]" type="checkbox" value="{$oVerpackung->kVerpackung}" id="pac{$oVerpackung->kVerpackung}" />{$oVerpackung->cName}
                                        <p>
                                            <small>{$oVerpackung->cBeschreibung}</small>
                                        </p>
                                    </label>
                                    &nbsp;<span class="label label-default">
                           {if $oVerpackung->nKostenfrei == 1}{lang key="ExemptFromCharges" section="global"}{else}{$oVerpackung->fBruttoLocalized}{/if}
                           </span>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                </fieldset>

                {if isset($Versandarten)}
                    <input type="hidden" name="versandartwahl" value="1" />

                    <input type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn-d btn-lg pull-right" />
                {/if}
            </form>
            {/block}
        </div>
        {/block}
    </div>
</div>