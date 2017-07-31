<?php
/**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *
 * @global JTLSmarty $smarty
 */

include realpath(__DIR__ . '/../../Evo/php/functions.php');


$smarty
/* add u-charged */
    ->registerPlugin('function', 'getAvailability', 'getAvailability')
    ->registerPlugin('function', 'getFullBreadcrumbs', 'getFullBreadcrumbs')
    ->registerPlugin('function', 'getParentById', 'getParentById')
    ->registerPlugin('function', 'getBasket', 'getBasket')
    ->registerPlugin('function', 'getDiscount', 'getDiscount')
    ->registerPlugin('function', 'getAjaxPrice', 'getAjaxPrice')
    ->registerPlugin('function', 'transliteration', 'transliteration')
    ->registerPlugin('function', 'fileExist', 'fileExist')
    ->registerPlugin('function', 'changeQuotes', 'changeQuotes')
    ->registerPlugin('function', 'getOptionsByFilter', 'getOptionsByFilter')
    ->registerPlugin('function', 'getBildOfLink', 'getBildOfLink')
    ->registerPlugin('function', 'getCountries', 'getCountries')
    ->registerPlugin('function', 'getAjaxParam', 'getAjaxParam')
    ->registerPlugin('function', 'redirect', 'redirect')
    ->registerPlugin('function', 'beraterExecute', 'beraterExecute')
    ->registerPlugin('function', 'existColor', 'existColor')

;
/* ------------- */

/**
 * @param array     $params
 * @param JTLSmarty $smarty
 * @return array
 */

function existColor($params = array(), &$smarty){
    $colors = array("rot","anthrazit","bunt","silber","weiss","schwarz","violett","orange","grau","blau","gelb","tuerkis","braun","lime","coral_pink","lila","beige");
    $result = false;
    if (isset($params['color'])) {

        $color = trim(transliteration($params['color']));
        if (in_array($color, $colors)) $result = true;
    }
    $smarty->assign($params['assign'], $result);
}



/* add u-charged */
function beraterExecute() {

// var schritthoehe = $("#rahmenhoehe_berechnen_value").val(); //20-120
// var rechwert_cityrad = 0.259;
// var rechwert_crossrad = 0.24;
// var rechwert_rennrad = 0.257;
// var rechwert_mtb = 0.226;
// var rechwert_trekking = 0.259;
// var ergebnis_cityrad_cm = Math.round(schritthoehe * rechwert_cityrad * 2.54) + " cm";
// var ergebnis_crossrad_cm = Math.round(schritthoehe * rechwert_crossrad * 2.54) + " cm";
// var ergebnis_rennrad_cm = Math.round(schritthoehe * rechwert_rennrad * 2.54) + " cm";
// var ergebnis_mtb_cm = Math.round(schritthoehe * rechwert_mtb * 2.54) + " cm";
// var ergebnis_trekking_cm = Math.round(schritthoehe * rechwert_trekking * 2.54) + " cm";
// $(".ergebnis_cityrad_cm").html(ergebnis_cityrad_cm);
// $(".ergebnis_crossrad_cm").html(ergebnis_crossrad_cm);
// $(".ergebnis_mtb_cm").html(ergebnis_mtb_cm);
// $(".ergebnis_rennrad_cm").html(ergebnis_rennrad_cm);
// $(".ergebnis_trekking_cm").html(ergebnis_trekking_cm);




    if ($_GET['request']) {
        $uri = urldecode($_GET['request']);
        parse_str($uri, $gets);

        if (isset($gets['step']) && isset($gets['k_cname'])) {
            $cm = 50;
            $step = (int) $gets['step'];
            switch ($gets['k_cname']) {
                case "Cityrader":
                    $cm = round($step * 0.259 * 2.54);
                    break;

                case "Crossrader":
                    $cm = round($step * 0.24 * 2.54);
                    break;

                case "Rennrader":
                    $cm = round($step * 0.257 * 2.54);
                    break;

                case "MTB_(Mountainbikes)":
                    $cm = round($step * 0.226 * 2.54);
                    break;

                case "Trekkingrader":
                    $cm = round($step * 0.259 * 2.54);
                    break;
            }
        }

        $res = array();
        $sizes = Shop::DB()->query("SELECT * FROM tmerkmalwertsprache WHERE `cSeo` LIKE '%Rahmenhoehe%'", 2);
        foreach ($sizes as $size) {
            if (isset($size -> cWert)) {
                if (strpos($size -> cWert, "cm")) {
                    $getCm = preg_replace('/\D/', '', $size -> cWert);
                    $res[$size -> kMerkmalWert] = $getCm;
                } elseif (strpos($size -> cWert, '"')) {
                    $getCm = preg_replace('/\D/', '', $size -> cWert);
                    $getCm = round($getCm * 2.54);
                    $res[$size -> kMerkmalWert] = $getCm;
                }
            }
        }

        $uriI = 2;
        if ($cm && count($res)) {
            foreach ($res as $id => $item) {
                if (($item > ($cm - 1)) && ($item < ($cm + 1))) {
                    $uri .= "&mf".$uriI++."=".$id;
                }
            }

            redirect("/navi.php?".$uri);
        }
    }
    return;
}



