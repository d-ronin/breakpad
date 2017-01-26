import qbs

Project {
    name: "tools_windows"
    condition: qbs.targetOS.contains("windows")

    BreakpadProduct {
        type: ["application"]
        name: "dump_syms"
        Depends { name: "common" }

        files: "dump_syms/dump_syms.cc"
    }

    BreakpadProduct {
        type: ["application"]
        name: "sym_upload"

        Depends { name: "breakpad_client" }

        files: "symupload/symupload.cc"
    }

    BreakpadProduct {
        type: ["staticlibrary"]
        name: "ms_symbol_server_converter"

        files: commonSource.concat(["converter/ms_symbol_server_converter.cc"])
    }
}
