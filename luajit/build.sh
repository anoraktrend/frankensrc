pkgname=luajit
pkgver=2.1
pkgrel=20240410
DESC="LuaJIT is a ROLLING RELEASE the date after the version is the day the the version was fetched"

fetch() {
	git clone "https://luajit.org/git/luajit.git" $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver
	bad --gmake gmake amalg CC=cc CFLAGS="$CFLAGS -fPIC" PREFIX=/usr/ XCFLAGS="-DLUAJIT_ENABLE_LUA52COMPAT -DLUAJIT_NUMMODE=2"

}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake install PREFIX=/usr/ DESTDIR=$pkgdir
	ln -sf libluajit-5.1.so.2.0.5 "$pkgdir/usr/lib/libluajit-5.1.so"
	ln -sf libluajit-5.1.so.2.0.5 "$pkgdir/usr/lib/libluajit-5.1.so.2"

}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat COPYRIGHT
}
