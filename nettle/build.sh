pkgver=3.4.1
pkgname=nettle
pkgrel=2
deps="musl"
bad=""
ext="doc:dev"
auto_cross

fetch() {
	curl "https://ftp.gnu.org/gnu/nettle/nettle-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	./configure CFLAGS="-fPIC" \
		--prefix=/usr/bad/nettle \
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
