pkgname=msgpack-c
pkgver=6.0.2
comp=gz

fetch() {
	curl "https://github.com/msgpack/msgpack-c/releases/download/c-6.0.2/msgpack-c-6.0.2.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	cd build
	cmake -G Ninja ../ \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib
	samu
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	cd build
	DESTDIR=$pkgdir samu install
}

license() {
	cd $pkgname-$pkgver
#	cat LICENSE
	cat COPYING
}
