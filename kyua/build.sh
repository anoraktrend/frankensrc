pkgname=kyua
pkgver=0.13
comp=gz

fetch() {
	curl "https://github.com/freebsd/kyua/releases/download/kyua-0.13/kyua-0.13.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	PATH="$PATH:/usr/bad/gmake/bin" ./configure CXXFLAGS="$CXXFLAGS -std=gnu++98"\
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
	cat LICENSE
}
