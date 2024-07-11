pkgname=chimerautils
pkgver=14.0.7

fetch() {
	curl -LJ "https://github.com/chimera-linux/chimerautils/archive/refs/tags/v14.0.7.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	muon setup \ 
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibexecdir=lib \
		build
	samu -C
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir muon -C build install
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
#	cat COPYING
}

backup() {
	return
}
