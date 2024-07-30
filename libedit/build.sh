pkgname=libedit
pkgdate=20240517
pkgver=3.1

fetch() {
	curl "https://www.thrysoee.dk/editline/$pkgname-$pkgdate-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgdate-$pkgver
	./configure CFLAGS="-D__STDC_ISO_10646__=201103L" \
		--prefix=/usr \
		--sysconfdir=/etc \
                --disable-silent-install \
		--build=$HOST_TRIPLE \
		--host=$TRIPLE
	make -j1
}

package() {
	cd $pkgname-$pkgdate-$pkgver
	make install DESTDIR=$pkgdir
	incdir="$pkgdir/usr/include"
	libdir="$pkgdir/usr/lib"
	ln -s $incdir/editline $incdir/readline
	ln -s $incdir/editline/readline.h $incdir/editline/history.h
	ln -s $libdir/libedit.so.0.0.73 $libdir/libreadline.so
}

backup () {
	return
}

license() {
	cd $pkgname-$pkgdate-$pkgver
	cat COPYING
}
