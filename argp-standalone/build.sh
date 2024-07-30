pkgname=argp-standalone
pkgver=1.5.2
comp=gz

fetch() {
	curl "https://github.com/anoraktrend/$pkgname/releases/download/$pkgver/$pkgname-$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	meson setup build \
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibexecdir=lib
	samu -C build
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir samu -C build install
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
