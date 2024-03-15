DESCRIPTION = "Custom NTP configuration file with new servers"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append() {
    install -m 0644 ${WORKDIR}/ntp.conf ${D}${sysconfdir}/ntp.conf
}
