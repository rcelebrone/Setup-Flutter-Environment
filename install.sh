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
    # add to path
    export PATH="$PATH:/usr/lib/dart/bin"
    echo "export PATH=$PATH:/usr/lib/dart/bin" >> ~/.profile
}
################################################################################
# Android SDK                                                                  #
################################################################################
AndroidSdk()
{
    sudo apt update
    # Install Android-SDK
    sudo apt install android-sdk
    # Set to path
    export ANDROID_HOME=/usr/lib/android-sdk
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    # TODO: export PATH=$PATH:$ANDROID_HOME/platform-tools
    echo "export PATH=$PATH:$ANDROID_HOME/tools/bin" >> ~/.profile
    # TODO: echo "export PATH=$PATH:$ANDROID_HOME/platform-tools" >> ~/.profile
}
################################################################################
# Flutter                                                                      #
################################################################################
Flutter()
{
    # clone flutter
    git clone https://github.com/flutter/flutter.git
    # move to lib
    sudo mv flutter /usr/lib/
    # add to path
    export PATH="$PATH:/usr/lib/flutter/bin"
    echo "export PATH=$PATH:/usr/lib/flutter/bin" >> ~/.profile
    # config flutter
    flutter config --android-sdk /usr/lib/android-sdk/bin
    # cache it
    flutter precache
    # check 
    flutter doctor
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
Dart
AndroidSdk
Flutter