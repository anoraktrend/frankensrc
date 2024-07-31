pkgname=cryptsetup
pkgver=2.7.3
comp=xz

fetch() {
	curl "https://www.kernel.org/pub/linux/utils/cryptsetup/v2.7/cryptsetup-2.7.3.tar.xz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure \
		--prefix=/usr \
                --disable-static \
		--with-crypto_backend=openssl \
		--disable-external-tokens \
		--disable-ssh-token \
                --disable-asciidoc \
                --disable-nls \
		--disable-udev \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE
	sed '/^SUBDIRS = /s/tests//' Makefile > _
	mv _ Makefile
	make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	make install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
