pkgname=pax-utils
pkgver=1.3.7
comp=gz

fetch() {
	curl "https://github.com/gentoo/pax-utils/archive/refs/tags/v1.3.7.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	meson setup build \
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibexecdir=lib
	samu -C build
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir samu -C build install
}

license() {
	cd $pkgname-$pkgver
#	cat LICENSE
	cat COPYING
}

backup() {
	return
}
