# Maintainer: Alexander Epaneshnikov <alex19ep@archlinux.org>
# Maintainer: schan <mail@schan.cc>
# Contributor: Adrian Sampson <adrian@radbox.org>
# Contributor: Johannes Löthberg <demizide@gmail.com>

pkgname=beets-git
pkgver=2.0.0.r32.g0966e3c65
pkgrel=2
pkgdesc="Flexible music library manager and tagger - git version"
arch=('any')
url="https://beets.io/"
license=('MIT')
depends=(
  python-confuse
  python-jellyfish
  python-mediafile
  python-munkres
  python-musicbrainzngs
  python-reflink
  python-setuptools
  python-six
  python-unidecode
  python-yaml
)
makedepends=(
  git
  python-sphinx
)
checkdepends=(
  bash-completion
  imagemagick
  python-beautifulsoup4
  python-discogs-client
  python-flask
  python-mpd2
  python-pytest
  python-pytest-cov
  python-pytest-flask
  python-pylast
  python-requests-oauthlib
  python-responses
  python-xdg
)
optdepends=(
  'bash-completion: Bash completion'
  'chromaprint: Chromaprint/Acoustid plugin'
  'ffmpeg: Convert, ReplayGain plugins'
  'gst-plugins-bad: Chromaprint/Acoustid, BPD, ReplayGain plugins'
  'gst-plugins-good: Chromaprint/Acoustid, BPD, ReplayGain plugins'
  'gst-plugins-ugly: Chromaprint/Acoustid, BPD, ReplayGain plugins'
  'gst-libav: Chromaprint/Acoustid, BPD, ReplayGain plugins'
  'gst-python: Chromaprint/Acoustid, BPD, ReplayGain plugins'
  'imagemagick: Thumbnails plugin'
  'python-beautifulsoup4: Lyrics plugin'
  'python-discogs-client: Discogs plugin'
  'python-flask: Web plugin'
  'python-gobject: ReplayGain plugin'
  'python-mpd2: MPDStats plugin'
  'python-pyacoustid: Chromaprint/Acoustid plugin'
  'python-pylast: LastGenre plugin'
  'python-requests: Chromaprint/Acoustid, BPD, FetchArt plugins'
  'python-requests-oauthlib: Beatport plugin'
  'python-xdg: Thumbnails plugin'
)
provides=("beets=$pkgver")
conflicts=('beets')
source=('git+https://github.com/beetbox/beets.git')
md5sums=('SKIP')

pkgver() {
  cd ${srcdir}/beets
  git describe --long --tags | sed -r 's/^v//;s/([^-]*-g)/r\1/;s/-/./g'
}

build() {
  cd ${srcdir}/beets
  python -m build --no-isolation
}

check() {
  cd ${srcdir}/beets
  python -m pytest 
}

package() {
  cd ${srcdir}/beets
  python -m installer --destdir="$pkgdir" dist/*.whl
  install -Dm 644 extra/_beet -t "${pkgdir}"/usr/share/zsh/site-functions/
  install -Dm 644 man/beet.1 -t "${pkgdir}"/usr/share/man/man1/
  install -Dm 644 man/beetsconfig.5 -t "${pkgdir}"/usr/share/man/man5/
  install -Dm 644 LICENSE -t "${pkgdir}"/usr/share/licenses/beets-git/
}
