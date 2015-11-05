#! /bin/bash
set -x
SOURCE_CODE_DIR=$1
SOURCE_PACKAGE_DIR=$1/packages/debian/sc-kibana
DEB_PACKAGE_DIR=$1/deb-packages
DEBIAN_PATH=$DEB_PACKAGE_DIR/sc-kibana-4.1.2



create_deb_package_dir () {

    if [ -d $DEB_PACKAGE_DIR ] ; then
       :
    else 
       mkdir -p $DEB_PACKAGE_DIR
    fi
}

create_dir_structure () {

    # creating base directory for package
    if [ -d $DEBIAN_PATH ] ; then
       rm -rf $DEBIAN_PATH/*   
    else
       mkdir -p $DEBIAN_PATH
    fi 
    mkdir -p $DEBIAN_PATH/opt/
    mkdir -p $DEBIAN_PATH/etc/init.d/
}   

copy_source_code () {
	cp -r $SOURCE_PACKAGE_DIR/* $DEBIAN_PATH
    cp -r $SOURCE_CODE_DIR/utils/kibana $DEBIAN_PATH/opt/
    SC_KIBANA_CODE_DIR=$SOURCE_CODE_DIR/utils/kibana
    cp $SC_KIBANA_CODE_DIR/kibana4 $DEBIAN_PATH/etc/init.d/
	chmod +x $DEBIAN_PATH/etc/init.d/kibana4
}

build_deb_package () {
    CURDIR=${PWD}
    cd $DEB_PACKAGE_DIR
    dpkg-deb --build sc-kibana-4.1.2
    cd $CURDIR
}

create_deb_package_dir
create_dir_structure
copy_source_code
build_deb_package

