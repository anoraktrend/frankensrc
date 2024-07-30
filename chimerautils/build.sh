pkgname=chimerautils
pkgver=14.0.7
mkdeps="meson:samurai:flex:musl-fts:musl-rpmatch:byacc:libxo:ncurses:libedit:libbsd:libcrypto"
deps="musl-fts:musl-rpmatch:libxo:ncurses:libedit:libbsd:openssl"
desc="ChimeraUtils are a coreutils replacement using freebsd's core utilities, forked from bsdutils"

fetch() {
	curl -LJ "https://github.com/chimera-linux/chimerautils/archive/refs/tags/v14.0.7.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mkdir $pkgname-$pkgver/build
}

build() {
	cd $pkgname-$pkgver
	CFLAGS="$CFLAGS" \
	LDFLAGS="$LDFLAGS" \
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
