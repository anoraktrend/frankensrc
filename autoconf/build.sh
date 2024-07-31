pkgname=autoconf
pkgver=2.72
comp=xz

fetch() {
	curl "https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure PATH="$PATH:/usr/bad/gmake/bin" \
		--prefix=/usr/bad/gmake \
		--sysconfdir=/etc \
		--build=$TRIPLE \
		--host=$TRIPLE

	bad --gmake gmake
}

backup() {
	return
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
