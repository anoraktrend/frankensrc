pkgname=mdev-conf
pkgver=4.7
comp=gz

fetch() {
	curl "https://gitlab.alpinelinux.org/alpine/mdev-conf/-/archive/4.7/mdev-conf-4.7.tar.gz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
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
	cat LICENSE
}
