{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<fieldset>
    {*<legend>*}
        {*{lang key="address" section="account data"}*}
    {*</legend>*}
    {* salutation / title *}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede !== 'N'}

                <div class="item white-select float-label-control{if isset($fehlendeAngaben.anrede)} has-error{/if} required">
                    <h5>{lang key="salutation" section="account data"}</h5>
                    <select name="anrede" id="salutation" required>
                        <option value="" selected="selected" disabled>{lang key="salutation" section="account data"}</option>
                        <option value="w" {if isset($Kunde->cAnrede) && $Kunde->cAnrede === 'w'}selected="selected"{/if}>{$Anrede_w}</option>
                        <option value="m" {if isset($Kunde->cAnrede) && $Kunde->cAnrede === 'm'}selected="selected"{/if}>{$Anrede_m}</option>
                    </select>
                    {if isset($fehlendeAngaben.anrede)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                </div>

        {/if}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_titel !== 'N'}
                <div class="item float-label-control{if isset($fehlendeAngaben.titel)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_titel === 'Y'} required{/if}">
                    <h5>{lang key="title" section="account data"}</h5>
                    <input 
                    type="text" 
                    name="titel" 
                    value="{if isset($Kunde->cTitel)}{$Kunde->cTitel}{/if}" 
                    id="title"
                    placeholder="{lang key="title" section="account data"}" 
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_titel === 'Y'}required{/if} 
                    >
                    {if isset($fehlendeAngaben.titel)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
                </div>
            </div>
        {/if}

    {* firstname lastname *}


            <div class="item float-label-control{if isset($fehlendeAngaben.vorname)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}">
                <h5>{lang key="firstName" section="account data"}</h5>
                <input
                        type="text"
                        name="vorname"
                        value="{if isset($Kunde->cVorname)}{$Kunde->cVorname}{/if}"
                        id="firstName"
                        placeholder="{lang key="firstName" section="account data"}"
                        {if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}
                >
                {if isset($fehlendeAngaben.vorname)}
                    {if $fehlendeAngaben.vorname == 1}
                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                    {elseif $fehlendeAngaben.vorname == 2}
                        <div class="alert alert-danger">{lang key="firstNameNotNumeric" section="account data"}</div>
                    {/if}
                {/if}
            </div>


            <div class="item float-label-control{if isset($fehlendeAngaben.nachname)} has-error{/if} required">
                <h5>{lang key="lastName" section="account data"}</h5>
                <input
                        type="text"
                        name="nachname"
                        value="{if isset($Kunde->cNachname)}{$Kunde->cNachname}{/if}"
                        id="lastName"
                        placeholder="{lang key="lastName" section="account data"}"
                        required
                >
                {if isset($fehlendeAngaben.nachname)}
                    {if $fehlendeAngaben.nachname == 1}
                        <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
                    {elseif $fehlendeAngaben.nachname == 2}
                        <div class="alert alert-danger">{lang key="lastNameNotNumeric" section="account data"}</div>
                    {/if}
                {/if}
            </div>


    {* firm / firmtext *}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma !== 'N'}

            <div class="item float-label-control{if isset($fehlendeAngaben.firma)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}">
                <label for="firm" class="control-label">{lang key="firm" section="account data"}</label>
                <input 
                type="text" 
                name="firma" 
                value="{if !empty($Kunde->cFirma)}{$Kunde->cFirma}{/if}"
                id="firm" 

                placeholder="{lang key="firm" section="account data"}" 
                {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if} 
                >
                {if isset($fehlendeAngaben.firma)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>

        {/if}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz !== 'N'}
            <div class="item float-label-control{if isset($fehlendeAngaben.firmazusatz)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}">
                <label for="firmext" class="control-label">{lang key="firmext" section="account data"}</label>
                <input 
                type="text" 
                name="firmazusatz" 
                value="{if isset($Kunde->cZusatz)}{$Kunde->cZusatz}{/if}" 
                id="firm"
                placeholder="{lang key="firmext" section="account data"}"
                {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if} 
                />
                {if isset($fehlendeAngaben.firmazusatz)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        {/if}

    {* street / number *}

        <div class="item float-label-control{if isset($fehlendeAngaben.strasse)} has-error{/if} required">
            <h5>{lang key="street" section="account data"}</h5>
            <input
                    type="text"
                    name="strasse"
                    value="{if isset($Kunde->cStrasse)}{$Kunde->cStrasse}{/if}"
                    id="street"
                    placeholder="{lang key="street" section="account data"}"
                    required
            >
            {if isset($fehlendeAngaben.strasse)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
        </div>


        <div class="item float-label-control{if isset($fehlendeAngaben.hausnummer)} has-error{/if} required">
            <h5>{lang key="streetnumber" section="account data"}</h5>
            <input
                    type="text"
                    name="hausnummer"
                    value="{if isset($Kunde->cHausnummer)}{$Kunde->cHausnummer}{/if}"
                    id="streetnumber"
                    placeholder="{lang key="streetnumber" section="account data"}"
                    required
            >
            {if isset($fehlendeAngaben.hausnummer)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
        </div>


    {* adress addition *}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz !== 'N'}
        <div class="item float-label-control{if isset($fehlendeAngaben.adresszusatz)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz === 'Y'} required{/if}">
            <h5>{lang key="street2" section="account data"}</h5>
            <input
                    type="text"
                    name="adresszusatz"
                    value="{if isset($Kunde->cAdressZusatz)}{$Kunde->cAdressZusatz}{/if}"
                    id="street2"
                    placeholder="{lang key="street2" section="account data"}"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz === 'Y'} required{/if}
            />
            {if isset($fehlendeAngaben.adresszusatz)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
        </div>
    {/if}
    {* country *}

    <div class="item white-select float-label-control required">
        <h5>{lang key="country" section="account data"}</h5>

        {getCountries assign="listCountries"}

        <select name="land" id="country" class="country_input" required>
            <option value="" disabled>{lang key="country" section="account data"}</option>
            {foreach name=land from=$listCountries item=land}
                <option value="{$land->cISO}" {if ($Einstellungen.kunden.kundenregistrierung_standardland==$land->cISO && empty($Kunde->cLand)) || !empty($Kunde->cLand) && $Kunde->cLand == $land->cISO}selected="selected"{/if}>{$land->cName}</option>
            {/foreach}
        </select>
    </div>

    {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland !== 'N'}
        <div class="item float-label-control{if isset($fehlendeAngaben.bundesland)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y'} required{/if}">
            <h5>{lang key="state" section="account data"}</h5>
            <input
                    type="text"
                    title="{lang key=pleaseChoose}"
                    name="bundesland"
                    value="{if !empty($Kunde->cBundesland)}{$Kunde->cBundesland}{/if}"
                    id="state"
                    placeholder="{lang key="state" section="account data"}"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y'} required{/if}
            >
            {if isset($fehlendeAngaben.bundesland)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
        </div>
    {/if}
    {* zip / city *}


    <div class="item float-label-control{if isset($fehlendeAngaben.plz)} has-error{/if} required">
        <h5>{lang key="plz" section="account data"}</h5>
        <input
                type="text"
                name="plz"
                value="{if isset($Kunde->cPLZ)}{$Kunde->cPLZ}{/if}"
                id="plz"
                class="plz_input"
                placeholder="{lang key="plz" section="account data"}"
                required
        >
        {if isset($fehlendeAngaben.plz)}<div class="alert alert-danger">{if $fehlendeAngaben.plz >= 2}{lang key="checkPLZCity" section="checkout"}{else}{lang key="fillOut" section="global"}{/if}</div>{/if}
    </div>


    <div class="item float-label-control required{if isset($fehlendeAngaben.ort)} has-error{/if}">
        <h5>{lang key="city" section="account data"}</h5>
        <input
                type="text"
                name="ort"
                value="{if isset($Kunde->cOrt)}{$Kunde->cOrt}{/if}"
                id="city"
                class="city_input"
                placeholder="{lang key="city" section="account data"}"
                required
        >
        {if isset($fehlendeAngaben.ort)}
            {if $fehlendeAngaben.ort==3}
                <div class="alert alert-danger">{lang key="cityNotNumeric" section="account data"}</div>
            {else}
                <div class="alert alert-danger">{lang key="fillOut" section="global"}</div>
            {/if}
        {/if}
    </div>


    {* UStID *}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid !== 'N'}
        <div class="item float-label-control{if isset($fehlendeAngaben.ustid)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid === 'Y'} required{/if}">
            <label class="control-label" for="ustid">{lang key="ustid" section="account data"}</label>
            <input
                    type="text"
                    name="ustid"
                    value="{if isset($Kunde->cUSTID)}{$Kunde->cUSTID}{/if}"
                    id="ustid"
                    placeholder="{lang key="ustid" section="account data"}"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid === 'Y'} required{/if}
            >
            {if isset($fehlendeAngaben.ustid)}
                <div class="alert alert-danger">
                    {if $fehlendeAngaben.ustid == 1}{lang key="fillOut" section="global"}
                    {elseif $fehlendeAngaben.ustid == 2}{lang key="ustIDCaseTwo" section="global"}. {if $fehlendeAngaben.ustid_err|count > 0 && $fehlendeAngaben.ustid_err !== false}{lang key="ustIDCaseTwoB" section="global"}: {$fehlendeAngaben.ustid_err}{/if}
                    {elseif $fehlendeAngaben.ustid == 5}{lang key="ustIDCaseFive" section="global"}.{/if}
                </div>
            {/if}
        </div>
    {/if}
</fieldset>

<fieldset>
   {*<legend>{lang key="contactInformation" section="account data"}</legend>*}
    {* E-Mail *}
    <div class="item float-label-control required{if isset($fehlendeAngaben.email)} has-error{/if}">
        <h5>{lang key="email" section="account data"}</h5>
        <input
                type="email"
                name="email"
                value="{if isset($Kunde->cMail)}{$Kunde->cMail}{/if}"
                id="email"
                placeholder="{lang key="email" section="account data"}"
                required
        >
        {if isset($fehlendeAngaben.email)}
            <div class="alert alert-danger">
                {if $fehlendeAngaben.email == 1}{lang key="fillOut" section="global"}
                {elseif $fehlendeAngaben.email == 2}{lang key="invalidEmail" section="global"}
                {elseif $fehlendeAngaben.email == 3}{lang key="blockedEmail" section="global"}
                {elseif $fehlendeAngaben.email == 4}{lang key="noDnsEmail" section="account data"}
                {elseif $fehlendeAngaben.email == 5}{lang key="emailNotAvailable" section="account data"}{/if}
            </div>
        {/if}
    </div>

    {* phone & fax *}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_fax !== 'N'}
        {if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N'}
            <div class="item float-label-control{if isset($fehlendeAngaben.tel)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel === 'Y'} required{/if}">
                <h5>{lang key="tel" section="account data"}</h5>
                <input
                        type="tel"
                        name="tel"
                        value="{if isset($Kunde->cTel)}{$Kunde->cTel}{/if}"
                        id="tel"
                        placeholder="{lang key="tel" section="account data"}"
                        {if $Einstellungen.kunden.kundenregistrierung_abfragen_tel === 'Y'} required{/if}
                />
                {if isset($fehlendeAngaben.tel)}
                    <div class="alert alert-danger">
                        {if $fehlendeAngaben.tel == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.tel == 2}{lang key="invalidTel" section="global"}{/if}
                    </div>
                {/if}
            </div>

        {/if}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_fax !== 'N'}
            <div class="item float-label-control{if isset($fehlendeAngaben.fax)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_fax === 'Y'} required{/if}">
                <h5>{lang key="fax" section="account data"}</h5>
                <input
                        type="tel"
                        name="fax"
                        value="{if isset($Kunde->cFax)}{$Kunde->cFax}{/if}"
                        id="fax"
                        placeholder="{lang key="fax" section="account data"}"
                        {if $Einstellungen.kunden.kundenregistrierung_abfragen_fax === 'Y'} required{/if}
                />
                {if isset($fehlendeAngaben.fax)}
                    <div class="alert alert-danger">
                        {if $fehlendeAngaben.fax == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.fax == 2}{lang key="invalidTel" section="global"}{/if}
                    </div>
                {/if}
            </div>
        {/if}

    {/if}

    {if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N'}
            <div class="item float-label-control{if isset($fehlendeAngaben.mobil)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil === 'Y'} required{/if} ">
                <h5>{lang key="mobile" section="account data"}</h5>
                <input
                        type="tel"
                        name="mobil"
                        value="{if isset($Kunde->cMobil)}{$Kunde->cMobil}{/if}"
                        id="mobile"
                        placeholder="{lang key="mobile" section="account data"}"
                        {if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil === 'Y'} required{/if}
                />
                {if isset($fehlendeAngaben.mobil)}
                    <div class="alert alert-danger">
                        {if $fehlendeAngaben.mobil == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.mobil == 2}{lang key="invalidTel" section="global"}{/if}
                    </div>
                {/if}
            </div>
        {/if}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}
            <div class="item float-label-control{if isset($fehlendeAngaben.www)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_www === 'Y'} required{/if}">
                <h5>{lang key="www" section="account data"}</h5>
                <input
                        type="text"
                        name="www"
                        value="{if isset($Kunde->cWWW)}{$Kunde->cWWW}{/if}"
                        id="www"
                        placeholder="{lang key="www" section="account data"}"
                        {if $Einstellungen.kunden.kundenregistrierung_abfragen_www === 'Y'} required{/if}
                />
                {if isset($fehlendeAngaben.www)}<div class="alert alert-danger">{lang key="fillOut" section="global"}</div>{/if}
            </div>
        {/if}

    {/if}

    {if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag !== 'N'}
        <div class="item float-label-control{if isset($fehlendeAngaben.geburtstag)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag === 'Y'} required{/if}">
            <h5>{lang key="birthday" section="account data"}</h5>
            <input
                    type="text"
                    name="geburtstag"
                    value="{if isset($Kunde->dGeburtstag) && $Kunde->dGeburtstag !== '00.00.0000'}{$Kunde->dGeburtstag|date_format:"%d.%m.%Y"}{/if}"
                    id="birthday"
                    class="birthday"
                    placeholder="{lang key="birthdayFormat" section="account data"}"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag === 'Y'} required{/if}
            >
            {if isset($fehlendeAngaben.geburtstag)}
                <div class="alert alert-danger">
                    {if $fehlendeAngaben.geburtstag == 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.geburtstag == 2}{lang key="invalidDateformat" section="global"}{elseif $fehlendeAngaben.geburtstag == 3}{lang key="invalidDate" section="global"}{/if}
                </div>
            {/if}
        </div>
    {/if}
