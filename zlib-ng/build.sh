pkgname=zlib-ng
pkgver=2.2.1
comp=gz

fetch() {
	curl "https://github.com/zlib-ng/zlib-ng/archive/refs/tags/2.2.1.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure \
		--prefix=/usr \
		--build=$TRIPLE \
		--host=$TRIPLE

	make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	make install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat doc/COPYING
}
