pkgname=gettext-tiny
pkgver=0.3.2
comp=gz

fetch() {
	curl "https://github.com/sabotage-linux/gettext-tiny/archive/refs/tags/v0.3.2.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake LIBINTL=MUSL
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install LIBINTL=MUSL DESTDIR=$pkgdir prefix=/usr/
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
}
