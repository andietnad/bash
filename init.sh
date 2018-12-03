#! /bin/bash
echo "Starting...";

echo "Enable any modules? (leave empty for no or module names separated by space:)";
echo "Example: Namespace_Mdoule1 Namespace_Module2";
echo "Enter module names and press enter or just press enter for no modules"

read module_string;

php_cli="php";
default_force="-f";
default_langs="en_US nl_NL en_GB";

if [ -n "$1" ];then
    php_cli=$1;
fi

if [[ ! -z "$module_string" ]];then
    declare -a module_arr=($module_string);
    for module in ${module_arr[@]}
    do 
        $php_cli bin/magento module:enable $module
        $php_cli bin/magento setup:upgrade
    done
fi

rm -rf generated/* var/cache/* var/page_cache/* var/view_preprocessed/* var/tmp/* pub/static/*

$php_cli bin/magento setup:di:compile

echo "Enable force mode for setup:static-content:deploy?";
echo "Defaults to yes, if you do not want it enter n, else leave blank";
echo "Press enter to continue";
read force;

echo "Default languages for setup:static-content:deploy?";
echo "Defaults to en_US nl_NL en_GB";
echo "Type languages or leave blank";
echo "Press enter to continue";
read langs;

if [ "$force" == "n" ];then
    default_force="olla";
fi

if [[ ! -z "$langs" ]];then
    default_langs=langs
fi

$php_cli bin/magento setup:static-content:deploy $default_force $default_langs
$php_cli bin/magento cache:flush

echo "Finished.";
