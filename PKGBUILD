# Maintainer: Alexander Epaneshnikov <alex19ep@archlinux.org>

pkgname=linode-cli-git
pkgver=5.31.0.r4.g6d73d04
pkgrel=1
pkgdesc="The Linode Command Line Interface (development version)"
arch=('any')
url="https://github.com/linode/linode-cli"
license=('BSD')
depends=('python-terminaltables' 'python-requests' 'python-yaml' 'python-setuptools')
makedepends=('git' 'python-build' 'python-installer' 'python-wheel')
optdepends=('python-boto: for obj plugin')
provides=(${pkgname%-git})
conflicts=(${pkgname%-git})
source=(${pkgname%-git}::'git+https://github.com/linode/linode-cli.git'
        ${pkgname%-git}-openapi.yaml::'https://www.linode.com/docs/api/openapi.yaml')
sha256sums=('SKIP'
            'SKIP')

pkgver() {
	cd "${pkgname%-git}"
	git describe --long --tags | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

build() {
	cd "${pkgname%-git}"
	python -m linodecli bake ../${pkgname%-git}-openapi.yaml --skip-config
	cp data-3 linodecli/
	python -m build --wheel --skip-dependency-check --no-isolation
}

package() {
	cd "${pkgname%-git}"
	python -m installer --destdir="${pkgdir}" dist/*.whl
	install -vDm0644 LICENSE -t "${pkgdir}/usr/share/licenses/${pkgname}"
	install -vDm0644 linode-cli.sh "${pkgdir}/usr/share/bash-completion/completions/linode-cli"
	rm -rv "${pkgdir}/usr/lib/python3.10/site-packages/etc/"
}
