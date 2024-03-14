DESCRIPTION = "Installs network setup script for BBB"
SUMMARY = "Install network setup script and ensure it runs at boot"
LICENSE = "CLOSED"

SRC_URI = "file://setup_network.sh"

S = "${WORKDIR}"


do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${S}/setup_network.sh ${D}${sysconfdir}/init.d/setup_network.sh

    # Manually create symbolic links for startup and shutdown
    # Assuming default runlevel 5 for startup, adjust if necessary
    install -d ${D}${sysconfdir}/rc5.d
    ln -s ../init.d/setup_network.sh ${D}${sysconfdir}/rc5.d/S99setup_network.sh

    # For stopping the service, though your script doesn't specifically handle 'stop' gracefully
    install -d ${D}${sysconfdir}/rc0.d
    ln -s ../init.d/setup_network.sh ${D}${sysconfdir}/rc0.d/K99setup_network.sh
}

FILES_${PN} += "${sysconfdir}/init.d"
