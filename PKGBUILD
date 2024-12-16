# Maintainer: Alexander Epaneshnikov <alex19ep@archlinux.org>
# Maintainer: schan <mail@schan.cc>
# Contributor: Adrian Sampson <adrian@radbox.org>
# Contributor: Johannes Löthberg <demizide@gmail.com>

pkgname=beets-git
pkgver=2.2.0.r25.g9110a1110
pkgrel=1
pkgdesc="Flexible music library manager and tagger - git version"
arch=('any')
url="https://beets.io/"
license=('MIT')
depends=(
  python
  python-confuse
  python-jellyfish
  python-mediafile
  python-munkres
  python-musicbrainzngs
  python-platformdirs
  python-unidecode
  python-yaml
)
makedepends=(
  git
  python-build
  python-installer
  python-poetry-core
  python-sphinx
  python-wheel
)
checkdepends=(
  bash-completion
  imagemagick
  python-beautifulsoup4
  python-discogs-client
  python-flask
  python-librosa
  python-mpd2
  python-numba
  python-py7zr
  python-pylast
  python-pytest
  python-reflink
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
  'python-librosa: AutoBPM plugin'
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
  cd beets
  git describe --long --tags | sed -r 's/^v//;s/([^-]*-g)/r\1/;s/-/./g'
}

build() {
  cd beets
  make -C docs man
  python -m build --wheel --no-isolation
}

check() {
  cd beets
  pytest \
    --override-ini="addopts=" \
    --ignore test/plugins/test_player.py \
    --ignore test/plugins/test_autobpm.py \
    --ignore test/plugins/test_aura.py \
    --deselect test/test_ui.py::CompletionTest::test_completion \
    --deselect test/test_importer.py::ImportDuplicateAlbumTest::test_merge_duplicate_album \
    --deselect test/test_ui.py::ConfigTest::test_cli_config_paths_resolve_relative_to_user_dir
}

package() {
  cd beets
  python -m installer --destdir="$pkgdir" dist/*.whl
  install -Dm 644 extra/_beet -t "${pkgdir}"/usr/share/zsh/site-functions/
  install -Dm 644 docs/_build/man/beet.1 -t "${pkgdir}"/usr/share/man/man1/
  install -Dm 644 docs/_build/man/beetsconfig.5 -t "${pkgdir}"/usr/share/man/man5/
  install -Dm 644 LICENSE -t "${pkgdir}"/usr/share/licenses/beets/
}
