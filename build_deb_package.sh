#! /bin/bash

SOURCE_CODE_DIR=$1
TARBALL=$2
TARBALL_DIR=$SOURCE_CODE_DIR/TARBALL
DEB_PACKAGE_NAME=$3
SOURCE_PACKAGE_DIR=$1/packages/debian/$3
DEB_PACKAGE_DIR=$1/deb-packages
DEBIAN_PATH=$DEB_PACKAGE_DIR/$DEB_PACKAGE_NAME
COUNT_PARAM=$#
####################################################################################################
validate_args() {
		clear
		if [ $COUNT_PARAM -eq 0 ] ; then
				echo -e "SOURCE_CODE_DIRECTORY Missing"
				exit 0
		elif [ ! -d $SOURCE_CODE_DIR ]; then
				echo -e "SOURCE_CODE_DIRECTORY: $SOURCE_CODE_DIR Missing"
				exit 0
		elif [ $COUNT_PARAM -eq 1 ] ; then
				echo -e "TARBALL Name is Missing"
				exit 0	
		elif [ ! -f $TARBALL ] ; then
				echo -e "TARBALL: $TARBALL does not exist here"
				exit 0	
		else
				mkdir -p $TARBALL_DIR
				tar -xf $TARBALL -C $TARBALL_DIR
				#mv $TARBALL_DIR/* $TARBALL_DIR/$DEB_PACKAGE_NAME
		fi
}
####################################################################################################
create_deb_package_dir () {
    if [ -d $DEB_PACKAGE_DIR ] ; then
       :
    else 
       mkdir -p $DEB_PACKAGE_DIR
    fi
}
####################################################################################################
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
####################################################################################################
copy_source_code () {
	cp -r $SOURCE_PACKAGE_DIR/* $DEBIAN_PATH
    cp -r $TARBALL_DIR/$DEB_PACKAGE_NAME/* $DEBIAN_PATH/opt/
#     cp $TARBALL_DIR/$DEB_PACKAGE_NAME/kibana4 $DEBIAN_PATH/etc/init.d/
# 	chmod +x $DEBIAN_PATH/etc/init.d/kibana4
}
####################################################################################################
build_deb_package () {
    CURDIR=${PWD}
    cd $DEB_PACKAGE_DIR
    dpkg-deb --build $DEB_PACKAGE_NAME
    cd $CURDIR
	rm -rf $TARBALL_DIR 
	echo -e "The $DEB_PACKAGE_NAME.deb is created at $DEB_PACKAGE_DIR"
	ls $DEB_PACKAGE_DIR	
}
####################################################################################################
validate_args
create_deb_package_dir
create_dir_structure
copy_source_code
build_deb_package
