import qbs

Project {
    name: "tools_linux"
    condition: qbs.targetOS.contains("linux")

    BreakpadProduct {
        type: ["application"]
        name: "core2md"

        Depends { name: "breakpad_client" }

        files: "core2md/core2md.cc"
    }

    BreakpadProduct {
        type: ["application"]
        name: "dump_syms"

        Depends { name: "common" }

        files: "dump_syms/dump_syms.cc"
    }

    BreakpadProduct {
        type: ["application"]
        name: "dump_syms_mac"

        Depends { name: "common" }

        files: [
            "../mac/dump_syms/dump_syms_tool.cc",
            "../../common/mac/arch_utilities.cc",
            "../../common/mac/dump_syms.cc",
            "../../common/mac/file_id.cc",
            "../../common/mac/macho_id.cc",
            "../../common/mac/macho_reader.cc",
            "../../common/mac/macho_utilities.cc",
            "../../common/mac/macho_walker.cc",
        ]
    }

    BreakpadProduct {
        type: ["application"]
        name: "minidump-2-core"

        Depends { name: "common" }

        files: "md2core/minidump-2-core.cc"

        Group {
            fileTagsFilter: product.type
            qbs.install: true
            qbs.installDir: "bin"
        }
    }

    BreakpadProduct {
        type: ["application"]
        name: "minidump_upload"

        Depends { name: "breakpad_client" }

        cpp.dynamicLibraries: 'dl'

        files: "symupload/minidump_upload.cc"
    }

    BreakpadProduct {
        type: ["application"]
        name: "sym_upload"

        Depends { name: "breakpad_client" }

        cpp.dynamicLibraries: 'dl'

        files: "symupload/sym_upload.cc"
    }
}
