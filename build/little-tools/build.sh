#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}

# Copyright 2023 Sysdef Ltd

. ../../lib/build.sh

PROG=little_tools
VER=1.0.0
PKG=sysdef/util/little_tools
SUMMARY="Little command-line tools"
DESC="Useful little command-line tools"
BUILD_DEPENDS_IPS=ooce/developer/rust
SKIP_RTIME_CHECK=1

set_arch 64
set_mirror https://github.com
set_checksum sha256 ac5b654ae8e50c554bd9710533f8e47c4ba1293ffc64b01fb7720938ca8aee44
set_ssp none

init
download_source snltd/${PROG}/archive/refs/tags $VER
pushd $TMPDIR/$BUILDDIR >/dev/null
logcmd $CARGO install --path=. --bins --root ${DESTDIR}$PREFIX \
    || logerr "build failed"
popd >/dev/null
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