</fieldset>

{if $Einstellungen.kundenfeld.kundenfeld_anzeigen === 'Y' && !empty($oKundenfeld_arr)}
<fieldset>


    {foreach name=kundenfeld from=$oKundenfeld_arr item=oKundenfeld}
        {if $step === 'formular' || $step === 'unregistriert bestellen' || $step === 'rechnungsdaten'}
            {if empty($smarty.session.Kunde->kKunde) || $smarty.session.Kunde->kKunde == 0 || $smarty.session.Kunde->kKunde > 0}
                {assign var=kKundenfeld value=$oKundenfeld->kKundenfeld}
                <div class="item {if $oKundenfeld->cTyp !== 'auswahl'}white-select{/if} float-label-control{if isset($fehlendeAngaben.custom[$kKundenfeld])} has-error{/if}{if $oKundenfeld->nPflicht == 1} required{/if}">
                    {if $oKundenfeld->cTyp !== 'auswahl'}
                        <h5>{$oKundenfeld->cName}</h5>
                        <input
                                type="{if $oKundenfeld->cTyp === 'zahl'}number{elseif $oKundenfeld->cTyp === 'datum'}date{else}text{/if}"
                                name="custom_{$kKundenfeld}"
                                id="custom_{$kKundenfeld}"
                                value="{if isset($cKundenattribut_arr[$kKundenfeld]->cWert) && ($step === 'formular' || $step === 'unregistriert bestellen')}{$cKundenattribut_arr[$kKundenfeld]->cWert}{elseif isset($Kunde->cKundenattribut_arr[$kKundenfeld]->cWert)}{$Kunde->cKundenattribut_arr[$kKundenfeld]->cWert}{/if}"
                                placeholder="{$oKundenfeld->cName}"
                                {if ($oKundenfeld->nPflicht == 1 && $oKundenfeld->nEditierbar == 1) || ($oKundenfeld->nEditierbar == 0 && !empty($cKundenattribut_arr[$kKundenfeld]->cWert))} required{/if}
                                data-toggle="floatLabel"
                                data-value="no-js"
                                {if $oKundenfeld->nEditierbar == 0 && !empty($cKundenattribut_arr[$kKundenfeld]->cWert)}readonly{/if}/>
                        {if isset($fehlendeAngaben.custom[$kKundenfeld])}
                            <div class="alert alert-danger">
                                {if $fehlendeAngaben.custom[$kKundenfeld] === 1}{lang key="fillOut" section="global"}{elseif $fehlendeAngaben.custom[$kKundenfeld] === 2}{lang key="invalidDateformat" section="global"}{elseif $fehlendeAngaben.custom[$kKundenfeld] === 3}{lang key="invalidDate" section="global"}{elseif $fehlendeAngaben.custom[$kKundenfeld] === 4}{lang key="invalidInteger" section="global"}{/if}
                            </div>
                        {/if}
                    {else}
                        <h5>{$oKundenfeld->cName}</h5>
                        <select name="custom_{$kKundenfeld}" class="{if $oKundenfeld->nPflicht == 1} required{/if}" {if $oKundenfeld->nEditierbar == 0 && !empty($cKundenattribut_arr[$kKundenfeld]->cWert)}disabled{/if}>
                            <option value="" selected disabled>{lang key="pleaseChoose" section="global"}</option>
                            {foreach name=select from=$oKundenfeld->oKundenfeldWert_arr item=oKundenfeldWert}
                                <option value="{$oKundenfeldWert->cWert}" {if $step == 'formular' && isset($cKundenattribut_arr[$kKundenfeld]->cWert) && ($oKundenfeldWert->cWert == $cKundenattribut_arr[$kKundenfeld]->cWert)}selected{elseif isset($Kunde->cKundenattribut_arr[$kKundenfeld]->cWert) && ($oKundenfeldWert->cWert == $Kunde->cKundenattribut_arr[$kKundenfeld]->cWert)}selected{/if}>{$oKundenfeldWert->cWert}</option>
                            {/foreach}
                        </select>
                    {/if}
                </div>
            {/if}
        {/if}
    {/foreach}


