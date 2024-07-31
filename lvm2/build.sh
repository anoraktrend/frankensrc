pkgname=lvm2
pkgver=2.03.25
comp=gz

fetch() {
	curl "http://mirrors.kernel.org/sourceware/lvm2/LVM2.$pkgver.tgz" -LJo $pkgname-$pkgver.tar.$comp
	tar -xf $pkgname-$pkgver.tar.$comp
        mv LVM2.$pkgver $pkgname-$pkgver
        cp ../*.patch .
        cd $pkgname-$pkgver
        patch < ../fix-stdio-usage.patch
}

build() {
	cd $pkgname-$pkgver
	./configure CCFLAGS="$CFLAGS -Wno-implicit-function-declaration -Wno-int-conversion" \
                LDFLAGS="$LDFLAGS -Wl,--undefined-version" \
		--prefix=/usr \
		--sysconfdir=/etc \
                --disable-readline \
                --enable-static_link \
                --disable-dependency-tracking \
                --with-crypto_backend=openssl \
                --disable-ssh-token \
                --enable-pkgconfig \
                --with-thin=internal \
                --enable-dmeventd \
                --enable-cmdlib \
                --with-thin-check=/sbin/thin_check \
                --disable-thin_check_needs_check \
                --with-thin-dump=/sbin/thin_dump \
                --with-thin-repair=/sbin/thin_repair \
                --with-thin-restore=/sbin/thin_restore \
                --with-cache-check=/sbin/cache_check \
                --disable-cache_check_needs_check \
                --with-cache-dump=/sbin/cache_dump \
                --with-cache-repair=/sbin/cache_repair \
                --with-cache-restore=/sbin/cache_restore \
                --with-dmeventd-path=/sbin/dmeventd \
                --without-systemd-run \
                CLDFLAGS="$LDFLAGS -Wl,--undefined-version" \
                --disable-nls \
		--build=$TRIPLE \
		--host=$TRIPLE

	bad --gmake gmake CFLAGS="$CFLAGS -Wno-implicit-function-declaration -Wno-int-conversion -fPIC"
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
