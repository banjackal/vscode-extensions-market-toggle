function define_vsc_product
    set PRODUCT_PATH="/resources/app/product.json"
    set COMMANDS=(codium code vscode)
    set EXE_PATH=""

    for i in $COMMANDS[@]; do
        set EXE_PATH (command -v $i)
        [ ! -z $EXE_PATH ] && break
    end
    [ -z $EXE_PATH ] || [ ! -f $EXE_PATH ] && return 1

    set EXE_PATH (dirname (dirname $EXE_PATH))
    echo $EXE_PATH$PRODUCT_PATH

    return 0
end

function toggle_vsc_extensions
    set VSC_PRODUCT_PATH=(define_vsc_product)

    set SERVICE_REPLACEMENT_OPTIONS=("https://marketplace.visualstudio.com/_apis/public/gallery" "https://open-vsx.org/vscode/gallery")
    set ITEM_REPLACEMENT_OPTIONS=("https://marketplace.visualstudio.com/items" "https://open-vsx.org/vscode/item")

    set SWITCH=2
    check_vsc_extensions $VSC_PRODUCT_PATH q
    set SWITCH $status
    [ $SWITCH -eq 2 ] && echo "Something went wrong" && return 1
    
    sed -i 's@"serviceUrl": ".*"@"serviceUrl": "'$SERVICE_REPLACEMENT_OPTIONS[$SWITCH]'"@g' $VSC_PRODUCT_PATH
    sed -i 's@"itemUrl": ".*"@"itemUrl": "'$ITEM_REPLACEMENT_OPTIONS[$SWITCH]'"@g' $VSC_PRODUCT_PATH

    check_vsc_extensions $VSC_PRODUCT_PATH
    echo "Reboot application to take effect."

    return 0
end

function check_vsc_extensions
    set TARGET=$1
    set QUIET=1
    [ ! -z $TARGET ] && [ $TARGET = "q" ] && unset TARGET && set QUIET 0
    [ ! -z $TARGET ] && [ ! -z $2 ] && [ $2 = "q" ] && set QUIET 0
    [ -z $TARGET ] && set TARGET (define_vsc_product)
    [ ! -f $TARGET ] && echo "Not a path to a VSCode product file." && return 2

    if cat $TARGET | grep -q "serviceUrl\": \".*open-vsx"; then
        [ $QUIET -eq 1 ] && echo "Using Open market extensions"
        return 0
    else
        [ $QUIET -eq 1 ] && echo "Using Microsoft market extensions"
        return 1
    end
end
## Aliases

alias toggle-market=toggle_vsc_extensions
alias check-market=check_vsc_extensions
