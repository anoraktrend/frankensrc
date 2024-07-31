pkgname=libedit
pkgver=14.0.7
mkdeps="bmake:flex:musl-fts:musl-rpmatch:byacc:libxo:ncurses::libbsd:libcrypto"
deps="musl-fts:musl-rpmatch:libxo:ncurses:libbsd:openssl"
desc="Libedit from Chimera Linux, an up-to-date libedit"

fetch() {
	git clone "https://github.com/chimera-linux/libedit-chimera" $pkgname-$pkgver
	#tar -xf $pkgname-$pkgver.tar.gz
	#mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	CFLAGS="$CFLAGS -fPIC" \
	LDFLAGS="$LDFLAGS -fPIC" \
	make help.h vis.h fcns.h func.h
	make CFLAGS="$CFLAGS -I. -fPIC"
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir PREFIX=/usr/ make install
	incdir="$pkgdir/usr/include"
	libdir="$pkgdir/usr/lib"
	ln -s $incdir/editline $incdir/edit
	ln -s $incdir/editline $incdir/readline
	ln -s $incdir/editline/readline.h $incdir/editline/history.h
	ln -s $libdir/libedit.so.0.0.0 $libdir/libreadline.so
}

license() {
	cd $pkgname-$pkgver
#	cat LICENSE
	cat COPYING
}

backup() {
	return
}
