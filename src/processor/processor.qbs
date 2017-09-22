import qbs 1.0

Project {
    name: "processor"

    property stringList commonFiles: [
        "basic_code_modules.cc",
        "basic_source_line_resolver.cc",
        "call_stack.cc",
        "cfi_frame_info.cc",
        "dump_context.cc",
        "dump_object.cc",
        "logging.cc",
        "pathname_stripper.cc",
        "process_state.cc",
        "simple_symbol_supplier.cc",
        "source_line_resolver_base.cc",
        "stack_frame_symbolizer.cc",
        "stackwalk_common.cc",
        "stackwalker.cc",
        "stackwalker_amd64.cc",
        "stackwalker_arm.cc",
        "stackwalker_arm64.cc",
        "stackwalker_mips.cc",
        "stackwalker_ppc.cc",
        "stackwalker_ppc64.cc",
        "stackwalker_sparc.cc",
        "stackwalker_x86.cc",
        "tokenize.cc",
    ]

    property stringList commonIncludePaths: ['../']

    BreakpadProduct {
        type: ["application"]
        name: "minidump_stackwalk"

        Depends { name: "libdisasm" }

        files: commonFiles.concat([
            "disassembler_x86.cc",
            "exploitability.cc",
            "exploitability_linux.cc",
            "exploitability_win.cc",
            "minidump.cc",
            "minidump_processor.cc",
            "minidump_stackwalk.cc",
            "proc_maps_linux.cc",
            "symbolic_constants_win.cc",
        ])
    }

    BreakpadProduct {
        type: ["application"]

        files: commonFiles.concat([
            "microdump.cc",
            "microdump_processor.cc",
            "microdump_stackwalk.cc",
        ])
    }

    BreakpadProduct {
        type: ["application"]
        name: "minidump_dump"

        // upstream broke this on windows :( https://chromium-review.googlesource.com/c/breakpad/breakpad/+/457019
        condition: !qbs.targetOS.contains("windows")

        files: commonFiles.concat([
            "minidump.cc",
            "minidump_dump.cc",
            "proc_maps_linux.cc",
        ])
    }
}
