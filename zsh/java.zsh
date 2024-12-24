if [[ -d '/usr/local/android-sdk-macosx' ]]; then
    export ANDROID_HOME=/usr/local/android-sdk-macosx
fi

if jenv --version >/dev/null 2>&1; then
    eval "$(jenv init -)"
fi
