pkgname=lutok
pkgver=0.4
comp=gz

fetch() {
	curl "https://github.com/freebsd/lutok/releases/download/lutok-0.4/lutok-0.4.tar.gz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	LUA_CFLAGS=$(pkg-config --cflags lua) \
	LUA_LIBS=$(pkg-config --libs lua) \
	PATH="$PATH:/usr/bad/gmake/bin" \
	./configure CXXFLAGS="$CFLAGS -std=gnu++98" \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$CBUILD \
		--host=$CHOST \
		--with-libtool=glibtool \
		--mandir=/usr/share/man 

	bad --gmake USE_CXXSTD=GNU++98 gmake
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
