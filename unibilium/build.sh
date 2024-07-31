pkgname=unibilium
pkgver=2.0.0
comp=gz

fetch() {
	curl "https://github.com/mauke/unibilium/archive/refs/tags/v2.0.0.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake LIBTOOL=glibtool
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake LIBTOOL=glibtool install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
}
