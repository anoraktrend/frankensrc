pkgname=rnp
pkgver=0.17.1
mkdeps="attr:acl:json-c:bzip2:botan"
deps="libcxx:libunwind:musl"

fetch() {
	curl "https://github.com/rnpgp/rnp/releases/download/v0.17.1/rnp-v0.17.1.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mkdir $pkgname-v$pkgver/build
}

build() {
	cd $pkgname-v$pkgver
	cd build
	cmake -G Ninja ../ \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib
	samu
}

backup() {
	return
}

package() {
	cd $pkgname-v$pkgver
	cd build
	DESTDIR=$pkgdir samu install
}

license() {
	cd $pkgname-v$pkgver
	cat LICENSE.md
#	cat COPYING
}