</fieldset>
{/if}
{if !isset($fehlendeAngaben)}
    {assign var=fehlendeAngaben value=array()}
{/if}
{if !isset($cPost_arr)}
    {assign var=cPost_arr value=array()}
{/if}
{hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr bReturn="bHasCheckbox"}
{if $bHasCheckbox}
<fieldset>
    {if empty($cPost_arr)}
        {assign var='cPost_arr' value=null}
    {/if}

    {if empty($cPost_arr)}
        {assign var='cPost_arr' value=$smarty.post}
    {/if}

    {getCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$cPlausi_arr cPost_arr=$cPost_arr assign='checkboxes'}

    {if !empty($checkboxes)}
        {foreach name="checkboxes" from=$checkboxes item='cb'}
            <div class="item {if !empty($cb->cErrormsg)} has-error{/if}{if $cb->nPflicht == 1} required{/if}">
                <div class="checkbox">
                    <label class="control-label" for="{$cb->cID}">
                        <input type="checkbox"
                               name="{$cb->cID}"
                                {if $cb->nPflicht == 1}
                                    required
                                {/if}
                               value="Y" id="{$cb->cID}"
                                {if $cb->isActive}
                                    checked
                                {/if}
                        >
                        {$cb->cName}
                        {if !empty($cb->cLinkURL)}
                            <span class="moreinfo">(<a href="{$cb->cLinkURL}" class="popup checkbox-popup">{lang key="read" section="account data"}</a>)</span>
                        {/if}
                    </label>
                </div>
                {if !empty($cb->cBeschreibung)}
                    <p class="description text-muted small">
                        {$cb->cBeschreibung}
                    </p>
                {/if}
            </div>
        {/foreach}
    {/if}
</fieldset>
{/if}

{if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) && 
    isset($Einstellungen.global.anti_spam_method) && $Einstellungen.global.anti_spam_method !== 'N' &&
    isset($Einstellungen.kunden.registrieren_captcha) && $Einstellungen.kunden.registrieren_captcha !== 'N' && empty($Kunde->kKunde)}
    <hr>
    {if isset($fehlendeAngaben.captcha) && $fehlendeAngaben.captcha != false}
        <div class="alert alert-danger" role="alert">{lang key="invalidToken" section="global"}</div>
    {/if}
    <div class="g-recaptcha" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}"></div>
    <hr>
{/if}