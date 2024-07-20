pkgname=bluez
pkgver=5.77
pkgrel=0

fetch() {
	curl -LJ "https://www.kernel.org/pub/linux/bluetooth/bluez-5.77.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	./configure CFLAGS="$CFLAGS -Wno-implicit-function-declaration -Wno-int-conversion -I/usr/bad/readline/include/" \
		LDFLAGS="$LDFLAGS -Wl,--allow-shlib-undefined -L/usr/bad/readline/lib" \
		--prefix=/usr                   \
		--sysconfdir=/etc               \
		--localstatedir=/var            \
		--enable-library                \
		--disable-udev                  \
		--disable-obex                  \
		--disable-systemd               \
		--disable-perl                  \
		--disable-python                \
		--disable-manpages              \
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
