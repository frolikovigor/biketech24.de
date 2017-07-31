<div class="bf-col" id="box{$oBox->kBox}">
    <span class="bf-title">{$oBox->oLinkGruppe->cLocalizedName|trans}</span>
    <ul class="bf-list">
        {include file='snippets/linkgroup_recursive.tpl' linkgroupIdentifier=$oBox->oLinkGruppeTemplate dropdownSupport=true  tplscope='box'}

    </ul>
</div>