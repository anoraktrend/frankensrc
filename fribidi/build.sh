pkgname=fribidi
pkgver=1.0.15

fetch() {
	curl "https://github.com/fribidi/fribidi/releases/download/v1.0.15/$pkgname-$pkgver.tar.xz" -LJo $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	meson setup \
		--prefix=/usr \
		--sysconfdir=/etc \
		--buildtype=release \
		build
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
