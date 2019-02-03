#!/bin/bash
#
# Edit LuxCore/pywheel/setup.y, update version there and in this file, than:
#
# ./utils/create_python_wheel.sh target-64-sse2 luxcorerender-v2.0-linux64
# ./utils/create_python_wheel.sh target-64-sse2 luxcorerender-v2.0-linux64-opencl

if [[ ! $2 ]] ; then
	echo " * Unable to create Python Wheel"
	exit 1
fi

TARGET=$1
LUX_TAG=$2

rm -rf $TARGET/$LUX_TAG-wheel
mkdir -p $TARGET/$LUX_TAG-wheel/pyluxcore

cp $LUX_TAG/pywheel/setup.py $TARGET/$LUX_TAG-wheel
cp $LUX_TAG/pywheel/setup.cfg $TARGET/$LUX_TAG-wheel
cp $LUX_TAG/pywheel/MANIFEST.in $TARGET/$LUX_TAG-wheel
cp $LUX_TAG/pywheel/__init__.py $TARGET/$LUX_TAG-wheel/pyluxcore

cp -r $LUX_TAG/src/pyluxcoretools/pyluxcoretools $TARGET/$LUX_TAG-wheel/pyluxcoretools

cp $LUX_TAG/README.md $TARGET/$LUX_TAG-wheel/README.rst
cp $LUX_TAG/AUTHORS.txt $TARGET/$LUX_TAG-wheel/AUTHORS.txt
cp $LUX_TAG/COPYING.txt $TARGET/$LUX_TAG-wheel/LICENSE.txt

cp $LUX_TAG/lib/*.so $TARGET/$LUX_TAG-wheel/pyluxcore
cp $TARGET/lib/libOpenImageDenoise.so.0 $TARGET/lib/libembree3.so.3 $TARGET/lib/libtbb.so.2 $TARGET/lib/libtbbmalloc.so.2 $TARGET/$LUX_TAG-wheel/pyluxcore


cd $TARGET/$LUX_TAG-wheel
python3 setup.py bdist_wheel --plat-name manylinux1_x86_64
#twine upload dist/luxcorerender-2.0-cp34-cp34m-manylinux1_x86_64.whl
#
mv dist/luxcorerender-2.0-cp34-cp34m-manylinux1_x86_64.whl dist/luxcorerender-2.0b-cp34-cp34m-manylinux1_x86_64.whl
twine upload dist/luxcorerender-2.0b-cp34-cp34m-manylinux1_x86_64.whl
cd -
