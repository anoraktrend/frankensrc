pkgname=libaio
pkgver=0.3.113
comp=gz

fetch() {
	curl "https://pagure.io/libaio/archive/$pkgname-$pkgver/libaio-$pkgname-$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
	mv libaio-$pkgname-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install DESTDIR=$pkgdir prefix=/usr
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
