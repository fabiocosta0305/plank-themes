#! /bin/bash

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
    DEST_DIR="/usr/share/plank/themes/"
else
    DEST_DIR="$HOME/.local/share/plank/themes/"
fi

end() {
    echo -e "Exiting..."
    exit 0
}

confirm() {
    zenity --question \
        --no-wrap \
        --text="Do you want to continue?" \
        --ok-label="Continue" \
        --cancel-label="Exit"

    INPUT=$?
    case $INPUT in
    0) ;;

    1)
        end
        ;;
    -1)
        zenity --error \
            --no-wrap \
            --text="Sorry, try again" \
            main
        ;;
    esac
}

install() {
    # Show destination directory
    zenity --info \
        --no-wrap \
        --text="Plank-Themes will be installed in: '$DEST_DIR' "
    if [ "$UID" -eq "$ROOT_UID" ]; then
        zenity --info \
            --no-wrap \
            --text="Plank-Themes will be available to all users"
    else
        zenity --info \
            --no-wrap \
            --text="If you want to make them available to all users, run this script as ROOT"
    fi
    confirm

    # Create folder if it doesn't already exist
    if [[ ! -e "$DEST_DIR" ]]; then
        mkdir -p "$DEST_DIR"
    fi

    # Copying files
    cp -ur anti-shade "$DEST_DIR"
    cp -ur shade "$DEST_DIR"
    cp -ur paperterial "$DEST_DIR"
    cp -ur nordic-night "$DEST_DIR"
    cp -ur nordic-snow "$DEST_DIR"
    cp -ur y-ru "$DEST_DIR"
    zenity --info \
        --no-wrap \
        --text="Installation complete"
}

main() {
    zenity --question \
        --no-wrap \
        --text="What do you want to do?" \
        --ok-label="Install" \
        --cancel-label="Cancel"
    INPUT=$?
    case $INPUT in
    0)
        install
        ;;
    1)
        end
        ;;
    -1)
        zenity --error \
            --no-wrap \
            --text="Sorry, try again" \
            main
        ;;
    esac
}

main
