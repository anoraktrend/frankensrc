pkgname=boost
pkgver=1.85.0

fetch() {
	curl "https://github.com/boostorg/boost/releases/download/$pkgname-$pkgver/$pkgname-$pkgver-b2-nodocs.tar.xz" -LJo $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
}

build() {
	cd $pkgname-$pkgver
	./bootstrap.sh \
		--with-toolset=clang \
		--prefix=/usr \
		--libdir=/lib 
	./b2 clean
	./b2 stage -j$JOBS toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" threading=multi
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	./b2 install threading=multi link=shared --prefix=$pkgdir/usr
}

license() {
	cd $pkgname-$pkgver
	cat doc/COPYING
}
