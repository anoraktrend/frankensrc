pkgname=libedit
pkgdate=20240517
pkgver=3.1

fetch() {
	curl "https://www.thrysoee.dk/editline/$pkgname-$pkgdate-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgdate-$pkgver
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE
	make 
}

package() {
	cd $pkgname-$pkgdate-$pkgver
	make install DESTDIR=$pkgdir
}

backup () {
	return
}

license() {
	cd $pkgname-$pkgdate-$pkgver
	cat LICENSE
#	cat COPYING
}
