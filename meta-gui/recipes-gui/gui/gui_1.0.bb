SUMMARY = "QT Example Recipe"
LICENSE = "CLOSED"

SRC_URI = "file://SampleProject.pro \
           file://components.cpp \
           file://components.h \
           file://main.cpp \ 
           file://mainwindow.cpp \
           file://mainwindow.h \
           file://mainwindow.ui \
           file://window.cpp \
           file://window.h \
           file://file-reader.h \
           file://file-reader.cpp"

DEPENDS += "qtbase"

RDEPENDS_${PN} += "qtwayland"

FILES_${PN} += "${bindir}/SampleProject"


S = "${WORKDIR}"


do_install:append () {

    install -d ${D}${bindir}
    install -m 0755 SampleProject ${D}${bindir}/	

}



inherit qmake5
