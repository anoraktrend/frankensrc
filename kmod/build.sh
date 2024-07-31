pkgname=kmod
pkgver=32
comp=xz

fetch() {
	curl "https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod/kmod-32.tar.xz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure MAKE="bad --gmake gmake" \
                CFLAGS="$CFLAGS -Wno-int-conversion -Wno-implicit-function-declaration"\
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-nls \
                --disable-symver \
                --build=$TRIPLE \
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
	cat COPYING
}
