pkgver=18.1.8
pkgname=libclc
mkdeps="openssl:cmake:samurai:python:"
deps=
bad=""
ext="dev"

fetch() {
	curl -L "https://github.com/llvm/llvm-project/releases/download/llvmorg-$pkgver/llvm-project-$pkgver.src.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
	mv llvm-project-$pkgver.src $pkgname-$pkgver
}

build() {
	cd $pkgname-$pkgver

	PREFIX=/usr

	[ -z "$FOR_CROSS" ] || PREFIX=$FOR_CROSS_DIR

	if [ ! -z "$WITH_CROSS" ]; then
		cmake_extra_flags=-DCMAKE_SYSROOT=$WITH_CROSS_DIR
	fi

	mkdir -p build
	cd build
	cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
		-DLLVM_ENABLE_PROJECTS=libclc \
		-DCMAKE_ASM_COMPILER_TARGET=$ARCH-linux-musl \
		-DCMAKE_C_COMPILER_TARGET=$ARCH-linux-musl \
		-DCMAKE_CXX_COMPILER_TARGET=$ARCH-linux-musl \
		-DCMAKE_SHARED_LINKER_FLAGS="$LDFLAGS" \
		$cmake_extra_flags \
		-DCMAKE_INSTALL_PREFIX=$PREFIX \
		-DCMAKE_C_COMPILER_WORKS=1 \
		-DCMAKE_CXX_COMPILER_WORKS=1 \
		-DCMAKE_SKIP_BUILD_RPATH=0 \
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=1 \
		-DCMAKE_INSTALL_RPATH='${ORIGIN}/../lib' \
		../llvm

	samu libclc
}

package() {
	cd $pkgname-$pkgver
	cd build
	DESTDIR=$pkgdir samu install
}

backup() {
	return
}

package_dev() {
	echo "No... Shut"
}

license() {
	cd $pkgname-$pkgver
	cat */LICENSE.TXT
}
