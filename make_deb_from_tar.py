#!/usr/bin/env python
import sys
import subprocess

SOURCE_CODE_DIR = sys.argv[1]
TARBALL = sys.argv[2]
####################################################################################################
# function to get package name
def getPkgName(TARBALL):
    for x in range(0,len(TARBALL)-4):
        if (TARBALL[x:x+3]) == "tar":
            return TARBALL[:x-1]
    sys.exit("Invalid TARBALL. please give valid TARBALL name as paramter")
####################################################################################################
pkgName = getPkgName(TARBALL)
subprocess.call("mkdir -p packages/debian/"+pkgName,shell=True)
subprocess.call("cp -r files/DEBIAN packages/debian/"+pkgName,shell=True)
subprocess.call("cp control files/DEBIAN packages/debian/"+pkgName+"/DEBIAN/",shell=True)
cmd = "bash build_deb_package.sh "+SOURCE_CODE_DIR+" "+TARBALL+" "+pkgName
subprocess.call(cmd,shell=True)
####################################################################################################
