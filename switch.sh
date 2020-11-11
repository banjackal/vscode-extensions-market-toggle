#!/usr/bin/env sh

##########################################################################################
#
# vscode-extensions-market-toggle
# 
# Copyright © 2020 Blake Farrugia
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all copies
# or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##########################################################################################

function toggle_vsc_extensions () {
    local VSC_PRODUCT_PATH=$(define_vsc_product)

    local SERVICE_REPLACEMENT_OPTIONS=("https://marketplace.visualstudio.com/_apis/public/gallery" "https://open-vsx.org/vscode/gallery")
    local ITEM_REPLACEMENT_OPTIONS=("https://marketplace.visualstudio.com/items" "https://open-vsx.org/vscode/item")

    local SWITCH=2
    check_vsc_extensions $VSC_PRODUCT_PATH q
    SWITCH=$?
    [ $SWITCH -eq 2 ] && echo "Something went wrong" && return 1
    
    sed -i 's@"serviceUrl": ".*"@"serviceUrl": "'${SERVICE_REPLACEMENT_OPTIONS[$SWITCH]}'"@g' $VSC_PRODUCT_PATH
    sed -i 's@"itemUrl": ".*"@"itemUrl": "'${ITEM_REPLACEMENT_OPTIONS[$SWITCH]}'"@g' $VSC_PRODUCT_PATH

    check_vsc_extensions $VSC_PRODUCT_PATH
    echo "Reboot application to take effect."

    return 0
}

function check_vsc_extensions () {
    local TARGET=$1
    local QUIET=1
    [ ! -z $TARGET ] && [ $TARGET = "q" ] && unset TARGET && QUIET=0
    [ ! -z $TARGET ] && [ ! -z $2 ] && [ $2 = "q" ] && QUIET=0
    [ -z $TARGET ] && TARGET=$(define_vsc_product)
    [ ! -f $TARGET ] && echo "Not a path to a VSCode product file." && return 2

    if cat $TARGET | grep -q "serviceUrl\": \".*open-vsx"; then
        [ $QUIET -eq 1 ] && echo "Using Open market extensions"
        return 0
    else
        [ $QUIET -eq 1 ] && echo "Using Microsoft market extensions"
        return 1
    fi
}

function define_vsc_product () {
    local PRODUCT_PATH="/resources/app/product.json"
    local COMMANDS=(codium code vscode)
    local EXE_PATH=""

    for i in ${COMMANDS[@]}; do
        EXE_PATH=$(command -v $i)
        [ ! -z $EXE_PATH ] && break
    done
    [ -z $EXE_PATH ] || [ ! -f $EXE_PATH ] && return 1

    EXE_PATH=$(dirname $(dirname $EXE_PATH))
    echo $EXE_PATH$PRODUCT_PATH

    return 0
}

## Aliases

alias toggle-market="toggle_vsc_extensions"
alias check-market="check_vsc_extensions"
