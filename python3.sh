#
# Package: python3
# Tested version: python3 3.7.3
#
file_name=Python-${version}.tgz
url=https://www.python.org/ftp/python/${version}/${file_name}
strip=1
arch=x86_64
#the default configure options
configure_options="--prefix=/usr --enable-shared --with-system-expat --with-system-ffi"


function post_make() {
	#${PKG} is the package dir
	#${SOURCE_DIR} is the source dir, where run the compile and the make
	#${1} is equal with the ${SOURCE_DIR}
	chmod -v 755 $PKG/usr/lib/libpython3.4m.so
	chmod -v 755 $PKG/usr/lib/libpython3.so
}

function pre_make() {
	#${PKG} is the package dir
	#${SOURCE_DIR} is the source dir, where run the compile and the make
	#${1} there is no parameter to the function.
	# This function called before configure on the source
	echo -en ""
}

function configure() {
	#${1} is the source dir
	#${SOURCE_DIR} is equal with the ${1}
	echo "Configuring in : ${1}..."
	cd ${1}
	./configure ${configure_options}
}

function build() {
	#${1} is the target directory, where the raw binaries will be saved
	#${SOURCE_DIR} is the sources dir
	# Default, the make running in the ${SOURCE_DIR}, because the configure function cding into this dir
	echo "Starting build... ${name} in ${SOURCES}"
	make -j${NUMCPU} && make DESTDIR="${1}" install
}
