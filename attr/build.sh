pkgname=attr
pkgver=2.5.2

fetch() {
	curl -LJ "http://download.savannah.nongnu.org/releases/attr/attr-2.5.2.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	MAKE="bad --gmake gmake" ./configure \
		CFLAGS="-Wno-implicit-function-declaration -Wno-int-conversion" \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE
	bad --gmake gmake
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake  install DESTDIR=$pkgdir
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat doc/COPYING
}
