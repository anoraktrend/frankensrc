pkgver=
pkgname=
pkgrel=
deps="musl:bad"
bad=""
comp=
auto_cross

fetch() {
	curl "" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure CFLAGS="-fPIC" MAKE="" \
		--prefix=/usr/bad/$pkgname \
		--build=$HOST_TRIPLE \
		--host=$TRIPLE
	make
}

package() {
	cd $pkgname-$pkgver
	make install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING*
}

backup() {
	return
}
