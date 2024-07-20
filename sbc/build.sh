pkgname=sbc
pkgver=2.0
pkgrel=0

fetch() {
	curl -LJ "https://www.kernel.org/pub/linux/bluetooth/sbc-2.0.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	./configure CFLAGS="$CFLAGS -Wno-implicit-function-declaration -Wno-int-conversion -I/usr/bad/readline/include/" \
		LDFLAGS="$LDFLAGS -Wl,--allow-shlib-undefined -L/usr/bad/readline/lib" \
		--prefix=/usr                   \
		--sysconfdir=/etc               \
		--build=$TRIPLE                 \
		--host=$TRIPLE

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
	cat COPYING*
}
