#!/bin/sh

if [ $# != 1 ]; then
    echo
    echo "Usage: Make_MI_dmg.sh version"
    echo
    exit 1
fi

VERSION="$1"

APPNAME="ADCTest"
APPNAME_lower=`echo ${APPNAME} |awk '{print tolower($0)}'`
SIGNATURE="MediaArea.net"
FILES="tmp-${APPNAME}"
TEMPDMG="tmp-${APPNAME}.dmg"
FINALDMG="${APPNAME}_${VERSION}_Mac.dmg"

# Clean up
rm -fr "${FILES}-Root"
rm -fr "${FILES}"
rm -f "${APPNAME}.pkg"
rm -f "${TEMPDMG}"
rm -f "${FINALDMG}"

echo
echo ========== Create the package ==========
echo

mkdir -p "${FILES}/.background"
cp ../../LICENSE.md "${FILES}"
cp ../../README.md "${FILES}"
cp Logo_White.icns "${FILES}/.background"

pushd ../GNU/GUI
    if test -e ".libs/${APPNAME_lower}"; then
        mv -f ".libs/${APPNAME_lower}" .
    fi
    if ! test -x "${APPNAME_lower}"; then
        echo
        echo "${APPNAME_lower} can’t be found, or this file isn’t a executable."
        echo
        exit 1
    fi
    strip -u -r "${APPNAME_lower}"
popd

mkdir -p "${FILES}/${APPNAME}.app/Contents/MacOS"
mkdir -p "${FILES}/${APPNAME}.app/Contents/Resources/UI"
cp "../GNU/GUI/${APPNAME_lower}" "${FILES}/${APPNAME}.app/Contents/MacOS/${APPNAME}"
cp Info.plist "${FILES}/${APPNAME}.app/Contents"
sed -i '' -e "s/VERSION/${VERSION}/g" "${FILES}/${APPNAME}.app/Contents/Info.plist"
echo -n 'APPL????' > "${FILES}/${APPNAME}.app/Contents/PkgInfo"
cp Logo.icns "${FILES}/${APPNAME}.app/Contents/Resources"
cp ../../src/config/default.xml "${FILES}/${APPNAME}.app/Contents/Resources"
cp ../../src/UI/appicon.png "${FILES}/${APPNAME}.app/Contents/Resources/UI"
cp ../../src/UI/splash.png "${FILES}/${APPNAME}.app/Contents/Resources/UI"
cp ../../src/UI/fadgi.png "${FILES}/${APPNAME}.app/Contents/Resources/UI"

codesign -f -s "Developer ID Application: ${SIGNATURE}" --verbose "${FILES}/${APPNAME}.app/Contents/MacOS/${APPNAME}"
codesign -f -s "Developer ID Application: ${SIGNATURE}" --verbose "${FILES}/${APPNAME}.app"

echo
echo ========== Create the disk image ==========
echo

# Check if an old image isn't already attached
DEVICE=$(hdiutil info |grep -B 1 "/Volumes/${APPNAME}" |egrep '^/dev/' | sed 1q | awk '{print $1}')
test -e "$DEVICE" && hdiutil detach -force "${DEVICE}"

hdiutil create "${TEMPDMG}" -ov -format UDRW -volname "${APPNAME}" -srcfolder "${FILES}"
DEVICE=$(hdiutil attach -readwrite -noverify "${TEMPDMG}" | egrep '^/dev/' | sed 1q | awk '{print $1}')
sleep 2

pushd "/Volumes/${APPNAME}"
    ln -s /Applications
    test -e .DS_Store && rm -fr .DS_Store
popd

. Osascript.sh
osascript_Function

hdiutil detach "${DEVICE}"
sleep 2

echo
echo ========== Convert to compressed image ==========
echo
hdiutil convert "${TEMPDMG}" -format UDBZ -o "${FINALDMG}"

# Useless since the dmg will transit on no HFS+ partition (at least
# on the linux server)
#codesign -f -s "Developer ID Application: ${SIGNATURE}" --verbose "${FINALDMG}"

unset -v APPNAME APPNAME_lower VERSION SIGNATURE
unset -v TEMPDMG FINALDMG FILES DEVICE
