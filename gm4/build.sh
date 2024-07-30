pkgver=1.4.19
pkgname=gm4
pkgrel=1
deps="musl"
bad="gmake"
auto_cross

fetch() {
	curl "https://mirrors.kernel.org/gnu/m4/m4-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv m4-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	./configure \
		--prefix=/usr/bad/gmake \
		--program-prefix=g \
		--disable-nls \
		--build=$HOST_TRIPLE \
		--host=$TRIPLE
	bad --gmake gmake 
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}

backup() {
	return
}
