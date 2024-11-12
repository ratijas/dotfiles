if [[ -d /opt/android-sdk ]]; then
    export ANDROID_SDK_ROOT=/opt/android-sdk
    export ANDROID_HOME=$ANDROID_SDK_ROOT
    export ANDROID_NDK=$ANDROID_SDK_ROOT/ndk-bundle
    export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
    export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
fi

if [[ -d /home/ratijas/Android/Sdk ]]; then
    export ANDROID_SDK_ROOT=/home/ratijas/Android/Sdk
    export ANDROID_NDK=$ANDROID_SDK_ROOT/ndk/$(ls -1 $ANDROID_SDK_ROOT/ndk | head -1)
    export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
    export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
    export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
    export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/35.0.0/
fi
