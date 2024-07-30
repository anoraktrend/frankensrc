pkgver=6.5
pkgname=ncurses
pkgrel=20240706
deps="musl:bad"
bad=""
comp=gz
auto_cross

fetch() {
	curl "https://invisible-island.net/archives/ncurses/current/ncurses-6.5-20240706.tgz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv $pkgname-$pkgver-20240706 $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
        MAKE="bad --gmake gmake" ./configure CFLAGS="$CFLAGS" \
		--prefix=/usr/ \
		--libexecdir=/usr/lib/ \
		--build=$HOST_TRIPLE \
		--with-shared \
		--without-debug \
		--with-normal \
		--enable-overwrite \
		--with-cxx-shared \
		--with-cxx-binding \
		--disable-stripping \
		--without-ada \
		--without-tests \
		--with-xterm-kbs=del \
		--enable-ext-colors \
		--enable-pc-files \
		--enable-widec \
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
