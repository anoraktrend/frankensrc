pkgname=libvterm
pkgver=0.3.3
pkgrel=617
desc="An abstract library implementation of a VT220/xterm/ECMA-48 terminal emulator."
comp=gz

fetch() {
	git clone "https://github.com/neovim/libvterm"  $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake LIBTOOL=glibtool
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake LIBTOOL=glibtool PREFIX=/usr DESTDIR=$pkgdir install
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
#	cat COPYING
}