function redirect($url){
    header ('Location: '.$url);
    exit();
}


function getAjaxParam($params = array(), &$smarty) {
    $result = isset($_GET['AJAX']) ? 1 : 0;
    $smarty->assign($params['assign'], $result);
}


function getCountries($params = array(), &$smarty) {
    $result = gibBelieferbareLaender();
    $smarty->assign($params['assign'], $result);
}

function getBildOfLink($params = array(), &$smarty){
    $cUploadVerzeichnis = PFAD_ROOT . PFAD_BILDER . PFAD_LINKBILDER;
    $link = Shop::DB()->select('tlink', ['kLink', 'kLinkgruppe'], [$params['kLink'], $params['kLinkgruppe']]);

    $img = array();
    if (is_dir($cUploadVerzeichnis . $link->kLink)) {
        $DirHandle = opendir($cUploadVerzeichnis . $link->kLink);
        $shopURL   = Shop::getURL() . '/';
        while (false !== ($Datei = readdir($DirHandle))) {
            if ($Datei !== '.' && $Datei !== '..') {
                $img[] = $shopURL . PFAD_BILDER . PFAD_LINKBILDER . $link->kLink . '/' . $Datei;
            }
        }
    }
    $smarty->assign($params['assign'], $img);
}

//Now only brand (hersteller)
function getOptionsByFilter($params = array(), &$smarty) {
    $nLimit             = (isset($params['nLimit']))
        ? (int)$params['nLimit']
        : 10;
    $nSortierung        = (isset($params['nSortierung']))
        ? (int)$params['nSortierung']
        : 0;
    $cAssign            = (isset($params['cAssign']) && strlen($params['cAssign']) > 0)
        ? $params['cAssign']
        : 'oCustomArtikel_arr';
    $cMerkmalFilter_arr = (isset($params['cMerkmalFilter']))
        ? setzeMerkmalFilter(explode(';', $params['cMerkmalFilter']))
        : null;
    $cSuchFilter_arr    = (isset($params['cSuchFilter']))
        ? setzeSuchFilter(explode(';', $params['cSuchFilter']))
        : null;
    $cTagFilter_arr     = (isset($params['cTagFilter']))
        ? setzeTagFilter(explode(';', $params['cTagFilter']))
        : null;
    $cParameter_arr     = [
        'kKategorie'             => (isset($params['kKategorie'])) ? $params['kKategorie'] : null,
        'kHersteller'            => (isset($params['kHersteller'])) ? $params['kHersteller'] : null,
        'kArtikel'               => (isset($params['kArtikel'])) ? $params['kArtikel'] : null,
        'kVariKindArtikel'       => (isset($params['kVariKindArtikel'])) ? $params['kVariKindArtikel'] : null,
        'kSeite'                 => (isset($params['kSeite'])) ? $params['kSeite'] : null,
        'kSuchanfrage'           => (isset($params['kSuchanfrage'])) ? $params['kSuchanfrage'] : null,
        'kMerkmalWert'           => (isset($params['kMerkmalWert'])) ? $params['kMerkmalWert'] : null,
        'kTag'                   => (isset($params['kTag'])) ? $params['kTag'] : null,
        'kSuchspecial'           => (isset($params['kSuchspecial'])) ? $params['kSuchspecial'] : null,
        'kKategorieFilter'       => (isset($params['kKategorieFilter'])) ? $params['kKategorieFilter'] : null,
        'kHerstellerFilter'      => (isset($params['kHerstellerFilter'])) ? $params['kHerstellerFilter'] : null,
        'nBewertungSterneFilter' => (isset($params['nBewertungSterneFilter'])) ? $params['nBewertungSterneFilter'] : null,
        'cPreisspannenFilter'    => (isset($params['cPreisspannenFilter'])) ? $params['cPreisspannenFilter'] : null,
        'kSuchspecialFilter'     => (isset($params['kSuchspecialFilter'])) ? $params['kSuchspecialFilter'] : null,
        'nSortierung'            => $nSortierung,
        'MerkmalFilter_arr'      => $cMerkmalFilter_arr,
        'TagFilter_arr'          => $cTagFilter_arr,
        'SuchFilter_arr'         => $cSuchFilter_arr,
        'nArtikelProSeite'       => (isset($params['nArtikelProSeite'])) ? $params['nArtikelProSeite'] : null,
        'cSuche'                 => (isset($params['cSuche'])) ? $params['cSuche'] : null,
        'seite'                  => (isset($params['seite'])) ? $params['seite'] : null
    ];
    if ($cParameter_arr['kArtikel'] !== null) {
        $oArtikel_arr = [];
        if (!is_array($cParameter_arr['kArtikel'])) {
            $cParameter_arr['kArtikel'] = [$cParameter_arr['kArtikel']];
        }
        foreach ($cParameter_arr['kArtikel'] as $kArtikel) {
            $article = new Artikel();
            $article->fuelleArtikel($kArtikel, Artikel::getDefaultOptions());
            $oArtikel_arr[] = $article;
        }
    } else {
        // Filter
        $NaviFilter = Shop::buildNaviFilter($cParameter_arr);
        if (isset($NaviFilter->Suche->cSuche) && strlen($NaviFilter->Suche->cSuche) > 0) {
            $NaviFilter->Suche->cSuche     = StringHandler::filterXSS($NaviFilter->Suche->cSuche, 1);
            $NaviFilter->Suche->kSuchCache = bearbeiteSuchCache($NaviFilter);
        }
        // Artikelattribut
        if (isset($cParameter_arr['cArtAttrib']) && strlen($cParameter_arr['cArtAttrib']) > 0) {
            $NaviFilter->ArtikelAttributFilter->cArtAttrib = $cParameter_arr['cArtAttrib'];
        }
        //Filter SQLs Objekte
        $FilterSQL = bauFilterSQL($NaviFilter);
        // Artikelliste
        $oArtikel_arr = gibArtikelKeys($FilterSQL, $nLimit, $NaviFilter, true, null);
    }

    $result = array();

    if ($params['option'] == "hersteller"){
        $result = gibHerstellerFilterOptionen($FilterSQL, $NaviFilter);
        $smarty->assign($params['assign'], $result);
        return;
    }

    $smarty->assign($cAssign, $result);
}


