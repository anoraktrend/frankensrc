pkgver=1.2.5
scudo=18.1.8
pkgname=musl
deps=""
mkdeps="bad;gmake"
desc="Chimera's Musl"
bad="gmake"
ext="dev"

fetch() {
	curl "https://musl.libc.org/releases/$pkgname-$pkgver.tar.gz" -o $pkgname-$pkgver.tar.gz
	curl "https://github.com/llvm/llvm-project/releases/download/llvmorg-$scudo/compiler-rt-$scudo.src.tar.xz" -LJO
	tar -xf $pkgname-$pkgver.tar.gz
	ln -s /usr/bin/cc $ARCH-linux-musl-cc
	cd $pkgname-$pkgver
	tar -xf ../compiler-rt-$scudo.src.tar.xz
	mv compiler-rt-$scudo.src compiler-rt
	mkdir -p src/malloc/scudo/scudo/
	cp compiler-rt/lib/scudo/standalone/*.cpp compiler-rt/lib/scudo/standalone/*.h compiler-rt/lib/scudo/standalone/*.inc src/malloc/scudo
	cp compiler-rt/lib/scudo/standalone/include/scudo/interface.h src/malloc/scudo/scudo/
	rm src/malloc/scudo/wrappers_* src/string/x86_64/memcpy.s
	cp ../../files/wrappers.cpp src/malloc/scudo
	for i in ../../patches/*.patch; do patch < $i; done
# ^^^ COMMENT IT OUT: Chimera's musl patches, ported to iglunix, .
}


if [ -z "$FOR_CROSS" ]; then
	PREFIX=/usr
else
	PREFIX=$FOR_CROSS_DIR
fi


build() {
	cd $pkgname-$pkgver
	bad --gmake gmake clean	
	cp -r include include.bk
	cp -r /usr/include/* include/
	./configure \
		--prefix=$PREFIX \
		--target=$TRIPLE 
	bad --gmake gmake
	rm  -rf include
	mv include.bk include
	cp ../../files/getent.c ../../files/iconv.c ../../files/getconf.c .
	cc getent.c -o getent
	cc iconv.c -o iconv
	cc getconf.c -o getconf
}

package() {
	cd $pkgname-$pkgver
	bad --gmake gmake DESTDIR=$pkgdir install
	rm $pkgdir/lib/ld-musl-$ARCH.so.1
	cp getent iconv getconf $pkgdir/$PREFIX/bin	
	cp ../../files/*.1 $pkgdir/$PREFIX/share/man/man1
	mv $pkgdir/$PREFIX/lib/libc.so $pkgdir/lib/ld-musl-$ARCH.so.1
	ln -s $pkgdir/lib/ld-musl-$ARCH.so.1 $pkgdir/$PREFIX/lib/libc.so
	if [ -z "$FOR_CROSS" ]; then
		install -d $pkgdir/$PREFIX/bin
		ln -s $pkgdir/lib/ld-musl-$ARCH.so.1 $pkgdir/$PREFIX/bin/ldd
	fi
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat COPYRIGHT
}
