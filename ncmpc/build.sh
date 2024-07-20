pkgname=mpd
pkgver=0.23.15
deps="libsndfile"

fetch() {
	curl -L "https://www.musicpd.org/download/mpd/0.23/$pkgname-$pkgver.tar.xz" -o $pkgname-$pkgver.tar.bz2
	tar -xf $pkgname-$pkgver.tar.bz2
	cd $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	cd build
	CFLAGS="$CFLAGS -fPIC" \
	LDFLAGS="$LDFLAGS -Wl,--undefined-version"\
	meson setup .. \
		--buildtype=release \
		--prefix=/usr \
		--libexecdir=lib \
		--libdir=lib 
	samu
}

package() {
	cd $pkgname-$pkgver
	cd build
	DESTDIR=$pkgdir samu install
	rm -rf $pkgdir/usr/share/locale
	rm -rf $pkgdir/usr/share/bash*
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
#	cat COPYING
}
