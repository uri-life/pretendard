#!/bin/sh

cd packages

for FONTKEY in pretendard pretendard-gov pretendard-jp pretendard-std
do
  cd $FONTKEY/dist

  case $FONTKEY
  in
    pretendard)
      FONTNAME=Pretendard
      VARIABLEKEY=pretendardvariable
      ;;
    pretendard-gov)
      FONTNAME=PretendardGOV
      VARIABLEKEY=pretendardvariable-gov
      ;;
    pretendard-jp)
      FONTNAME=PretendardJP
      VARIABLEKEY=pretendardvariable-jp
      ;;
    pretendard-std)
      FONTNAME=PretendardStd
      VARIABLEKEY=pretendardvariable-std
      ;;
  esac
  VARIABLENAME=${FONTNAME}Variable

  for VARIANT in OTF TTF Variable-TTF Variable-WOFF2 Variable-WOFF2-DynamicSubset WOFF WOFF-DynamicSubset WOFF-Subset WOFF2 WOFF2-DynamicSubset WOFF2-Subset
  do
    mkdir -p ../../../.archive/$VARIANT/$FONTNAME
    ln -fs "$PWD"/../../../LICENSE ../../../.archive/$VARIANT/LICENSE.txt
  done

  ln -fs "$PWD"/public/static/*.otf ../../../.archive/OTF/$FONTNAME
  ln -fs "$PWD"/public/static/alternative/*.ttf ../../../.archive/TTF/$FONTNAME
  ln -fs "$PWD"/public/variable/*.ttf ../../../.archive/Variable-TTF/$FONTNAME
  ln -fs "$PWD"/web/static/woff/*.woff ../../../.archive/WOFF/$FONTNAME
  ln -fs "$PWD"/web/static/woff-dynamic-subset/*.woff ../../../.archive/WOFF-DynamicSubset/$FONTNAME
  ln -fs "$PWD"/web/static/woff2/*.woff2 ../../../.archive/WOFF2/$FONTNAME
  ln -fs "$PWD"/web/static/woff2-dynamic-subset/*.woff2 ../../../.archive/WOFF2-DynamicSubset/$FONTNAME
  ln -fs "$PWD"/web/variable/woff2/*.woff2 ../../../.archive/Variable-WOFF2/$FONTNAME
  ln -fs "$PWD"/web/variable/woff2-dynamic-subset/*.woff2 ../../../.archive/Variable-WOFF2-DynamicSubset/$FONTNAME

  ln -fs "$PWD"/web/static/$FONTKEY.css ../../../.archive/WOFF/$FONTNAME/$FONTNAME.css
  ln -fs "$PWD"/web/static/$FONTNAME-*.css ../../../.archive/WOFF-DynamicSubset/$FONTNAME
  ln -fs "$PWD"/web/static/$FONTKEY.css ../../../.archive/WOFF2/$FONTNAME/$FONTNAME.css
  ln -fs "$PWD"/web/static/$FONTNAME-*.css ../../../.archive/WOFF2-DynamicSubset/$FONTNAME
  ln -fs "$PWD"/web/variable/$VARIABLEKEY.css ../../../.archive/Variable-WOFF2/$FONTNAME/$VARIABLENAME.css
  ln -fs "$PWD"/web/variable/$VARIABLENAME-VF.css ../../../.archive/Variable-WOFF2-DynamicSubset/$FONTNAME/$VARIABLENAME-DynamicSubset.css

  if test -e ../subset_glyphs.txt
  then
    ln -fs "$PWD"/web/static/woff-subset/*.woff ../../../.archive/WOFF-Subset/$FONTNAME
    ln -fs "$PWD"/web/static/woff2-subset/*.woff2 ../../../.archive/WOFF2-Subset/$FONTNAME

    ln -fs "$PWD"/web/static/$FONTKEY-subset.css ../../../.archive/WOFF-Subset/$FONTNAME/$FONTNAME-Subset.css
    ln -fs "$PWD"/web/static/$FONTKEY-subset.css ../../../.archive/WOFF2-Subset/$FONTNAME/$FONTNAME-Subset.css
  fi

  cd ../..
done

cd ../.archive
rm *.zip
find . -type d -empty -delete
for VARIANT in *
do
  (cd $VARIANT && zip -9rv ../$VARIANT.zip .)
done
cd ..
