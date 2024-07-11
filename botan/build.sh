pkgname=botan
pkgver=3.5.0

fetch() {
	curl "https://botan.randombit.net/releases/Botan-3.5.0.tar.xz" -LJo $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
	mv Botan-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	./configure.py \
		--prefix=/usr \
		--sysconfdir=/etc \
		--cc=clang
	make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	make install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat license.txt 
}
