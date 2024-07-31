pkgname=lddtree
pkgver=1.27
comp=gz

fetch() {
	curl "https://github.com/ncopa/lddtree/archive/refs/tags/v1.27.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	make
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	cp ../../COPYING .
	install -Dm755 lddtree.sh $pkgdir/usr/bin/lddtree
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
