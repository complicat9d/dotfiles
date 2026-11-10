#!/bin/bash
set -euo pipefail

changed=0

set_default() {
    local domain=$1 key=$2 type=$3 value=$4 want current
    want=$value
    [ "$type" = bool ] && { [ "$value" = true ] && want=1 || want=0; }
    current=$(defaults read "$domain" "$key" 2>/dev/null || true)
    if [ "$current" != "$want" ]; then
        defaults write "$domain" "$key" "-$type" "$value"
        changed=1
    fi
}

# visibility
set_default NSGlobalDomain   AppleShowAllExtensions          bool   true   
set_default com.apple.finder ShowStatusBar                   bool   true
set_default com.apple.finder _FXShowPosixPathInTitle         bool   true

# behaviour
set_default com.apple.finder _FXSortFoldersFirst             bool   true   
set_default com.apple.finder FXDefaultSearchScope            string SCcf   
set_default com.apple.finder FXEnableExtensionChangeWarning  bool   false  
set_default com.apple.finder NewWindowTarget                 string PfHm

# no .DS_Store litter on network shares and USB drives
set_default com.apple.desktopservices DSDontWriteNetworkStores bool true
set_default com.apple.desktopservices DSDontWriteUSBStores     bool true
[ "$changed" = 1 ] && killall Finder || true