pkgver=2.4.7
pkgname=glibtool
pkgrel=1
deps="musl"
bad="gmake"
auto_cross

fetch() {
	curl "https://mirrors.kernel.org/gnu/libtool/libtool-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv libtool-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	./configure PATH="$PATH:/usr/bad/gmake/bin/" \
		--prefix=/usr/bad/gmake \
		--program-prefix=g \
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
