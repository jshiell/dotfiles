if [[ -x '/usr/libexec/java_home' ]]; then
    _path_remove() {
        local DIR_TO_REMOVE="$1"
        local NEW_PATH
        local CURRENT_DIR
        for CURRENT_DIR in $(echo $PATH | sed -e 's/:/ /g'); do
            if [[ "$CURRENT_DIR" != "$DIR_TO_REMOVE" ]]; then
                if [[ -z "$NEW_PATH" ]]; then
                    NEW_PATH=$CURRENT_DIR
                else
                    NEW_PATH="${NEW_PATH}:${CURRENT_DIR}"
                fi
            fi
        done
        export PATH="$NEW_PATH"
    }

    _change_jdk() {
        local JDK_VERSION=$1

        local JAVA_VERSION_HOME
        JAVA_VERSION_HOME=$(/usr/libexec/java_home -v $JDK_VERSION)
        if [[ $? -ne 0 ]]; then
            echo "Couldn't find JDK for version $JDK_VERSION"
            return 1
        fi

        [[ -n "$JAVA_HOME" ]] && _path_remove "$JAVA_HOME/bin"

        export JAVA_HOME=$JAVA_VERSION_HOME
        export JDK_HOME=$JAVA_HOME
        export PATH="$JAVA_HOME/bin:$PATH"    
    }

    _change_jdk 16

    alias use-java='_change_jdk $1'
fi

if [[ -d '/usr/local/android-sdk-macosx' ]]; then
    export ANDROID_HOME=/usr/local/android-sdk-macosx
fi
