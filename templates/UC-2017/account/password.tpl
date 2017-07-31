{include file='layout/header.tpl'}

{include file="snippets/extension.tpl"}
{if !empty($cFehler)}
    <div class="alert alert-danger">{$cFehler}</div>
{/if}
{if $step === 'formular'}
    {if empty($hinweis)}
        <div class="alert alert-info">{lang key="forgotPasswordDesc" section="forgot password"}</div>
    {else}
        <div class="alert alert-danger">{$hinweis}</div>
    {/if}

    <section class="steps-after-sec" id="panel-register-form">
        <div class="steps-after">
            <div class="login-forms">
                {block name="password-reset-form"}
                    {block name="password-reset-form-body"}
                        <div class="col-sm-8 col-sm-offset-2">
                            <form id="passwort_vergessen" class="login-form login-form_mod" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post">
                                <h2>{lang key="forgotPassword" section="global"}</h2>

                                {$jtl_token}
                                <fieldset>
                                    <div class="item float-label-control required">
                                        <input
                                                type="text"
                                                name="email"
                                                id="email"
                                                placeholder="{lang key="emailadress" section="global"}*"
                                                required
                                        />
                                    </div>
                                    <div class="button">
                                        {if $bExclusive === true}
                                            <input type="hidden" name="exclusive_content" value="1" />
                                        {/if}
                                        <input type="hidden" name="passwort_vergessen" value="1" />
                                        <input type="submit" class="btn-item-product submit submit_once" value="{lang key="createNewPassword" section="forgot password"}" />
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    {/block}
                {/block}
            </div>
        </div>
    </section>
{elseif $step === 'confirm'}
    {if $hinweis}
        <div class="alert alert-danger">{$hinweis}</div>
    {/if}

    <section class="steps-after-sec" id="panel-register-form">
        <div class="steps-after">
            <div class="login-forms">
                {block name="password-reset-confirm"}
                    <div class="well">
                        <div class="panel panel-default">
                            <div class="panel-heading"><h3 class="panel-title">{block name="password-reset-confirm-title"}{lang key="customerInformation" section="global"}{/block}</h3></div>
                            <div class="panel-body">
                                {block name="password-reset-confirm-body"}
                                    <form id="passwort_vergessen" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post">
                                        {$jtl_token}
                                        <fieldset>
                                            <div class="form-group required">
                                                <label for="pw_new" class="control-label">{lang key='password' section='account data'}</label>
                                                <input
                                                        type="password"
                                                        name="pw_new"
                                                        id="pw_new"
                                                        class="form-control"
                                                        placeholder="{lang key='password' section='account data'}*"
                                                        required
                                                >
                                            </div>
                                            <div class="form-group required">
                                                <label for="pw_new_confirm" class="control-label">{lang key='passwordRepeat' section='account data'}</label>
                                                <input
                                                        type="password"
                                                        name="pw_new_confirm"
                                                        id="pw_new_confirm"
                                                        class="form-control"
                                                        placeholder="{lang key='passwordRepeat' section='account data'}*"
                                                        required
                                                >
                                            </div>
                                            <div class="form-group">
                                                {if $bExclusive === true}
                                                    <input type="hidden" name="exclusive_content" value="1">
                                                {/if}
                                                <input type="hidden" name="fpwh" value="{$fpwh}">
                                                <input type="hidden" name="fpm" value="{$fpm}">
                                                <input type="submit" class="btn btn-primary btn-block submit submit_once" value="{lang key="createNewPassword" section="forgot password"}">
                                            </div>
                                        </fieldset>
                                    </form>
                                {/block}
                            </div>
                        </div>
                    </div>
                {/block}
            </div>
        </div>
    </section>

{else}
    <div class="alert alert-success">{lang key="newPasswortWasGenerated" section="forgot password"}</div>
{/if}
{include file='layout/footer.tpl'}