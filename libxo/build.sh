pkgname=libxo
pkgver=1.7.5


fetch() {
	curl "https://github.com/Juniper/libxo/releases/download/1.7.5/libxo-1.7.5.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	./configure MAKE="bad --gmake gmake"\
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
	cat Copyright
}