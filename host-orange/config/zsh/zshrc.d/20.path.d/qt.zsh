if [[ -d $HOME/projects/q ]]; then
    export PATH=$PATH:$HOME/projects/q/qt5/qtrepotools/bin
fi

if [[ -d /opt/Qt/Tools/Ninja ]]; then
    export PATH=$PATH:/opt/Qt/Tools/Ninja
fi
