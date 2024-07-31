pkgname=ugrep
pkgver=6.2.0
comp=gz

fetch() {
	curl "https://github.com/Genivia/ugrep/archive/refs/tags/v6.2.0.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure \
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
	bad --gmake gmake install DESTDIR=$pkgdir
	ln $pkgdir/usr/bin/ug $pkgdir/usr/bin/grep
	ln $pkgdir/usr/bin/ug $pkgdir/usr/bin/egrep
	ln $pkgdir/usr/bin/ug $pkgdir/usr/bin/fgrep
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE.txt
}
