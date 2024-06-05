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

PROG=zfs-tools
VER=1.0.0
PKG="sysdef/util/zfs-tools"
SUMMARY="ZFS utilities"
DESC="Tools to work with ZFS filesystems"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

set_mirror https://github.com
set_checksum sha256 ba9769e5120a7baf590be4cd03c1bf7710dfb8a2a700fc0a762ea42b25a8e4d5
set_builddir ZFS-tools-1.0.0

# create package functions
init
download_source snltd/ZFS-tools/archive/refs/tags ${VER}
# test
# strip_install
logcmd mkdir -p ${DESTDIR}/${PREFIX}
logcmd rsync -a ${TMPDIR}/${BUILDDIR}/ "${DESTDIR}${PREFIX}"
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
