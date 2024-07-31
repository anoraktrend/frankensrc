pkgname=rsync
pkgver=3.3.0
comp=gz

fetch() {
	curl "https://github.com/RsyncProject/rsync/archive/refs/tags/v3.3.0.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	PATH="$PATH:/usr/bad/gmake/bin" ./configure \
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
}

license() {
	cd $pkgname-$pkgver
	cat doc/COPYING
}
