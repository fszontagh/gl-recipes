#
# Package: reiserfsprogs
# Tested version: reiserfsprogs 3.6.27
#
file_name="${name}"-"${version}".tar.gz
url=https://mirrors.edge.kernel.org/pub/linux/kernel/people/jeffm/${name}/v${version}/${file_name}
strip=1
arch=x86_64
#the default configure options
configure_options="--prefix=/usr --sbindir=/sbin"


function post_make() {
	#${PKG} is the package dir
	#${SOURCE_DIR} is the source dir, where run the compile and the make
	#${1} is equal with the ${SOURCE_DIR}
	echo -en ""
	cd ${PKG}
    ln -sf reiserfsck ${PKG}/sbin/fsck.reiserfs
    ln -sf mkreiserfs ${PKG}/sbin/mkfs.reiserfs	
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
	sed -i '/parse_time.h/i #define _GNU_SOURCE' lib/parse_time.c &&
	autoreconf -fiv && ./configure ${configure_options}
}

function build() {
	#${1} is the target directory, where the raw binaries will be saved
	#${SOURCE_DIR} is the sources dir
	# Default, the make running in the ${SOURCE_DIR}, because the configure function cding into this dir
	echo "Starting build... ${name} in ${SOURCES}"
	make -j${NUMCPU} && make DESTDIR="${1}" install
}
