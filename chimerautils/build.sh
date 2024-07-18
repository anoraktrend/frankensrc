pkgname=chimerautils
pkgver=14.0.7
NCURSES=/usr/bad/ncurses

fetch() {
	curl -LJ "https://github.com/chimera-linux/chimerautils/archive/refs/tags/v14.0.7.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	PATH="$PATH:$NCURSES/bin" \
	CFLAGS="$CFLAGS -I$NCURSES/include -I$NCURSES/include/ncursesw" \
	LDFLAGS="$LDFLAGS -L$NCURSES/lib" \
	pip3 install meson
	meson setup \
		-Dfts_path=/usr/lib \
		-Drpmatch_path=/usr/lib \
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibexecdir=lib \
		build
	samu -C build
}

package() {
	cd $pkgname-$pkgver
	DESTDIR=$pkgdir meson install -C build
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
#	cat COPYING
}

backup() {
	return
}
