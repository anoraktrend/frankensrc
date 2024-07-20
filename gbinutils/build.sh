pkgver=2.42
pkgname=binutils
pkgrel=0
deps="musl:bad"
bad=""

auto_cross

fetch() {
	curl "https://ftp.gnu.org/gnu/$pkgname/$pkgname-$pkgver.tar.xz" -LJo $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	./configure LDFLAGS="$LDFLAGS -Wl,--undefined-version" \
		CFLAGS="$CFLAGS" \
		MAKE="bad --gmake gmake" \
		--disable-werror \
		--disable-multilib \
		--disable-gprofng \
		--disable-nls \
		--with-pic \
		--prefix=/usr/bad/gmake \
		--build=$HOST_TRIPLE \
		--host=$TRIPLE
	bad --gmake gmake
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING*
}

backup() {
	return
}
