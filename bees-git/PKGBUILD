# Maintainer: Ivan Shapovalov <intelfx@intelfx.name>
# Contributor: Sven-Hendrik Haase <svenstaro@gmail.com>
# Contributor: Gavin Yancey <gyancey@hmc.edu>
# Contributor: Timofey Titovets <nefelim4ag@gmail.com>

pkgname=bees-git
pkgver=0.11.r19.gf9f3913
pkgrel=1
pkgdesc="Best-Effort Extent-Same, a btrfs deduplicator daemon"
arch=('x86_64')
url="https://github.com/Zygo/bees"
license=('GPL-3.0-only')
depends=('util-linux-libs' 'bash')
makedepends=('git' 'discount' 'btrfs-progs' 'systemd')
provides=('bees')
conflicts=('bees')
source=('git+https://github.com/zygo/bees.git#branch=master')
sha256sums=('SKIP')

pkgver() {
  cd bees

  git describe --long --tag | sed 's/^v//;s/[^-]*-g/r&/;s/-/./g'
}

build() {
  cd bees

  export CXXFLAGS="$CXXFLAGS -Wno-error=restrict -Wno-error=maybe-uninitialized"
  export CFLAGS="$CFLAGS -Wno-error=restrict -Wno-error=maybe-uninitialized"
  make BEES_VERSION="${pkgver}" all scripts
}

check() {
  cd bees

  make BEES_VERSION="${pkgver}" test
}

package() {
  cd bees

  make BEES_VERSION="${pkgver}" DESTDIR="${pkgdir}" install
  mv "${pkgdir}/usr/sbin" "${pkgdir}/usr/bin"
}
