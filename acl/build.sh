pkgname=acl
pkgver=2.3.2
make="bad --gmake gmake"

fetch() {
	curl -LJ "http://download.savannah.nongnu.org/releases/acl/acl-2.3.2.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	MAKE="$make" ./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE
	$make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	$make install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat doc/COPYING
}
