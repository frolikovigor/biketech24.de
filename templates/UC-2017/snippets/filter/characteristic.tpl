{assign var="is_dropdown" value=false}
{if ($Merkmal->cTyp === 'SELECTBOX') && $Merkmal->oMerkmalWerte_arr|@count > 1}
    {assign var="is_dropdown" value=true}
{/if}

<ul {if $is_dropdown}class="dropdown-menu" role="menu" {elseif isset($class)}class="{$class}" {else}class="nav nav-list"{/if}>
    {foreach name=filter from=$Merkmal->oMerkmalWerte_arr item=MerkmalWert}
        {assign var=kMerkmalWert value=$MerkmalWert->kMerkmalWert}

        <li>
            <div class="filter-parameters-i">
                <a rel="nofollow" href="{$MerkmalWert->cURL}"{if $Merkmal->cTyp === 'BILD'} title="{$MerkmalWert->cWert|escape:'html'}"{/if}>
                    <div class="jq-checkbox {if $MerkmalWert->nAktiv}checked{/if}"><div class="jq-checkbox__div"></div></div>
                    <label for="itemEinsatzgebiet">
                        <span>{$MerkmalWert->cWert|escape:'html'}<span class="count">&nbsp;({$MerkmalWert->nAnzahl})</span></span>
                    </label>
                </a>
            </div>
        </li>

    {/foreach}
</ul>
