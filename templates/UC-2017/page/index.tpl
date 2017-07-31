{*<video class="video-bg" poster="/dev/static/img/content/765-min.jpg" id="bgvid" playsinline autoplay muted loop>*}
    {*<source src="/dev/static/img/content/video/video-i.mp4?v=1" type="video/mp4">*}
    {*<source src="/dev/static/img/content/video/video-i.webm" type="video/webm">*}
{*</video>*}

<section class="main-content">
    {*<video class="video-bg" poster="/dev/static/img/content/765-min.jpg" id="bgvid" playsinline autoplay muted loop>*}
        {*<source src="/dev/static/img/content/video/video-i.mp4?v=1" type="video/mp4">*}
        {*<source src="/dev/static/img/content/video/video-i.webm" type="video/webm">*}
    {*</video>*}
    <div class="container_main-content">

        <div class="logo">
            <a href="/">
                <img src="/dev/static/img/content/logo.svg" alt="Main logo">
            </a>
        </div>

        {*<h1>Wähle dein Fahrrad hier!</h1>*}
        <form class="form" action="" method="post">
            <form class="search search-content" action="navi.php" method="GET">
                <div class="search-content__input">
                    <input class="ac_input" type="text" name="qs" placeholder="Suchen" autocomplete="off">
                </div>
                <div class="btn-blocks">
                    <a href="#">
                        <input class="btn-d btn_search" type="submit" value="Suchen">
                    </a>
                </div>
            </form>

            <div class="btn-blocks">
                <a href="/Berater">
                    <input class="btn-d" type="button" value="Für Anfänger">
                </a>
                <a href="/Fahrraeder-guenstig-kaufen-Online-Shop">
                    <input class="btn-d" type="button" value="Für Fortgeschrittene">
                </a>
            </div>

        </form>
    </div>
</section>

<section class="bikes-sec">
    <div class="chapters">
        {get_navigation linkgroupIdentifier='Mainpage-categories-image' assign='links'}
        {if !empty($links)}
            {foreach name='links' from=$links item='li'}
                {getBildOfLink kLink = $li->kLink kLinkgruppe=$li->kLinkgruppe assign="bild"}

                <div class="chapters__block">
                    <a href="{$li -> URL}">
                        <div class="chapters__blockitem">
                            <img src="{$bild[0]}" />
                            <img class="chapters__img" src="{$bild[1]}" />
                        </div>
                        <div class="chapters__title">{$li -> cName}</div>
                    </a>
                </div>

            {/foreach}
        {/if}
    </div>

    <div class="bikes-slider">
        {*<h2 class="bikes-slider__title">Alle moderne Biketechnologie sind dabei</h2>*}
        {*<h2 class="bikes-slider__title-bottom">die beste bikes in welt</h2>*}
    </div>

    <div id="accordion-wrapper" class="fsbanner accordion-wrapper">
        {get_navigation linkgroupIdentifier='Mainpage-categories-best' assign='links'}
        {if !empty($links)}
            {foreach name='links' from=$links item='li'}
                {getBildOfLink kLink = $li->kLink kLinkgruppe=$li->kLinkgruppe assign="bild"}

                <div style="background-image:url({$bild[0]})">
                    <a href="{$li -> URL}">
                        <span class="name">
                            <h3>{$li -> cName}</h3>
                        </span>
                    </a>
                </div>
            {/foreach}
        {/if}
    </div>


    <div class="bikes_brands">
        <h2 class="bikes_brands__head">
            <span class="title">Fahhrad Marken</span>
            <span class="border"></span>
        </h2>

        <ul class="bikes_brands__slider">
            {getOptionsByFilter kKategorie='1' option='hersteller' assign="listHersteller"}

            {foreach name='links' from=$listHersteller item='itemHersteller'}
                {assign var="url" value=fileExist("`$currentTemplateDir`images/menu/brands/`$itemHersteller->cSeo`.png")}

                {if ($url !== '') and ($itemHersteller->cSeo != 'Sabotage')}
                    <li>
                        <a href="{$itemHersteller->cURL}">
                            <div class="bikes_brands__image">
                                <img src="{$currentTemplateDir}images/menu/brands/{$itemHersteller->cSeo}.png">
                            </div>
                        </a>
                    </li>
                {/if}
            {/foreach}
        </ul>
    </div>


    <div class="bikes_sex">
        {get_navigation linkgroupIdentifier='Mainpage-sex' assign='links'}
        {if !empty($links)}
            {foreach name='links' from=$links item='li'}
                {getBildOfLink kLink = $li->kLink kLinkgruppe=$li->kLinkgruppe assign="bild"}
                <a href="{$li -> URL}">
                    <div class="bikes_sex__item col-lg-4 col-md-4 col-sm-4 col-xs-12">
                        <img class="bikes_sex__img" src="{$bild[1]}" />
                        <img src="{$bild[0]}" />
                        <div class="bikes_sex__title">{$li -> cName}</div>
                        {*<span class="bikes_sex__subtitle">räder</span>*}
                        {*<div class="btn-blocks btn-blocks_bike-sex">*}
                            {*<input class="btn-d btn-d_bike-sex" type="button" value="jetzt shoppen">*}
                        {*</div>*}
                    </div>
                </a>

            {/foreach}
        {/if}
    </div>
</section>

<section class="whiteblue-sec">

    <div class="whitebox hidden-xs">
        <span>Dein Bike ist hier</span>
        <img class="bike-image" src="/dev/static/img/content/wbbike.png">
    </div>
    <form id="feedback" class="bluebox" action="/feedback.php" onsubmit="submitFeedback(); return false;">
        <div class="bluebox-title">
            <h3>Hast du nichts gefunden?</h3>
            <span>Schreib uns bitte, wir helfen dir mit Wahl:</span>
        </div>
        <div class="feedback_form">
            <div>
                <div class="bluebox-input">
                    <input type="email" name="email" placeholder="Schreib deine E-Mail Adresse">
                    <button class="bluebox-button" type="button">
                    </button>
                </div>
            </div>
            <div>
                <div class="bluebox-input">
                    <textarea name="content" rows="1" id="bluebox-textarea" type="text" placeholder="Hallo, ich brauche ..." onkeyup="resizeTextArea()">Hallo, ich brauche ...</textarea>
                    <button class="bluebox-button" type="submit"><span class="btn-d btn_search">Senden</span></button>
                </div>
            </div>
        </div>
        <div class="feedback_success">
            Success
        </div>

        <span id="helper"></span>

        <img class="preloader" src="{$currentTemplateDir}images/preloader.gif" />
    </form>

</section>

