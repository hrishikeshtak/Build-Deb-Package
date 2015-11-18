# Build-Deb-Package
This is an introductory tutorial for making Debian packages (.deb) from TARBALL

#### How To Run Script :                
First  add the description of your package in the file **control**     
**python make_deb_from_tar.py source-code-dir tarball**

#### Description :          

1 validate_args : 
>validate the argument passed to script .

2 create_dir_structure :     
>Change **/opt** to the actual name of directory where the code to be copied
. If more directory then add the necessary lines in the script ,      
like **mkdir -p $DEBIAN_PATH/etc/init.d/**

3 copy_source_code : 
> It specify where to copy the source code, after installation of package

