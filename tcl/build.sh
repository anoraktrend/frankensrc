pkgname=tcl
pkgver=8.6.13
comp=gz

fetch() {
	curl "https://core.tcl-lang.org/tcl/tarball/release/tcl.tar.gz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
        mv $pkgname $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	./unix/configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE

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
	cat license.terms
}
