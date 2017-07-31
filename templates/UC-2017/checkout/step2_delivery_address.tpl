<script type="text/javascript">
    {literal}
    function changeState(state) {
        var id = parseInt(state);
        if (id >= 0) {
            $('#checkout-deliveryaddress').hide('slow', function () {
                $(this).removeClass("active");
                $('#checkout-choose-deliveryaddress').addClass("active");
            });
            $('#checkout-choose-deliveryaddress .btn-d.submit').show();
        } else {
            $('#checkout-deliveryaddress').show('slow', function () {
                $(this).addClass("active");
                $('#checkout-choose-deliveryaddress').removeClass("active");
            });
            $('#checkout-choose-deliveryaddress .btn-d.submit').hide();
        }
    }
    {/literal}
</script>
<div class="row">
    <div class="col-xs-12">
        {block name="checkout-enter-shipping-address"}
        <div class="panel-wrap checkbox_ajax">
            {block name="checkout-enter-shipping-address-body"}
            <form id="checkout-choose-deliveryaddress" class="active" method="post" action="{get_static_route id='bestellvorgang.php'}" onsubmit="checkoutAjax($(this)); return false;">
                {$jtl_token}
                <fieldset>
                    <ul class="list-group">
                        <li class="list-group-item">
                            <div class="radio">
                                <label class="control-label" for="delivery0"><input type="radio" name="kLieferadresse" onclick="changeState('0')" value="0" id="delivery0" {if $kLieferadresse == 0}checked{/if}>
                                    {lang key="shippingAdressEqualBillingAdress" section="account data"}
                                </label>
                            </div>
                        </li>
                        {if !empty($Lieferadressen)}
                            {foreach name=lieferad from=$Lieferadressen item=adresse}
                                {if $adresse->kLieferadresse>0}
                                    <li class="list-group-item">
                                        <div class="radio">
                                            <label class="control-label" for="delivery{$adresse->kLieferadresse}">
                                                <input type="radio" name="kLieferadresse" onclick="changeState('{$adresse->kLieferadresse}')" value="{$adresse->kLieferadresse}" id="delivery{$adresse->kLieferadresse}" {if $kLieferadresse==$adresse->kLieferadresse}checked{/if}>{if $adresse->cFirma}{$adresse->cFirma},{/if} {$adresse->cVorname} {$adresse->cNachname}
                                                , {$adresse->cStrasse} {$adresse->cHausnummer}, {$adresse->cPLZ} {$adresse->cOrt}
                                                , {$adresse->angezeigtesLand}</label>
                                        </div>
                                    </li>
                                {/if}
                            {/foreach}
                        {/if}
                        <li class="list-group-item">
                            <div class="radio">
                                <label class="control-label" for="delivery_new"><input type="radio" name="kLieferadresse" onclick="changeState('-1')" value="-1" id="delivery_new" {if $kLieferadresse == -1}checked{/if}>
                                    {lang key="createNewShippingAdress" section="account data"}
                                </label>
                            </div>
                        </li>
                    </ul>
                </fieldset>
                <fieldset>
                    <input type="hidden" name="lieferdaten" value="1" />
                    <input type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn-d btn-lg pull-right{if $kLieferadresse != 0} hidden-initial{/if}" />
                </fieldset>
            </form>
            
            
            <form id="checkout-deliveryaddress" method="post" action="{get_static_route id='bestellvorgang.php'}" class="address{if $kLieferadresse == 0} hidden-initial{/if}" onsubmit="checkoutAjax($(this)); return false;">
                {$jtl_token}
                <div class="login-form">
                    <fieldset>
                        <h2>{lang key="yourShippingAdress" section="account data"}</h2>
                        {* salutation / title *}
                        <div class="row">
                            {if $Einstellungen.kunden.lieferadresse_abfragen_anrede !== 'N'}
                                <div class="col-xs-12 col-md-6">
                                    <div class="item white-select float-label-control{if !empty($fehlendeAngaben.anrede)} has-error{/if} required">
                                        <h5>{lang key="salutation" section="account data"}</h5>
                                        <select name="anrede" id="salutation" required>
                                            <option value="" selected="selected" disabled>{lang key="salutation" section="account data"}</option>
                                            <option value="w"{if isset($Lieferadresse->cAnrede) && $Lieferadresse->cAnrede === 'w'} selected="selected"{/if}>{$Anrede_w}</option>
                                            <option value="m"{if isset($Lieferadresse->cAnrede) && $Lieferadresse->cAnrede === 'm'} selected="selected"{/if}>{$Anrede_m}</option>
                                        </select>
                                        {if !empty($fehlendeAngaben.anrede)}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}

                            {if $Einstellungen.kunden.lieferadresse_abfragen_titel !== 'N'}
                                <div class="col-xs-12 col-md-6">
                                    <div class="item float-label-control{if !empty($fehlendeAngaben.titel)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_titel === 'Y'} required{/if}">
                                        <h5>{lang key="title" section="account data"}</h5>
                                        <input type="text" name="titel" value="{if isset($Lieferadresse->cTitel)}{$Lieferadresse->cTitel}{/if}" id="title"  placeholder="{lang key="title" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_titel === 'Y'} required{/if}>
                                        {if !empty($fehlendeAngaben.titel)}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>

                        {* firstname lastname *}
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="item float-label-control{if !empty($fehlendeAngaben.vorname)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}">
                                    <h5>{lang key="firstName" section="account data"}</h5>
                                    <input type="text" name="vorname" value="{if isset($Lieferadresse->cVorname)}{$Lieferadresse->cVorname}{/if}" id="firstName" placeholder="{lang key="firstName" section="account data"}"{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}>
                                    {if !empty($fehlendeAngaben.vorname)}
                                        {if $fehlendeAngaben.vorname == 1}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {elseif $fehlendeAngaben.vorname == 2}
                                            <div class="alert alert-danger">{lang key="firstNameNotNumeric" section="account data"}</div>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="item float-label-control{if !empty($fehlendeAngaben.nachname)} has-error{/if} required">
                                    <h5>{lang key="lastName" section="account data"}</h5>
                                    <input type="text" name="nachname" value="{if isset($Lieferadresse->cNachname)}{$Lieferadresse->cNachname}{/if}" id="lastName" placeholder="{lang key="lastName" section="account data"}" required />
                                    {if !empty($fehlendeAngaben.nachname)}
                                        {if $fehlendeAngaben.nachname == 1}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {elseif $fehlendeAngaben.nachname == 2}
                                            <div class="alert alert-danger">{lang key="lastNameNotNumeric" section="account data"}</div>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        </div>

                        {* company *}
                        <div class="row">
                            {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma !== 'N'}
                                <div class="col-xs-12 col-md-6">
                                    <div class="item float-label-control{if !empty($fehlendeAngaben.firma)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}">
                                        <h5>{lang key="firm" section="account data"}</h5>
                                        <input type="text" name="firma" value="{if isset($Lieferadresse->cFirma)}{$Lieferadresse->cFirma}{/if}" id="firm" placeholder="{lang key="firm" section="account data"}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}>
                                        {if !empty($fehlendeAngaben.firma)}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}

                            {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz !== 'N'}
                                <div class="col-xs-12 col-md-6">
                                    <div class="item float-label-control{if !empty($fehlendeAngaben.firmazusatz)} has-error{/if}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}>
                                        <h5>{lang key="firmext" section="account data"}</h5>
                                        <input type="text" name="firmazusatz" value="{if isset($Lieferadresse->cZusatz)}{$Lieferadresse->cZusatz}{/if}" id="firm" placeholder="{lang key="firmext" section="account data"}"{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}>
                                        {if !empty($fehlendeAngaben.firmazusatz)}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>

                        {* street / number *}
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="item float-label-control{if !empty($fehlendeAngaben.strasse)} has-error{/if} required">
                                    <h5>{lang key="street" section="account data"}</h5>
                                    <input type="text" name="strasse" value="{if isset($Lieferadresse->cStrasse)}{$Lieferadresse->cStrasse}{/if}" id="street" placeholder="{lang key="street" section="account data"}" required>
                                    {if !empty($fehlendeAngaben.strasse)}
                                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                    {/if}
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-3">
                                <div class="item float-label-control{if !empty($fehlendeAngaben.hausnummer)} has-error{/if} required">
                                    <h5>{lang key="streetnumber" section="account data"}</h5>
                                    <input type="text" name="hausnummer" value="{if isset($Lieferadresse->cHausnummer)}{$Lieferadresse->cHausnummer}{/if}" id="streetnumber" placeholder="{lang key="streetnumber" section="account data"}" required />
                                    {if !empty($fehlendeAngaben.hausnummer)}
                                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                    {/if}
                                </div>
                            </div>
                        </div>

                        {* address addition *}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz !== 'N'}
                            <div class="row">
                                <div class="col-xs-12 col-md-6">
                                    <div class="item float-label-control{if !empty($fehlendeAngaben.adresszusatz)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz === 'Y'} required{/if}">
                                        <h5>{lang key="street2" section="account data"}</h5>
                                        <input type="text" name="adresszusatz" value="{if isset($Lieferadresse->cAdressZusatz)}{$Lieferadresse->cAdressZusatz}{/if}" id="street2" placeholder="{lang key="street2" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz === 'Y'} required{/if}>
                                        {if !empty($fehlendeAngaben.adresszusatz)}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {* country *}
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="item white-select float-label-control">
                                    <h5>{lang key="country" section="account data"}</h5>
                                    <select name="land" id="delivery-country" class="country_input">
                                        <option value="" selected disabled>{lang key="country" section="account data"}*</option>
                                        {foreach name=land from=$laender item=land}
                                            <option value="{$land->cISO}" {if empty($Lieferadresse->cLand) && $Einstellungen.kunden.kundenregistrierung_standardland == $land->cISO || (isset($Lieferadresse->cLand) && $Lieferadresse->cLand==$land->cISO)}selected{/if}>{$land->cName}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            {if $Einstellungen.kunden.lieferadresse_abfragen_bundesland !== 'N'}
                                <div class="col-xs-12 col-md-6">
                                    <div class="item float-label-control{if !empty($fehlendeAngaben.bundesland)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_bundesland === 'Y'} required{/if}">
                                        <h5>{lang key="state" section="account data"}</h5>
                                        <input type="text" title="{lang key=pleaseChoose}" name="bundesland" value="{if isset($Lieferadresse->cBundesland)}{$Lieferadresse->cBundesland}{/if}" id="state" placeholder="{lang key="state" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_bundesland === 'Y'} required{/if}>
                                        {if !empty($fehlendeAngaben.bundesland)}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>{* /row *}

                        {* zip / city *}
                        <div class="row">
                            <div class="col-xs-12 col-md-3">
                                <div class="item float-label-control{if !empty($fehlendeAngaben.plz)} has-error{/if} required">
                                    <h5>{lang key="plz" section="account data"}</h5>
                                    <input type="text" name="plz" value="{if isset($Lieferadresse->cPLZ)}{$Lieferadresse->cPLZ}{/if}" id="plz" class="plz_input" placeholder="{lang key="plz" section="account data"}" required>
                                    {if !empty($fehlendeAngaben.plz)}
                                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="item float-label-control{if !empty($fehlendeAngaben.ort)} has-error{/if} required">
                                    <h5>{lang key="city" section="account data"}</h5>
                                    <input type="text" name="ort" value="{if isset($Lieferadresse->cOrt)}{$Lieferadresse->cOrt}{/if}" id="city" class="city_input" placeholder="{lang key="city" section="account data"}" required>
                                    {if !empty($fehlendeAngaben.ort)}
                                        {if $fehlendeAngaben.ort == 3}
                                            <div class="alert alert-danger">{lang key="cityNotNumeric" section="account data"}</div>
                                        {else}
                                            <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>

                        {* email *}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_email === 'Y' || $Einstellungen.kunden.lieferadresse_abfragen_email === 'O'}
                            <div class="row">
                                <div class="col-xs-12 col-md-6">
                                    <div class="item float-label-control{if !empty($fehlendeAngaben.email)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_email === 'Y'} required{/if}">
                                        <h5>{lang key="email" section="account data"}</h5>
                                        <input type="email" name="email" value="{if isset($Lieferadresse->cMail)}{$Lieferadresse->cMail}{/if}" id="email" placeholder="{lang key="email" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_email === 'Y'} required{/if} />
                                        {if !empty($fehlendeAngaben.email)}
                                            <div class="alert alert-danger">
                                                {if $fehlendeAngaben.email == 1}{lang key="fillOut" section="global"}
                                                {elseif $fehlendeAngaben.email == 2}{lang key="invalidEmail" section="global"}
                                                {elseif $fehlendeAngaben.email == 3}{lang key="blockedEmail" section="global"}
                                                {elseif $fehlendeAngaben.email == 4}{lang key="noDnsEmail" section="account data"}
                                                {elseif $fehlendeAngaben.email == 5}{lang key="emailNotAvailable" section="account data"}{/if}
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {* fone & fax *}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N' || $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'}
                            <div class="row">
                                {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N'}
                                    <div class="col-xs-12 col-md-6">
                                        <div class="item float-label-control{if !empty($fehlendeAngaben.tel)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_tel === 'Y'} required{/if}">
                                            <h5>{lang key="tel" section="account data"}</h5>
                                            <input type="tel" name="tel" value="{if isset($Lieferadresse->cTel)}{$Lieferadresse->cTel}{/if}" id="tel" placeholder="{lang key="tel" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_tel === 'Y'} required{/if}>
                                            {if !empty($fehlendeAngaben.tel)}
                                                <div class="alert alert-danger">
                                                    {if $fehlendeAngaben.tel == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.tel == 2}{lang key="invalidTel" section="global"}{/if}
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                {/if}

                                {if $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'}
                                    <div class="col-xs-12 col-md-6">
                                        <div class="item float-label-control{if !empty($fehlendeAngaben.fax)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_fax === 'Y'} required{/if}">
                                            <h5>{lang key="fax" section="account data"}</h5>
                                            <input type="tel" name="fax" value="{if isset($Lieferadresse->cFax)}{$Lieferadresse->cFax}{/if}" id="fax" placeholder="{lang key="fax" section="account data"}" {lang key="fax" section="account data"}{if $Einstellungen.kunden.lieferadresse_abfragen_fax === 'Y'} required{/if}>
                                            {if !empty($fehlendeAngaben.fax)}
                                                <div class="alert alert-danger">
                                                    {if $fehlendeAngaben.fax == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.fax == 2}{lang key="invalidTel" section="global"}{/if}
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        {/if}

                        {if $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N' || isset($Einstellungen.kunden.lieferadresse_abfragen_www) && $Einstellungen.kunden.lieferadresse_abfragen_www !== 'N'}
                            <div class="row">
                                {if $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'}
                                    <div class="col-xs-12 col-md-6">
                                        <div class="item float-label-control{if !empty($fehlendeAngaben.mobil)} has-error{/if}{if $Einstellungen.kunden.lieferadresse_abfragen_mobil === 'Y'} required{/if}">
                                            <h5>{lang key="mobile" section="account data"}</h5>
                                            <input type="tel" name="mobil" value="{if isset($Lieferadresse->cMobil)}{$Lieferadresse->cMobil}{/if}" id="mobile" placeholder="{lang key="mobile" section="account data"}"{if $Einstellungen.kunden.lieferadresse_abfragen_mobil === 'Y'} required{/if} />
                                            {if !empty($fehlendeAngaben.mobil)}
                                                <div class="alert alert-danger">
                                                    {if $fehlendeAngaben.mobil == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.mobil == 2}{lang key="invalidTel" section="global"}{/if}
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        {/if}
                    </fieldset>
                    <fieldset>
                        <input type="hidden" name="lieferdaten" value="1" />
                        <input type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn-d btn-lg pull-right" />
                    </fieldset>
                </div>
            </form>
            {/block}

            <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
        </div>


        <div class="checkout_ajax_content">

        </div>
        {/block}
    </div>

</div>
{if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
    <script type="text/javascript">
        $(function() {
            eModal.confirm({ldelim}message: '{lang key="basket2PersMerge" section="login"}', label1: '{lang key="no" section="global"}', label2: '{lang key="yes" section="global"}'{rdelim}, '{lang key="basket" section="global"}', function(res) {
                if (res) {
                    window.location = "{get_static_route id='bestellvorgang.php'}?basket2Pers=1"
                }
            });
        });
    </script>
{/if}