function changeQuotes($str = '') {
    return str_replace('&quot;', "&#39;", $str);
}

function fileExist($url = ""){
    if (file_exists($_SERVER['DOCUMENT_ROOT']."/".$url)) {
        return $url;
    }

    return "";
}

function transliteration($name='') {
    $arr = array(
        "ß" => "ss",
        "ü" => "ue",
        "ä" => "a",
        " " => "_",
        "Ü" => "U",
        "/" => "_"
    );

    return strtr($name, $arr);
}

function getAjaxPrice($params = array(), &$smarty) {
    return deleteGET($_SERVER['REQUEST_URI'], "pf");
}

function deleteGET($url, $name, $amp = true) {
    $url = str_replace("&amp;", "&", $url); // ???????? ???????? ?? ?????????, ???? ?????????
    list($url_part, $qs_part) = array_pad(explode("?", $url), 2, ""); // ????????? URL ?? 2 ?????: ?? ????? ? ? ?????
    parse_str($qs_part, $qs_vars); // ????????? ?????? ? ???????? ?? ?????? ? ??????????? ? ?? ??????????
    unset($qs_vars[$name]); // ??????? ??????????? ????????
    if (count($qs_vars) > 0) { // ???? ???? ?????????
        $url = $url_part."?".http_build_query($qs_vars); // ???????? URL ???????
        if ($amp) $url = str_replace("&", "&amp;", $url); // ???????? ?????????? ??????? ?? ????????, ???? ?????????
    }
    else $url = $url_part; // ???? ?????????? ?? ????????, ?? ?????? ????? ???, ??? ???? ?? ????? ?
    return $url; // ?????????? ???????? URL
}


