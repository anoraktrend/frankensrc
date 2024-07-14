pkgname=musl-fts
pkgver=1.2.8
mkdeps="cmake:samurai"
deps="libcxx:libunwind:musl"

fetch() {
	curl "https://github.com/stargirl-chan/musl-fts/archive/refs/tags/v$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	meson setup \
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibexecdir=lib \
		build
	samu -C build
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir meson install -C build
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
