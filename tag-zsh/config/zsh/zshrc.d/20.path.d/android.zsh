if [[ -d /opt/android-sdk ]]; then
    export ANDROID_SDK_ROOT=/opt/android-sdk
    export ANDROID_HOME=$ANDROID_SDK_ROOT
    export ANDROID_NDK=$ANDROID_SDK_ROOT/ndk-bundle
    export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
    export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
fi
