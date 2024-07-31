pkgname=python-elftools
pkgver=0.31
comp=gz

fetch() {
	curl "https://github.com/eliben/pyelftools/archive/refs/tags/v0.31.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
	mv pyelftools-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	python setup.py build
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	python setup.py install --root=$pkgdir --skip-build
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
#	cat COPYING
}
