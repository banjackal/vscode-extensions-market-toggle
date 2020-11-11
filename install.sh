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

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

TARGET_BASH_DRIVER=$1
[ -z $TARGET_BASH_DRIVER ] && TARGET_BASH_DRIVER="~/.bashrc"
[ ! -f $TARGET_BASH_DRIVER ] && echo "Target bash driver $TARGET_BASH_DRIVER does not exist. Exiting..." && exit 1

exit 0

! grep -q vs.*-extensions-market-toggle $TARGET_BASH_DRIVER && echo "[ -f $SCRIPT_DIR/switch.sh ] && source $SCRIPT_DIR/switch.sh" >> $TARGET_BASH_DRIVER