function getBasket($params = array(), &$smarty){
    $getBasket = isset($_SESSION['basket_r']) ? $_SESSION['basket_r'] : array();

    if (isset($params['getPrice'])) {
        if (isset($getBasket[$params['getPrice']])) return $getBasket[$params['getPrice']];
    } else {
        if (isset($params['id']) && isset($params['price'])) {
            if (!isset($getBasket[$params['id']])) {
                $getBasket[$params['id']] = $params['price'];
                $_SESSION['basket_r'] = $getBasket;
            }
        }
    }
    return;
}


function getDiscount($params = array(), &$smarty){
    $origin = (float) strtr($params['origin'], array("."=>"",","=>"."));
    $price = (float) strtr($params['price'], array("."=>"", ","=>"."));

    $result = round(100 * (1 - $origin / $price));

    $smarty->assign($params['assign'], $result);
}


function getAvailability($params = array(), &$smarty) {
    $oArtikelOptionen = Artikel::getDefaultOptions();
    $artikel = new Artikel();
    $artikel->fuelleArtikel($params['id'], $oArtikelOptionen);  //52877, 52866
    $result = 0;
    if ($artikel->aufLagerSichtbarkeit()) {
        if ($artikel -> kArtikel) $result = 1;
    }
    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $result);
    } else {
        return $result;
    }
}
function getFullBreadcrumbs($params, &$smarty)
{
    $getFullBreadcrumbs = isset($_SESSION['getFullBreadcrumbs']) ? $_SESSION['getFullBreadcrumbs']: array();
    $page = isset($params['page']) ? $params['page'] : false;
    if ($page) {
        $last = end($getFullBreadcrumbs);
        if ($params['page'] != $last) {
            $getFullBreadcrumbs[] = $params['page'];
            $_SESSION['getFullBreadcrumbs'] = $getFullBreadcrumbs;
        }
    }
    if (isset($params['show'])) {
        return "order=".(implode("_", $getFullBreadcrumbs));
    }
}
function getParentById($params, &$smarty){
    if (!isset($params['name'])) return;
    $kVaterArtikel = Shop::DB()->query("SELECT kVaterArtikel FROM tartikel WHERE kArtikel = '".$params['id']."' LIMIT 1", 2);
    if (is_array($kVaterArtikel))
        if (count($kVaterArtikel)) {
            $kVaterArtikel = array_shift($kVaterArtikel);
            $kVaterArtikel = $kVaterArtikel -> kVaterArtikel ? $kVaterArtikel -> kVaterArtikel : $params['id'];
            if ($kVaterArtikel) {
                $kKategorie = Shop::DB()->query("SELECT kKategorie FROM tkategorieartikel WHERE kArtikel = '".$kVaterArtikel."' ORDER BY kKategorieArtikel LIMIT 1", 2);
                if (is_array($kKategorie))
                    if (count($kKategorie)) {
                        $kKategorie = array_shift($kKategorie);
                        if ($kKategorie->kKategorie) {
                            $kKategorie = $kKategorie->kKategorie;
                            $parent = Shop::DB()->query("SELECT * FROM tkategorie WHERE kKategorie='".$kKategorie."' LIMIT 1", 2);
                            if (is_array($parent))
                                if (count($parent)) {
                                    $parent = array_shift($parent);
                                    $parent = is_object($parent) ? ((array) $parent) : array();
                                    if (isset($parent[$params['name']])) return $parent[$params['name']];
                                }
                        }
                    }
            }
        }
    return;
}

