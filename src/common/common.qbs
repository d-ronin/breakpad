import qbs

BreakpadProduct {
    type: ["staticlibrary"]
    name: "common"
    installVariants: []

    files: commonSource

    Group {
        name: "Common Headers"
        files: "*.h"
        qbs.install: true
        qbs.installDir: "include/breakpad/common"
    }

    Group {
        name: "Linux Headers"
        files: "linux/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/common/linux"
    }
    Group {
        name: "Mac Headers"
        files: "mac/*.h"
        condition: qbs.targetOS.contains("macos")
        qbs.install: true
        qbs.installDir: "include/breakpad/common/mac"
    }
    Group {
        name: "Windows Headers"
        files: "windows/*.h"
        condition: qbs.targetOS.contains("windows")
        qbs.install: true
        qbs.installDir: "include/breakpad/common/windows"
    }
}
