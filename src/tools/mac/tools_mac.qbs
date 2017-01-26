import qbs

Project {
    name: "tools_mac"
    condition: qbs.targetOS.contains("macos")

    /* TODO: needs processor lib
    BreakpadProduct {
        type: ["application"]
        name: "crash_report"

        Depends { name: "processor_lib" }
        Depends { name: "breakpad_client" }

        cpp.frameworks: ["Foundation"]

        files: [
            "crash_report/crash_report.mm",
            "crash_report/on_demand_symbol_supplier.mm",
        ]
    }*/

    BreakpadProduct {
        type: ["application"]
        name: "dump_syms"

        Depends { name: "common" }

        files: "dump_syms/dump_syms_tool.cc"
    }

    BreakpadProduct {
        type: ["application"]
        name: "macho_dump"

        Depends { name: "common" }

        files: "dump_syms/macho_dump.cc"
    }

    BreakpadProduct {
        type: ["application"]
        name: "minidump_upload"

        Depends { name: "breakpad_client" }

        cpp.frameworks: ["Foundation"]

        files: [
            "../../common/mac/HTTPMultipartUpload.m",
            "symupload/minidump_upload.m"
        ]
    }

    BreakpadProduct {
        type: ["application"]
        name: "sym_upload"

        Depends { name: "breakpad_client" }

        cpp.frameworks: ["Foundation"]

        files: [
            "../../common/mac/HTTPMultipartUpload.m",
            "symupload/symupload.m"
        ]
    }
}
