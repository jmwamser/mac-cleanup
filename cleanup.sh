#!/usr/bin/env bash

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        let s++
    done
    echo "$b$d ${S[$s]} of space was cleaned up :3"
}
# Confirm Empty Trash
EmptyTrashes() {
    read -p "Empty All Trash? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Empty the Trash on all mounted volumes and the main HDD...'
        sudo rm -rfv /Volumes/*/.Trashes/* &>/dev/null
        sudo rm -rfv ~/.Trash/* &>/dev/null
    fi
    
} 

# Confirm Clear System Logs
ClearSystemLogs() {
    read -p "Clear System Logs? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Clear System Log Files...'
        sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
        sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
        sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
        rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
        rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null
    fi
    
}

# Confirm Clear Adobe Cache
ClearAdobeCache() {
    read -p "ClearAdobeCache? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Clear Adobe Cache Files...'
        sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null
    fi
    
}

# Confirm Clean iOS Applications
CleaniOSApps() {
    read -p "Clean iOS Applications? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Cleanup iOS Applications...'
        rm -rfv ~/Music/iTunes/iTunes\ Media/Mobile\ Applications/* &>/dev/null
    fi
    
}

# Confirm Remove iOS Device Backups
RemoveiOSDeviceBackups() {
    read -p "Remove iOS Device Backups? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Remove iOS Device Backups...'
        rm -rfv ~/Library/Application\ Support/MobileSync/Backup/* &>/dev/null
    fi
    
}

# Confirm Cleanup XCode Derived Data & Archives
CleanupXCode() {
    read -p "Cleanup XCode Derived Data & Archives? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Cleanup XCode Derived Data and Archives...'
        rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
        rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null
    fi
    
}

# Confirm Cleanup Homebrew Cache
CleanHomebrewCache() {
    read -p "Cleanup Homebrew Cache? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Cleanup Homebrew Cache...'
        brew cleanup --force -s &>/dev/null
        brew cask cleanup &>/dev/null
        rm -rfv /Library/Caches/Homebrew/* &>/dev/null
        brew tap --repair &>/dev/null
    fi
    
}

# Confirm Cleanup old gems
CleanRuby() {
    read -p "Cleanup old gems? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Cleanup any old versions of gems'
        gem cleanup &>/dev/null
    fi
    
}

# Confirm Cleanup Docker
CleanDocker() {
    read -p "Cleanup Docker? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Cleanup Docker <none> images'
        docker rmi -f $(docker images -q --filter 'dangling=true')
    fi
    
}

# Confirm Purge inactive memory
PurgeMemoryinactive() {
    read -p "Purge inactive memory? [Y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'Purge inactive memory...'
        sudo purge
    fi
    
}

finishScript() {
    clear && echo 'Success!'

    newAvailable=$(df / | tail -1 | awk '{print $4}')
    count=$((newAvailable-oldAvailable))
    count=$(( $count * 512))
    bytesToHuman $count

    exit 0;
}

confirmCleanUp() {
    # Confirm Empty Trash
    EmptyTrashes
    # Confirm Clear System Logs
    ClearSystemLogs
    # Confirm Clear Adobe Cache
    ClearAdobeCache
    # Confirm Clean iOS Applications
    CleaniOSApps
    # Confirm Remove iOS Device Backups
    RemoveiOSDeviceBackups
    # Confirm Cleanup XCode Derived Data & Archives
    CleanupXCode
    # Confirm Cleanup Homebrew Cache
    CleanHomebrewCache
    # Confirm Cleanup old gems
    CleanRuby
    # Confirm Cleanup Docker
    CleanDocker
    # Confirm Purge inactive memory
    PurgeMemoryinactive
}

CleanUp() {
    echo 'Empty the Trash on all mounted volumes and the main HDD...'
    sudo rm -rfv /Volumes/*/.Trashes/* &>/dev/null
    sudo rm -rfv ~/.Trash/* &>/dev/null

    echo 'Clear System Log Files...'
    sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
    sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
    sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
    rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
    rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null

    echo 'Clear Adobe Cache Files...'
    sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

    echo 'Cleanup iOS Applications...'
    rm -rfv ~/Music/iTunes/iTunes\ Media/Mobile\ Applications/* &>/dev/null

    echo 'Remove iOS Device Backups...'
    rm -rfv ~/Library/Application\ Support/MobileSync/Backup/* &>/dev/null

    echo 'Cleanup XCode Derived Data and Archives...'
    rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
    rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null

    echo 'Cleanup Homebrew Cache...'
    brew cleanup --force -s &>/dev/null
    brew cask cleanup &>/dev/null
    rm -rfv /Library/Caches/Homebrew/* &>/dev/null
    brew tap --repair &>/dev/null

    echo 'Cleanup any old versions of gems'
    gem cleanup &>/dev/null

    echo 'Cleanup Docker <none> images'
    docker rmi -f $(docker images -q --filter 'dangling=true')

    echo 'Purge inactive memory...'
    sudo purge

}

# Ask for the administrator password upfront
if [ "$EUID" -ne 0  ]; then
	echo "Please run as root"
	exit
fi

oldAvailable=$(df / | tail -1 | awk '{print $4}')
if [ ! -z "$1" ]
  then
    case "$1" in
    confirm)
        confirmCleanUp
        finishScript
        ;;
    *)
        echo "No valid argument supplied"
        exit 1
        ;;
    esac
fi
CleanUp
finishScript
