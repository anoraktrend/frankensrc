pkgname=utf8proc
pkgver=2.9.0
comp=gz

fetch() {
	curl "https://github.com/JuliaStrings/utf8proc/releases/download/v2.9.0/utf8proc-2.9.0.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE.md
}
