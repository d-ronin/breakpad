import qbs
import qbs.FileInfo

Project {
    name: "breakpad"
    property string version: "0.1"
    minimumQbsVersion: "1.6"

    qbsSearchPaths: "src/build"

    property stringList commonIncludePaths: [sourceDirectory + "/src"]
    property stringList commonDefines: []

    references: [
        "src/client/client.qbs",
        "src/common/common.qbs",
        "src/processor/processor.qbs",
        "src/third_party/libdisasm/libdisasm.qbs",
        "src/tools/tools.qbs",
    ]

    Product {
        name: "docs"

        Group {
            name: "docs"
            files: [
                "AUTHORS",
                "ChangeLog",
                "INSTALL",
                "LICENSE",
                "NEWS",
                "README.md",
            ]
            qbs.install: true
            qbs.installDir: "share/doc/"+project.name+"-"+project.version
        }
    }

    Product {
        name: "breakpad_headers"

        Group {
            name: "breakpad_headers_common"
            files: [
                "src/google_breakpad/common/*.h",
            ]
            qbs.install: true
            qbs.installDir: "include/breakpad/google_breakpad/common"
        }
    }
}
