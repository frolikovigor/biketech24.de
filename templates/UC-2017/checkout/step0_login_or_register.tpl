{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}


    <section class="steps-after-sec" id="panel-register-form">

        <div class="steps-after">
            <div class="login-forms">
                <div class="col-md-6 col-sm-6">
                    {assign var=checkout value="1"}
                    {include file='register/form.tpl'}
                </div>

                <div class="col-md-6 col-sm-6">


                    <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form login-form login-form_mod" id="order_register_or_login">
                        {if $hinweis}
                            <div class="alert alert-danger">{$hinweis}</div>
                        {/if}

                        {* Login form *}
                        {block name="checkout-login"}
                            <div class="panel panel-default " id="order_customer_login">
                                <h2>
                                    {*{block name="checkout-login-title"}{lang key="loginForRegisteredCustomers" section="checkout"}{/block}*}
                                    bereits Biketech24 Kunde?
                                </h2>

                                <div class="fields">
                                    {block name="checkout-login-body"}
                                        <div class="item required">
                                            <h5>{lang key="emailadress" section="global"}</h5>
                                            <input
                                                    type="text"
                                                    name="email"
                                                    id="email"
                                                    placeholder="{lang key="emailadress" section="global"}"
                                                    required
                                            >
                                        </div>

                                        <div class="item required">
                                            <h5>{lang key="password" section="account data"}</h5>
                                            <input
                                                    type="password"
                                                    name="passwort"
                                                    id="password"
                                                    placeholder="{lang key="password" section="account data"}"
                                                    required
                                            >
                                        </div>

                                        <div class="button">
                                            {$jtl_token}
                                            <input type="hidden" name="login" value="1" />
                                            <input type="hidden" name="wk" value="1" />

                                            <input type="submit" class="btn-item-product submit btn-block" value="{lang key="login" section="checkout"}" />
                                        </div>

                                        <div class="register-or-resetpw">
                                            <small>
                                                <a class="resetpw  pull-right" href="{get_static_route id='pass.php'}?exclusive_content=1" onclick="window.open(this.href,this.target,'width=640,height=430'); return false;"><span class="fa fa-question-circle"></span> {lang key="forgotPassword" section="global"}</a>
                                            </small>
                                        </div>
                                    {/block}
                                </div>
                            </div>
                        {/block}
                    </form>
                </div>
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






