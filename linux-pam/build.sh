pkgname=linux-pam
pkgver=1.6.1

fetch() {
	curl -L "https://github.com/linux-pam/linux-pam/releases/download/v1.6.1/Linux-PAM-1.6.1.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
	mv Linux-PAM-$pkgver $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	./configure \
		--prefix=/usr \
		--enable-static \
		--enable-shared \
		--build=x86_64-unknown-linux-musl \
		--host=x86_64-unknown-linux-musl \
		--libdir=/usr/lib \
		--sbindir=/usr/sbin

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
	cat COPYING
}
