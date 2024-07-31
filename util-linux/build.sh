pkgname=util-linux
pkgver=2.40.2
comp=gz

fetch() {
	curl "https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.40/util-linux-2.40.2.tar.gz" -o $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
}

build() {
	cd $pkgname-$pkgver
	./configure \
                --enable-libuuid \
                --enable-blkid \
                --enable-fsck \
                --enable-vipw \
                --enable-newgrp \
                --enable-chfn-chsh \
		--prefix=/usr \
		--sysconfdir=/etc \
		--build=$TRIPLE \
                --disable-symvers \
		--host=$TRIPLE

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
