pkgname=nglibunwind
pakname=libunwind
pkgver=1.6.2

fetch() {
	curl "http://download.savannah.nongnu.org/releases/libunwind/$pakname-$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pakname-$pkgver
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE

	make
}

backup() {
	return
}

package() {
	cd $pakname-$pkgver
	make install DESTDIR=$pkgdir
}

license() {
	cd $pakname-$pkgver
	cat COPYING
}
