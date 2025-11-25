# Maintainer: Alexander Epaneshnikov <alex19ep@archlinux.org>

pkgbase=brltty-git
pkgname=(brltty-git brltty-udev-generic-git)
pkgver=6.8.r154.gc59955b29
pkgrel=1
pkgdesc="Braille display driver for Linux/Unix (development version)"
arch=(x86_64)
url="https://brltty.app"
license=(LGPL2.1)
makedepends=(alsa-lib at-spi2-core bluez-libs cython dbus dracut espeak-ng expat
             festival gcc-libs git glibc glib2 gpm icu java-environment
             liblouis libspeechd libxaw ncurses ocaml-ctypes ocaml-findlib pcre2
             polkit python-setuptools speech-dispatcher strip-nondeterminism systemd-libs
             tcl)
options=(!emptydirs)
source=(${pkgname%-git}::'git+https://github.com/brltty/brltty.git'
        "${pkgname%-git}-6.2-systemd_sysusers_groups.patch"
        "${pkgname%-git}-6.8-lock-brltty-user.patch"
        "${pkgname%-git}-6.4-x11_autostart.patch"
        "${pkgname%-git}-6.8-udev-tty-perms.rules"
)
sha512sums=('SKIP'
            '32ba91271e2247b4a330cd213ed75b591268cb99a79c2efd9ae675804faee027c6b2f782768cb2329a65fc914ca2400b2901f35ce1fc2522c6691b343799eb02'
            '2f1dba4fa5495913837972030fbcf1c265c90d481d9e0f96ff89c6cab082f7a6b0594c5c7ca6ea446eb76c8f483c7ed57ede58480898ae003261e6373440862c'
            '4871512affefbc178f4204a1b285fc2b5a05ea2d181163195d695b760e9729b3d2d00b5f052abd71379df609c3859d7cbd64128bdefd16e898bbc4368500a9a0'
            'dd210599e467a073f891554c7d3991dce90fa0506a7aef28c43a1543d94073e8d561d36c909511778d4bfcc198cac04f146966edf4462d5e553224a72864f6f3')
b2sums=('SKIP'
        '036e36d558594bb06af1eb41ff5fc9ae52ccf4bad54556c3f4f81a5e2f31f574039835e5e756455527c327a73d563a3db54a9f32e3478545a2a22c2725aaeee2'
        '76fd46571dab803c39a1663e52293c7e1ee9232b6241528e708bca072c7f9bd270c1961b960bece7f91331a259042b8dfc9a8e77f7dc463944b305700fe0c8f6'
        '4ebc07a725ef8362233a83118e93901e78943e8dae08f9358b668ff13ab88a65eb9e87c49d106a8c3d87eb62007b230e199107eacb01f92dc683335076c01309'
        '7110448b42799195abbc6f9711ebe25cdbc95056833764332c343a2d6e1201c8b590644db46a2d6612fa96740cb7da8cc7f72bb329127ae3bb6c8351efcde260')

pkgver() {
	cd "${pkgbase%-git}"
	# cutting off 'BRLTTY.' prefix that presents in the git tag
	git describe --long | sed 's/^BRLTTY.//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

prepare() {
	cd "${pkgbase%-git}"
	patch -Np1 -i ../"${pkgname%-git}-6.2-systemd_sysusers_groups.patch"
	patch -Np1 -i ../"${pkgname%-git}-6.4-x11_autostart.patch"
	patch -Np1 -i ../"${pkgname%-git}-6.8-lock-brltty-user.patch"
	./autogen
}

build() {
	# fat-lto-objects is required for non-mangled static libs
	CFLAGS+=" -ffat-lto-objects"
	cd "${pkgbase%-git}"
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
	          --mandir=/usr/share/man --libexecdir=/usr/lib/brltty \
	          --with-scripts-directory=/usr/lib/brltty \
	          --with-tables-directory=/usr/share/brltty \
	          --with-writable-directory=/run/brltty \
	          --enable-gpm \
	          --disable-stripping
	make
	# make brlapi.jar deterministic
	find . -type f -iname "*.jar" -exec strip-nondeterminism {} \;
}

package_brltty-git() {
	depends=(bluez-libs gcc-libs glibc liblouis libspeechd libasound.so
	         libdbus-1.so libexpat.so libgio-2.0.so libglib-2.0.so libgobject-2.0.so
	         libicuuc.so libgpm.so libncursesw.so libsystemd.so pcre2 polkit)
	optdepends=(
	            'at-spi2-core: X11/GNOME Apps accessibility'
	            'brltty-udev-generic: for initializing brltty with generic USB devices'
	            'espeak-ng: espeak-ng driver'
	            'java-runtime: Java support'
	            'libxaw: X11 support'
	            'libxt: X11 support'
	            'libx11: for xbrlapi'
	            'libxfixes: for xbrlapi'
	            'libxtst: for xbrlapi'
	            'ocaml: OCaml support'
	            'python: Python support'
	            'speech-dispatcher: speech-dispatcher driver'
	            'tcl: tcl support'
	)
	provides=(brltty libbrlapi.so)
	conflicts=(brltty)
	backup=(
	        etc/brltty.conf
	        etc/X11/xinit/xinitrc.d/90xbrlapi
	)
	install=brltty-git.install

	cd ${pkgbase%-git}
	make INSTALL_ROOT="$pkgdir" install
	make INSTALL_ROOT="$pkgdir" install-systemd
	make INSTALL_ROOT="$pkgdir" install-udev
	make INSTALL_ROOT="$pkgdir" install-dracut
	make INSTALL_ROOT="$pkgdir" install-polkit
	install -vDm 644 Documents/${pkgbase%-git}.conf -t "$pkgdir/etc/"

	# fix directory permission and ownership
	install -vdm 750 -o root -g 102 "$pkgdir/usr/share/polkit-1/rules.d"

	# move generic udev rule, as it applies too broadly
	mv -v "$pkgdir/usr/lib/udev/rules.d/90-brltty-usb-generic.rules" ../
	install -vDm 644 ../brltty-6.8-udev-tty-perms.rules "$pkgdir/usr/lib/udev/rules.d/90-brltty-tty-perms.rules"
}

package_brltty-udev-generic-git() {
	pkgdesc="Generic udev rules for brltty (development version)"
	depends=(brltty)
	provides=(brltty-udev-generic)
	conflicts=(brltty-udev-generic)

	install -vDm 644 90-brltty-usb-generic.rules -t "$pkgdir/usr/lib/udev/rules.d/"
}
