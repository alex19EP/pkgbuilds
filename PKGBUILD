# Maintainer: Alexander Epaneshnikov <aarnaarn2@gmail.com>

pkgname=arch-man-bot-git
pkgver=r10.e0d2e00
pkgrel=1
pkgdesc="Telegram bot for in-line search of man-pages"
arch=('any')
url="https://t.me/archmanbot"
license=('GPL3')
depends=('python-pytelegrambotapi')
makedepends=('git')
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
install=${pkgname%-git}.install
source=("${pkgname%-git}::git+https://github.com/alcortazzo/arch-man-bot.git"
        "systemd-credential-pass.patch"
        "${pkgname%-git}.service")
sha512sums=('SKIP'
            '83ff997c5417672d33729d42e4a7db542c02f86632e657253ff6c54bb0190fa420f69a57b8992770853be7c822be842ebe32c8cacb2993ebc46160eed85a1c92'
            '33c98561c766ca7cbe524b148e04e17061b3966ed99e991e5178958149adc817d2d83a62d87b673343fd972da81d5e5aaf900b747eaef4c1e808d782584294a9')

pkgver() {
	cd "${pkgname%-git}"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
	cd "${pkgname%-git}"
	patch -p1 -i "$srcdir/systemd-credential-pass.patch"
}

package() {
	cd "${pkgname%-git}"
	install -vDm 775 "main.py" "${pkgdir}/usr/bin/${pkgname%-git}"
	install -vDm 644 "../${pkgname%-git}.service" -t "${pkgdir}/usr/lib/systemd/system"
}
