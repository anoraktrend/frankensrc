pkgname=aee
pkgver=2.3.1
mkdeps="bmake"
deps="musl"

fetch() {
	curl "https://github.com/anoraktrend/$pkgname/archive/refs/tags/$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	CFLAGS="$CFLAGS -Wno-pointer-sign \
	 -Wno-deprecated-non-prototype \
	-Wno-format-security \
	-DNO_CATGETS -DHAS_NCURSES -lncursesw" \
	make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	mkdir -p $pkgdir/usr/bin $pkgdir/usr/share/man/man1
	DESTDIR=$pkgdir PREFIX=/usr/ make install
}

license() {
	cd $pkgname-$pkgver
	cat README.aee 
}
