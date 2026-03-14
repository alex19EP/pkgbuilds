# Maintainer: Storm Dragon <storm_dragon@stormux.org>
# Contributor: Alexander Epaneshnikov <alex19ep@archlinux.org>
# Contributor: Steve Holmes <steve.holmes88@gmail.com>
# Contributor: Chris Brannon <cmbrannon79@gmail.com>

pkgname=emacspeak
pkgver=60.0
pkgrel=1
pkgdesc="Emacs extension that provides spoken output"
arch=('x86_64' 'aarch64')
url="http://emacspeak.sf.net/"
license=('GPL' 'LGPL' 'APACHE')
depends=('emacs' 'tcl' 'tclx' 'espeak-ng' 'sox')
optdepends=('python: for Stream The World'
            'perl')
source=("https://github.com/tvraman/emacspeak/releases/download/${pkgver}/emacspeak-${pkgver}.tar.bz2"
        "${pkgname}-60.0-directorys.patch"
        "${pkgname}-60.0-flags.patch"
        "${pkgname}.sh")
sha512sums=('f48040f2dfaf7cb67d779d219c59477aaddb9c8b400666e5e9d9850e75575d5276f5b596ab1e8976057e5078d914a610cd537068ccc748e6c45aef64b02eaba9'
            'b298f72d42eb4334054e8580dc488ac78f2a96f4728e1b6f646c6371a0846ca19a0f607fbaf73d37ed6502bf76d34a820f7e37fbd1047971514a3976dc88daba'
            '83343badf4adc9758d3d2d63303e64ebb054d461744d8d6603bcc55eaa040f64d9311d303a70cca1483fed38b9e1efc473d9bf4ddfaf62f9b2761b3e6b1a7076'
            '69456a0dd45b09469a6d345e5528b3eadef5fc4a379425153aa51a597d9faceef85036ca195eef86ae4c08485e38aeff3b64d88662fad4f5c4999117798537ec')

prepare() {
  cd "$pkgname-$pkgver"
  patch --forward --strip=1 --input="${srcdir}/${pkgname}-60.0-directorys.patch"
  patch --forward --strip=1 --input="${srcdir}/${pkgname}-60.0-flags.patch"
}

build() {
  cd "$pkgname-$pkgver"
  export DTK_PROGRAM="espeak"
  make config
  make
  make -C etc/pickup-c
  # Espeak isn't compiled by default, but lots of folks use it.
  make espeak
}

package() {
  cd "$pkgname-$pkgver"
  # clean unneeded files
  find . -name Makefile -delete
  rm -vr info/auto
  [ -d sounds/3d/src ] && rm -vr sounds/3d/src || true

  install -vDm 644 etc/forms/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/etc/forms"
  install -vDm 644 etc/pickup-c/pickup -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/etc/pickup-c"
  install -vDm 644 etc/tables/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/etc/tables"
  install -vDm 644 etc/ai/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/etc/ai"
  find etc/pipewire -type f -exec install -vDm 644 {} "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/{}" \;
  install -vDm 644 etc/pulse/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/etc/pulse"
  rm -vr etc/forms/
  rm -vr etc/pickup-c/
  rm -vr etc/tables/
  rm -vr etc/ai/
  rm -vr etc/pipewire/
  rm -vr etc/pulse/
  find etc/ -maxdepth 1 -type f -exec install -vDm 644 {} -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/etc" \;
  install -vDm 644 info/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/info"
  install -vDm 644 lisp/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/lisp"
  install -vDm 644 xsl/* -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/xsl"
  install -vDm 644 README -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}"

  [ -d sounds/prompts ] && install -vDm 644 sounds/prompts/* -t "${pkgdir}/usr/share/sounds/${pkgname}/prompts"
  find sounds/ -maxdepth 1 -type f -exec install -vDm 644 {} -t "${pkgdir}/usr/share/sounds/${pkgname}" \;

  # speech server
  install -vDm 644 servers/.servers -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/servers"
  install -vDm 755 servers/tts-lib.tcl -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/servers"
  install -vDm 755 servers/{espeak,log-espeak} -t "${pkgdir}/usr/share/emacs/site-lisp/${pkgname}/servers"
  install -vDm 755 servers/native-espeak/tclespeak.so -t "${pkgdir}/usr/lib/${pkgname}"
  # Add convenient wrapper to keep your configs unmodified
  install -vDm 755 "${srcdir}/emacspeak.sh" "${pkgdir}/usr/bin/${pkgname}"
}
