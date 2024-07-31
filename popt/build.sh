pkgname=popt
pkgver=1.19
comp=gz

fetch() {
	curl "http://ftp.rpm.org/popt/releases/popt-1.x/popt-1.19.tar.gz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure \
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
	cat COPYING
}
