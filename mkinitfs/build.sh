pkgname=mkinitfs
pkgver=3.10.2
comp=gz

fetch() {
	curl "https://gitlab.alpinelinux.org/alpine/mkinitfs/-/archive/3.10.2/mkinitfs-3.10.2.tar.gz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
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
	cp ../../gpl-2.0.txt ./COPYING
	cat COPYING
}
