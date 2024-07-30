pkgname=harfbuzz
pkgver=9.0.0
deps="icu"

fetch() {
	curl -L "https://github.com/harfbuzz/harfbuzz/releases/download/$pkgver/harfbuzz-$pkgver.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	CFLAGS="$CFLAGS -Wno-traditional -Wunused-but-set-variable" meson setup \
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibexecdir=lib \
		-Ddefault_library=shared \
		-Dglib=enabled \
		-Dgobject=disabled \
		-Dicu=enabled \
		-Dgraphite2=enabled \
		build

	samu -C build
}

backup() {
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir samu -C build install
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
