#!/bin/sh

#  MomentSlicer gettext
#  Created by SoftFever on 27/5/23.
#
xgettext --keyword=L --keyword=_L --keyword=_u8L --keyword=L_CONTEXT:1,2c --keyword=_L_PLURAL:1,2 --add-comments=TRN --from-code=UTF-8 --no-location --debug --boost -f ./localization/i18n/list.txt -o ./localization/i18n/MomentSlicer.pot
./build_arm64/src/hints/Release/hintsToPot.app/Contents/MacOS/hintsToPot ./resources ./localization/i18n


echo $PWD
pot_file="./localization/i18n/MomentSlicer.pot"
for dir in ./localization/i18n/*/
do
    dir=${dir%*/}      # remove the trailing "/"
    lang=${dir##*/}    # extract the language identifier

    if [ -f "$dir/MomentSlicer_${lang}.po" ]; then
        msgmerge -N -o $dir/MomentSlicer_${lang}.po $dir/MomentSlicer_${lang}.po $pot_file
        msgfmt --check-format -o ./resources/i18n/${lang}/MomentSlicer.mo $dir/MomentSlicer_${lang}.po
    fi
done