/* ------------- */

/* add liebschner */

$smarty->register_function("get_category_list", "get_category_list");

function get_category_list($params, &$smarty)
{
    require_once(PFAD_ROOT . PFAD_CLASSES . "class.JTL-Shop.Kategorie.php");
    
    $oKategorie_arr = array();
    
    if(!isset($params['cKatAttrib']) || strlen($params['cKatAttrib']) == 0)
        return false;
    
    // Limit
    $cLimit = "";
    if(isset($params['nLimit']) && intval($params['nLimit']) > 0)
        $cLimit = " LIMIT " . intval($params['nLimit']);
    
    // Assign
    $cAssing = "oCustomKategorie_arr";
    if(isset($params['cAssign']) && strlen($params['cAssign']) > 0)
        $cAssing = $params['cAssign'];
    
    // Sprache
    $kSprache = 0;
    if(isset($params['kSprache']) && intval($params['kSprache']) > 0)
        $kSprache = intval($params['kSprache']);
    elseif(isset($_SESSION['kSprache']) && intval($_SESSION['kSprache']) > 0)
        $kSprache = intval($_SESSION['kSprache']);
    else
    {
        $oSprache = gibStandardsprache(true);
        $kSprache = $oSprache->kSprache;
    }
    
    // Kundengruppe
    $kKundengruppe = 0;
    if(isset($params['kKundengruppe']) && intval($params['kKundengruppe']) > 0)
        $kKundengruppe = intval($params['kKundengruppe']);
    elseif(isset($_SESSION['Kundengruppe']->kKundengruppe) && intval($_SESSION['kKundengruppe']->kKundengruppe) > 0)
        $kKundengruppe = intval($_SESSION['kKundengruppe']->kKundengruppe);
    else
        $kKundengruppe = gibStandardKundengruppe();
    
    $oKat_arr = $GLOBALS['DB']->executeQuery("SELECT tkategorie.kKategorie
                                                FROM tkategorie
                                                JOIN tkategorieattribut ON tkategorieattribut.kKategorie = tkategorie.kKategorie
                                                    AND tkategorieattribut.cName = '" . filterXSS($params['cKatAttrib']) . "'
                                                ORDER BY tkategorie.nSort, tkategorie.cName" . $cLimit, 2);
    
    if(is_array($oKat_arr) && count($oKat_arr) > 0)
    {
        foreach($oKat_arr as $oKat)
        {
            if($oKat->kKategorie > 0)
                $oKategorie_arr[] = new Kategorie($oKat->kKategorie, $kSprache, $kKundengruppe);
        }
    }
    
    $smarty->assign($cAssing, $oKategorie_arr);
    
    if($params['bReturn'])
        return $oKategorie_arr;
}
/* ------------- */