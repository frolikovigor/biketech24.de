{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{*<h1>{if !empty($oRedirect->cName)}{$oRedirect->cName}{else}{lang key="loginTitle" section="login"}{/if}</h1>*}
{if !$bCookieErlaubt}
    <div class="alert alert-danger hidden" id="no-cookies-warning" style="display:none;">
        <strong>{lang key="noCookieHeader" section="errorMessages"}</strong>
        <p>{lang key="noCookieDesc" section="errorMessages"}</p>
    </div>
    <script type="text/javascript">
        $(function() {ldelim}
            if (navigator.cookieEnabled === false) {ldelim}
                $('#no-cookies-warning').show();
                {rdelim}
            {rdelim});
    </script>
{elseif empty($cHinweis)}
    <div class="alert alert-info">{lang key="loginDesc" section="login"} {if isset($oRedirect) && $oRedirect->cName}{lang key="redirectDesc1" section="global"} {$oRedirect->cName} {lang key="redirectDesc2" section="global"}.{/if}</div>
{/if}

{include file="snippets/extension.tpl"}


<div class="col-sm-8 col-sm-offset-2">
    {block name="login-form"}


        <form id="login_form" action="{get_static_route id='jtl.php'}" method="post" role="form" class="login-form login-form_mod">
            {$jtl_token}
            <fieldset>
                <h2>{lang section="checkout" key="loginForRegisteredCustomers"}</h2>
                <div class="item form-group float-label-control required">
                    <input
                            type="text"
                            name="email"
                            id="email"
                            placeholder="{lang key="emailadress" section="global"}*"
                            required
                    />
                </div>
                <div class="item float-label-control required">
                    <input
                            type="password"
                            name="passwort"
                            id="password"
                            placeholder="{lang key="password" section="account data"}"
                            required
                    />
                </div>

                {if $showLoginCaptcha}
                    <div class="text-center float-label-control">
                        <div class="g-recaptcha" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}"></div>
                    </div>
                {/if}

                <div class="button">
                    <input type="hidden" name="login" value="1" />
                    {if !empty($oRedirect->cURL)}
                        {foreach name=parameter from=$oRedirect->oParameter_arr item=oParameter}
                            <input type="hidden" name="{$oParameter->Name}" value="{$oParameter->Wert}" />
                        {/foreach}
                        <input type="hidden" name="r" value="{$oRedirect->nRedirect}" />
                        <input type="hidden" name="cURL" value="{$oRedirect->cURL}" />
                    {/if}
                    <input type="submit" value="{lang key="login" section="checkout"}" class="btn-item-product submit"/>
                </div>

                <div class="clearfix"></div>
                <div class="register-or-resetpw top15">
                    <small>
                        <a class="register pull-left" href="{get_static_route id='registrieren.php'}"><span class="fa fa-pencil"></span> {lang key="newHere" section="global"} {lang key="registerNow" section="global"}</a>
                        <a class="resetpw  pull-right" href="{get_static_route id='pass.php'}"><span class="fa fa-question-circle"></span> {lang key="forgotPassword" section="global"}</a>
                    </small>
                </div>
            </fieldset>
        </form>
    {/block}
</div>
