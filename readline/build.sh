pkgver=8.2
pkgname=readline
pkgrel=1
deps="musl:bad"
bad=""
comp=
auto_cross

fetch() {
	curl "https://ftp.gnu.org/gnu/readline/$pkgname-$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	./configure CFLAGS="$CFLAGS -Wno-parentheses" MAKE="bad --gmake gmake" \
		--prefix=/usr/bad/$pkgname \
		--build=$HOST_TRIPLE \
		--host=$TRIPLE
	bad --gmake gmake
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install DESTDIR=$pkgdir
}

license() {
	cd $pkgname-$pkgver
	cat COPYING*
}

backup() {
	return
}
