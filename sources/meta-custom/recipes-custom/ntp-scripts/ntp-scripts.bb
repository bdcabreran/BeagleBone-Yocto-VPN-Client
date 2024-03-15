DESCRIPTION = "Custom NTP configuration and update script"
SECTION = "extras"
LICENSE = "CLOSED"

SRC_URI = "file://update-time.sh"


S = "${WORKDIR}"

do_install() {
    # Install the update-time script (/usr/bin = $bindir)
    install -d ${D}${bindir}
    install -m 0755 ${S}/update-time.sh ${D}${bindir}/update-time.sh
}

FILES_${PN} += "${bindir}/update-time.sh"



