pkgname=luajit
pkgver=2.1
pkgrel=20230410
DESC="LuaJIT is a ROLLING RELEASE the date after the version is the day the the version was fetched"

fetch() {
	curl "https://github.com/openresty/luajit2/archive/refs/tags/v2.1-20230410.1.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv luajit2-2.1-20230410.1 $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	echo "run: make -j1 CFLAGS="" CC=clang PREFIX=/usr\nin the dir yourself"
}

package() {
	cd $pkgname-$pkgver
	make install $DESTDIR=$pkgdir PREFIX=/usr
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat COPYWRITE
}
