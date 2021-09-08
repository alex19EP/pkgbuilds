# Maintainer: Alexander Epaneshnikov <alex19ep@archlinux.org>

pkgname=arch-man-bot-git
pkgver=r13.939579c
pkgrel=1
pkgdesc="Telegram bot for in-line search of man-pages"
arch=('any')
url="https://t.me/archmanbot"
license=('GPL3')
depends=('python-aiogram' 'python-requests')
makedepends=('git')
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
install=${pkgname%-git}.install
source=("${pkgname%-git}::git+https://github.com/alcortazzo/arch-man-bot.git"
        "${pkgname%-git}.service")
sha512sums=('SKIP'
            '33c98561c766ca7cbe524b148e04e17061b3966ed99e991e5178958149adc817d2d83a62d87b673343fd972da81d5e5aaf900b747eaef4c1e808d782584294a9')

pkgver() {
	cd "${pkgname%-git}"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
	cd "${pkgname%-git}"
	install -vDm 775 "main.py" "${pkgdir}/usr/bin/${pkgname%-git}"
	install -vDm 644 "../${pkgname%-git}.service" -t "${pkgdir}/usr/lib/systemd/system"
}
