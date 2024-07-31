pkgname=tree-sitter
pkgver=0.22.6
comp=gz

fetch() {
	curl "https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v0.22.6.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
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
	cat LICENSE
}
