pkgname=libelf
pkgver=0.191
comp=bz2
desc="libelf is yet another toolset for enabling elf stuff, only used in compiling the linux kernel"

fetch() {
	curl "https://sourceware.org/elfutils/ftp/$pkgver/elfutils-$pkgver.tar.$comp" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
	mv elfutils-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	bad --gmake ./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-debuginfod \
		--disable-libdebuginfod \
		--disable-nls \
		--build=$TRIPLE \
		--host=$TRIPLE
	printf '%s\n'"all:" "install:" > src/Makefile
	bad --gmake gmake
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	mkdir -p $pkgdir/etc/profile.d/
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING*
}
