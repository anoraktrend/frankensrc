pkgver=3.11
pkgname=gnu-grep
pkgrel=1
deps="musl"
bad="gmake"
auto_cross

fetch() {
	curl "https://mirrors.kernel.org/gnu/grep/grep-3.11.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv grep-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	./configure \
		--prefix=/usr/bad/gmake \
		--program-prefix= \
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
