pkgname=lpeg
pkgver=1.1.0
pkgrel=0
desc="LPeg is a pattern-matching library for Lua."
comp=gz

fetch() {
	curl "https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.1.0.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake CC=clang LIBTOOL=glibtool CFLAGS="$CFLAGS -fPIC"
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	install -d $pkgdir/usr/lib/lua/5.4/
	install -c lpeg.so $pkgdir/usr/lib/lua/5.4/
	ln $pkgdir/usr/lib/lua/5.4/lpeg.so $pkgdir/usr/lib/liblpeg.so
}

license() {
	cd $pkgname-$pkgver
	cp ../../LICENSE .
	cat LICENSE
#	cat COPYING
}
