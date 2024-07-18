pkgname=ee-fbsd
pkgver=1.5.1
mkdeps="bmake"
deps="musl"

fetch() {
	curl "https://github.com/anoraktrend/$pkgname/archive/refs/tags/$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	CFLAGS="$CFLAGS -Wno-pointer-sign -DNO_CATGETS --static -DHAS_NCURSES -I /usr/bad/ncurses/include/ -L/usr/bad/ncurses/lib -lncursesw" \
	make -f make.local
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	mkdir -p $pkgdir/usr/bin $pkgdir/usr/share/man/man1
	DESTDIR=$pkgdir PREFIX=/usr make install
}

license() {
	cd $pkgname-$pkgver
	cat README.ee 
}
