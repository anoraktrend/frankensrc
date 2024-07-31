pkgname=lua
pkgver=5.4.7
pkver=5.4

fetch() {
	curl "https://www.lua.org/ftp/lua-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	cp ../COPYING $pkgname-$pkgver
	curl "https://codeberg.org/kiss-community/community/raw/branch/main/community/lua/files/lua.pc" -LJo $pkgname-$pkgver/lua.pc
}

build() {
	cd $pkgname-$pkgver
	sed "s/install -p/install/" Makefile > _
	mv -f _ Makefile

	sed "s|/usr/local|/usr|g" src/luaconf.h > _
	mv -f _ src/luaconf.h

	make MYCFLAGS="$CFLAGS -fPIC" \
	MYLDFLAGS="$LDFLAGS -fPIC" \
	freebsd CC=cc
}

package() {
	cd $pkgname-$pkgver
	make INSTALL_TOP="$pkgdir/usr" \
	INSTALL_MAN="$pkgdir/usr/share/man/man1" \
	INSTALL_DATA="cp -P" \
	install CC=cc
	mkdir -p "$pkgdir/usr/lib/pkgconfig"
	sed \
	-e "s|%VER%|$pkver|" \
	-e "s|%REL%|$pkgver|" \
	lua.pc > "$pkgdir/usr/lib/pkgconfig/lua.pc"
}

license() {
	cd $pkgname-$pkgver
#	cat LICENSE
	cat COPYING
}

backup() {
	return
}
