#!/usr/bin/env bash

# Download the repository-pinned Xray core.
# The explicit argument still allows a controlled override for maintenance,
# while normal builds and installs stay on one known version.

RELEASE_TAG="${XRAY_CORE_VERSION:-v26.3.27}"

if [[ -n "$1" ]]; then
    RELEASE_TAG="$1"
fi

if [[ ! "$RELEASE_TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "error: Xray core version must be an explicit release tag such as v26.3.27 (received: $RELEASE_TAG)"
    exit 1
fi

check_if_running_as_root() {
    # If you want to run as another user, please modify $EUID to be owned by this user
    if [[ "$EUID" -ne '0' ]]; then
        echo "error: You must run this script as root!"
        exit 1
    fi
}

identify_the_operating_system_and_architecture() {
    if [[ "$(uname)" == 'Linux' ]]; then
        case "$(uname -m)" in
            'i386' | 'i686')
                ARCH='32'
            ;;
            'amd64' | 'x86_64')
                ARCH='64'
            ;;
            'armv5tel')
                ARCH='arm32-v5'
            ;;
            'armv6l')
                ARCH='arm32-v6'
                grep Features /proc/cpuinfo | grep -qw 'vfp' || ARCH='arm32-v5'
            ;;
            'armv7' | 'armv7l')
                ARCH='arm32-v7a'
                grep Features /proc/cpuinfo | grep -qw 'vfp' || ARCH='arm32-v5'
            ;;
            'armv8' | 'aarch64')
                ARCH='arm64-v8a'
            ;;
            'mips')
                ARCH='mips32'
            ;;
            'mipsle')
                ARCH='mips32le'
            ;;
            'mips64')
                ARCH='mips64'
                lscpu | grep -q "Little Endian" && ARCH='mips64le'
            ;;
            'mips64le')
                ARCH='mips64le'
            ;;
            'ppc64')
                ARCH='ppc64'
            ;;
            'ppc64le')
                ARCH='ppc64le'
            ;;
            'riscv64')
                ARCH='riscv64'
            ;;
            's390x')
                ARCH='s390x'
            ;;
            *)
                echo "error: The architecture is not supported."
                exit 1
            ;;
        esac
    else
        echo "error: This operating system is not supported."
        exit 1
    fi
}

download_xray() {
    DOWNLOAD_LINK="https://github.com/XTLS/Xray-core/releases/download/$RELEASE_TAG/Xray-linux-$ARCH.zip"
    
    echo "Downloading Xray archive: $DOWNLOAD_LINK"
    if ! curl -RL -H 'Cache-Control: no-cache' -o "$ZIP_FILE" "$DOWNLOAD_LINK"; then
        echo 'error: Download failed! Please check your network or try again.'
        return 1
    fi
}

extract_xray() {
    if ! unzip -q "$ZIP_FILE" -d "$TMP_DIRECTORY"; then
        echo 'error: Xray decompression failed.'
        "rm" -rf "$TMP_DIRECTORY"
        echo "removed: $TMP_DIRECTORY"
        exit 1
    fi
    echo "Extracted Xray archive to $TMP_DIRECTORY"
}

verify_xray_version() {
    local expected_version="${RELEASE_TAG#v}"
    local actual_version

    if [[ ! -x "${TMP_DIRECTORY}/xray" ]]; then
        echo "error: Xray archive does not contain an executable binary."
        exit 1
    fi

    actual_version="$(${TMP_DIRECTORY}/xray -version 2>/dev/null | awk 'NR == 1 { print $2 }')"
    if [[ "$actual_version" != "$expected_version" ]]; then
        echo "error: downloaded Xray version ${actual_version:-unknown} does not match requested ${RELEASE_TAG}."
        exit 1
    fi
    echo "Verified Xray core version ${RELEASE_TAG}"
}

place_xray() {
    install -m 755 "${TMP_DIRECTORY}/xray" "/usr/local/bin/xray"
    install -d "/usr/local/share/xray/"
    install -m 644 "${TMP_DIRECTORY}/geoip.dat" "/usr/local/share/xray/geoip.dat"
    install -m 644 "${TMP_DIRECTORY}/geosite.dat" "/usr/local/share/xray/geosite.dat"
    echo "Xray files installed"
}

check_if_running_as_root
identify_the_operating_system_and_architecture

TMP_DIRECTORY="$(mktemp -d)"
ZIP_FILE="${TMP_DIRECTORY}/Xray-linux-$ARCH.zip"

download_xray
extract_xray
verify_xray_version
place_xray

"rm" -rf "$TMP_DIRECTORY"
