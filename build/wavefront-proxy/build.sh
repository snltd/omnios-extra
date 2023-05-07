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

PROG=wavefront-proxy
VER=12.4
PKG=sysdef/wavefront-proxy
SUMMARY="Wavefront proxy server"
DESC="Resilient metric collection for Wavfront SaaS"
BUILD_DEPENDS_IPS="developer/java/openjdk8 apache-maven"
RUN_DEPENDS_IPS="developer/java/openjdk8"

set_arch 64
set_mirror https://github.com
set_checksum sha256 6b620581b6053fcac89bf878546c8dc7de4f45def790326f8e0e04c8388bf1e1
set_builddir wavefront-proxy-proxy-12.4

XFORM_ARGS="-DPREFIX=${PREFIX#/} -DPROG=$PROG"

build_jar() {
    cd ${TMPDIR}/${BUILDDIR}
    logcmd mvn -f proxy clean verify -DskipTests -DskipFormatCode \
        || logerr "maven build failed"
}

build_target() {
    logcmd mkdir -p $DESTDIR${PREFIX}/lib $DESTDIR/etc/${PREFIX}/wavefront-proxy
    logcmd cp ${TMPDIR}/${BUILDDIR}/proxy/target/proxy-12.4-spring-boot.jar \
              $DESTDIR${PREFIX}/lib/wavefront-proxy.jar \
                || logerr "failed to copy jar"
    logcmd cp ${SRCDIR}/files/log4j2.xml $DESTDIR/etc/${PREFIX}/wavefront-proxy
}

init
download_source wavefrontHQ/${PROG}/archive/refs/tags proxy-${VER}
patch_source
build_jar
build_target
install_smf application ${PROG}.xml application-${PROG}
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
