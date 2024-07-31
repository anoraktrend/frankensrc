pkgname=luv
pkgver=1.48.0
pkgrel=2
desc="This library makes libuv available to lua scripts."
comp=gz

fetch() {
	git clone --recursive "https://github.com/luvit/luv/" $pkgname-$pkgver
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake INSTALL_PREFIX=/usr BUILD_SHARED_LIBS=ON BUILD_STATIC_LIBS=ON WITH_SHARED_LIBUV=ON CFLAGS="$CFLAGS -fPIC"
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	cd build
	bad --gmake gmake DESTDIR=$pkgdir INSTALL_PREFIX=/usr install
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE.txt
#	cat COPYING
}
