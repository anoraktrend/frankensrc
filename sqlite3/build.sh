pkgname=sqlite
pkgver=3.47.0
comp=gz

fetch() {
	curl "https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=release" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
        mv $pkgname $pkgname-$pkgver
        mkdir bld
}

build() {
	cd $pkgname-$pkgver
        cd ../bld
	../$pkgname-$pkgver/configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE

	bad --gmake gmake
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
        cd ../bld
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cp ../../COPYING .
        cat COPYING
}
