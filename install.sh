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
    # crio o path do sdkmanager
    sudo mkdir /usr/lib/android-sdk/cmdline-tools
    # faço download do sdk
    curl -O https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
    # rodo unzip
    unzip `pwd`/commandlinetools-linux-6858069_latest.zip
    # move pra dentro da usr/lib
    sudo mv cmdline-tools /usr/lib/android-sdk
    # remove o zip
    rm commandlinetools-linux-6858069_latest.zip
    # faz um link da cmdline com a tools pq é na tools que o flutter vai buscar o sdk
    sudo ln -s /usr/lib/android-sdk/cmdline-tools/bin/* /usr/lib/android-sdk/tools/bin
    # add to path
    echo -e "export ANDROID_SDK_ROOT=/usr/lib/android-sdk\nexport PATH=\$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:/usr/lib/android-sdk/tools/bin/:\$PATH" >> ~/.profile
    # download de dependencias
    sudo `which sdkmanager` "build-tools;28.0.3" "extras;android;m2repository" "extras;google;m2repository" "platform-tools" "platforms;android-28"  --sdk_root=/usr/lib/android-sdk/tools/bin/
    # then accept the licenses
    sdkmanager --licenses
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
    # add to path
    echo -e "export PATH=/usr/lib/flutter/bin:\$PATH" >> ~/.profile
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