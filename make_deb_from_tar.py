#!/usr/bin/env python
import sys
import subprocess

source_code_dir = sys.argv[1]
tarball = sys.argv[2]


# function to get package name
def getPkgName(tarball):
    for x in range(0,len(tarball)-4):
        if (tarball[x:x+3]) == "tar":
            return tarball[:x-1]
    print "Invalid tarball. please give valid tarball name as paramter\n"
    exit(0)

pkgName = getPkgName(tarball)
print pkgName
subprocess.call("mkdir -p packages/debian/"+pkgName,shell=True)
subprocess.call("cp -r files/DEBIAN packages/debian/"+pkgName,shell=True)
subprocess.call("cp control files/DEBIAN packages/debian/"+pkgName+"/DEBIAN/",shell=True)
cmd = "bash build_deb_package.sh "+source_code_dir+" "+tarball+" "+pkgName
print cmd
subprocess.call(cmd,shell=True)

