{include file='layout/header.tpl'}
{if $step === 'formular'}
    {if isset($checkout) && $checkout == 1}
        {include file='checkout/inc_steps.tpl'}
        {if !empty($smarty.session.Kunde->kKunde)}
            {lang key="changeBillingAddress" section="account data" assign="panel_heading"}
        {else}
            {lang key="createNewAccount" section="account data" assign="panel_heading"}
        {/if}
    {/if}

    {include file="snippets/extension.tpl"}
    <section class="steps-after-sec" id="panel-register-form">
        <div class="steps-after">

            <div class="login-forms">
                <div class="col-md-2 col-sm-2"></div>
                <div class="col-md-8 col-sm-8">
                    {include file='register/form.tpl'}
                </div>
                <div class="col-md-2 col-sm-2"></div>
            </div>

            <div class="buttons-mobile">
                <div class="button">
                    <a href="#">
                        <input class="btn-item-product" type="button" value="Neu bei Biketech24?">
                    </a>
                </div>

                <div class="button">
                    <a href="#">
                        <input class="btn-item-product" type="button" value="bereits Biketech24 Kunde?">
                    </a>
                </div>
            </div>
        </div>
    </section>




{elseif $step === 'formular eingegangen'}
    <h1>{lang key="accountCreated" section="global"}</h1>
    <p>{lang key="activateAccountDesc" section="global"}</p>
{/if}
{include file='layout/footer.tpl'}