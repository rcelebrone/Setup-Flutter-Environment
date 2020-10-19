#!/bin/bash

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "Install Dart, Flutter and Android SDK and set it to your system."
   echo
   echo "Usage: ./install.sh [-h]"
   echo "options:"
   echo "h     Print this Help."
   echo
}
################################################################################
# Dart                                                                         #
################################################################################
Dart()
{
    # install references dos dart
    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
    sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
    sudo apt-get update
    sudo apt-get install dart
}
################################################################################
# Android SDK                                                                  #
################################################################################
AndroidSdk()
{
    echo "Follow steps: https://flutter.dev/docs/get-started/install/linux#android-setup"
}
################################################################################
# Flutter                                                                      #
################################################################################
Flutter()
{
    # download flutter
    curl -O https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.22.2-stable.tar.xz
    # extract
    tar xf flutter_linux_1.22.2-stable.tar.xz
    # remove 
    rm flutter_linux_1.22.2-stable.tar.xz
    # move to bin
    sudo mv flutter /usr/lib
    # check 
    flutter doctor
}
################################################################################
# Requirements                                                                 #
################################################################################
PreInstall()
{
    sudo apt update
}
################################################################################
# Requirements                                                                 #
################################################################################
PostInstall()
{
    # add to path
    export PATH="$PATH:/usr/lib/flutter/bin:/usr/lib/dart/bin"
}
################################################################################
# Process the input options. Add options as needed.                            #
################################################################################
# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done
################################################################################
# Program                                                                      #
################################################################################
PreInstall
Dart
Flutter
AndroidSdk