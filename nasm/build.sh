pkgname=nasm
pkgver=2.16.03
desc="Old assembler for x86_64 assembly, used for ffmpeg and limine"

fetch() {
	curl "http://www.nasm.us/pub/nasm/releasebuilds/$pkgver/$pkgname-$pkgver.tar.gz" -LJo $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
}

build() {
	cd $pkgname-$pkgver
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \

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
	cat LICENSE
}
