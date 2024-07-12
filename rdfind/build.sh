pkgver=1.6.0
pkg_ver=$(echo $pkgver | tr '.' '_')
pkgname=rdfind
pkgrel=1
mkdeps="nettle"
deps=""
bad=""
auto_cross

fetch() {
	curl -L https://rdfind.pauldreik.se/rdfind-$pkgver.tar.gz -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	./configure LDFLAGS="-L/usr/bad/nettle/lib/" CPPFLAGS="-I/usr/bad/nettle/include" \
		--prefix=/usr \
		--build=$HOST_TRIPLE \
		--host=$TRIPLE \
	make
}

package() {
	cd $pkgname-$pkgver
	make DESTDIR=$pkgdir install
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
