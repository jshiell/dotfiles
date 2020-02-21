if [[ -x '/usr/libexec/java_home' ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v '11.*')
    export JDK_HOME=$JAVA_HOME
fi

[[ -n "$JAVA_HOME" ]] && export PATH=$JAVA_HOME/bin:$PATH

if [[ -d '/usr/local/android-sdk-macosx' ]]; then
    export ANDROID_HOME=/usr/local/android-sdk-macosx
fi
