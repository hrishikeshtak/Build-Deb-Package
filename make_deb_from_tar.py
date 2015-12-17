#!/usr/bin/env python
import sys
import subprocess

COUNT_PARAM=len(sys.argv)
####################################################################################################
# Function to validate argument
def validate_args():
    if COUNT_PARAM == 1:
        sys.exit("Source Code Directory is missing (Give the path of Build-Deb-Package directory)")
    elif COUNT_PARAM == 2:
        sys.exit("TARBALL is missing")
    SOURCE_CODE_DIR = sys.argv[1]
    TARBALL = sys.argv[2]
    return SOURCE_CODE_DIR,TARBALL
####################################################################################################
# function to get package name
def getPkgName(TARBALL):
    for x in range(0,len(TARBALL)-4):
        if (TARBALL[x:x+3]) == "tar":
            return TARBALL[:x-1]
    sys.exit("Invalid TARBALL. please give valid TARBALL name as paramter")
####################################################################################################
SOURCE_CODE_DIR,TARBALL = validate_args()
pkgName = getPkgName(TARBALL)
subprocess.call("mkdir -p packages/debian/"+pkgName,shell=True)
subprocess.call("cp -r files/DEBIAN packages/debian/"+pkgName,shell=True)
subprocess.call("cp control files/DEBIAN",shell=True)
subprocess.call("cp control packages/debian/"+pkgName+"/DEBIAN/",shell=True)
cmd = "bash build_deb_package.sh "+SOURCE_CODE_DIR+" "+TARBALL+" "+pkgName
subprocess.call(cmd,shell=True)
####################################################################################################
