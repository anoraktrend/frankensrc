pkgname=musl-rpmatch
pkgver=1.0
mkdeps="bmake"
deps="libcxx:libunwind:musl"

fetch() {
	curl "https://github.com/chimera-linux/$pkgname/archive/refs/tags/v$pkgver-mk2.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv  $pkgname-$pkgver-mk2 $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	CFLAGS="$CFLAGS" make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir PREFIX=/usr make install
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
