<form id="form_payment_extra" class="form payment_extra" method="post" action="{get_static_route id='bestellvorgang.php'}">
    {$jtl_token}
    <div class="row">
        <div class="col-xs-12">
            <div class="panel-wrap">
                {include file=$Zahlungsart->cZusatzschrittTemplate}
                <input type="hidden" name="zahlungsartwahl" value="1" />
                <input type="hidden" name="zahlungsartzusatzschritt" value="1" />
                <input type="hidden" name="Zahlungsart" value="{$Zahlungsart->kZahlungsart}" />
                <input type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn-d pull-right" />
            </div>
        </div>
    </div>
</form>