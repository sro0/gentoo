# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GIT_TAG="5293ada82e1ea38e9e5cdd3724c73204d703f07b"

DESCRIPTION="Library of common routines intended to be shared"
HOMEPAGE="https://www.gnu.org/software/gnulib"
SRC_URI="https://git.savannah.gnu.org/cgit/${PN}.git/snapshot/${PN}-${GIT_TAG}.tar.xz"

LICENSE="GPL-3+ LGPL-2.1+ FDL-1.3+"
SLOT="0"
KEYWORDS="~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

S="${WORKDIR}/${PN}-${GIT_TAG}"

src_compile() {
	if use doc; then
		emake -C doc info html
	fi
}

src_install() {
	dodoc README ChangeLog

	insinto /usr/share/${PN}
	doins -r build-aux
	doins -r doc
	doins -r lib
	doins -r m4
	doins -r modules
	doins -r tests
	doins -r top

	# install the real script
	exeinto /usr/share/${PN}
	doexe gnulib-tool

	# create and install the wrapper
	dosym ../share/${PN}/gnulib-tool /usr/bin/gnulib-tool
}
