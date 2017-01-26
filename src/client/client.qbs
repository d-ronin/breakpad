import qbs 1.0

BreakpadProduct {
    type: "staticlibrary"
    name: "breakpad_client"

    cpp.debugInformation: true

    Properties {
        condition: !qbs.targetOS.contains("windows")
        cpp.dynamicLibraries: 'pthread'
    }

    Group {
        files: commonSource
    }

    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: "lib"
    }

    Group {
        files: "linux/crash_generation/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/linux/crash_generation"
    }
    Group {
        files: "linux/dump_writer_common/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/linux/dump_writer_common"
    }
    Group {
        files: "linux/handler/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/linux/handler"
    }
    Group {
        files: "linux/minidump_writer/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/linux/minidump_writer"
    }
    Group {
        files: "linux/microdump_writer/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/linux/microdump_writer"
    }
    Group {
        files: "../third_party/lss/*.h"
        condition: qbs.targetOS.contains("linux")
        qbs.install: true
        qbs.installDir: "include/breakpad/third_party/lss"
    }

    Group {
        files: "mac/crash_generation/*.h"
        condition: qbs.targetOS.contains("macos")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/mac/crash_generation"
    }
    Group {
        files: "mac/handler/*.h"
        condition: qbs.targetOS.contains("macos")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/mac/handler"
    }

    Group {
        files: "windows/common/*.h"
        condition: qbs.targetOS.contains("windows")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/windows/common"
    }
    Group {
        files: "windows/crash_generation/*.h"
        condition: qbs.targetOS.contains("windows")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/windows/crash_generation"
    }
    Group {
        files: "windows/handler/*.h"
        condition: qbs.targetOS.contains("windows")
        qbs.install: true
        qbs.installDir: "include/breakpad/client/windows/handler"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        files: [
            "minidump_file_writer.cc",
            "linux/crash_generation/crash_generation_client.cc",
            "linux/crash_generation/crash_generation_server.cc",
            "linux/dump_writer_common/thread_info.cc",
            "linux/dump_writer_common/ucontext_reader.cc",
            "linux/handler/exception_handler.cc",
            "linux/handler/minidump_descriptor.cc",
            "linux/log/log.cc",
            "linux/microdump_writer/microdump_writer.cc",
            "linux/minidump_writer/linux_core_dumper.cc",
            "linux/minidump_writer/linux_dumper.cc",
            "linux/minidump_writer/linux_ptrace_dumper.cc",
            "linux/minidump_writer/minidump_writer.cc",
        ]
    }

    Group {
        condition: qbs.targetOS.contains("macos")
        files: [
            "minidump_file_writer.cc",
            "mac/crash_generation/crash_generation_client.cc",
            "mac/crash_generation/crash_generation_server.cc",
            "mac/handler/breakpad_nlist_64.cc",
            "mac/handler/dynamic_images.cc",
            "mac/handler/exception_handler.cc",
            "mac/handler/minidump_generator.cc",
            "mac/handler/protected_memory_allocator.cc",
        ]
    }

    Group {
        condition: qbs.targetOS.contains("windows")
        files: [
            "windows/crash_generation/client_info.cc",
            "windows/crash_generation/crash_generation_client.cc",
            "windows/crash_generation/crash_generation_server.cc",
            "windows/crash_generation/minidump_generator.cc",
            "windows/handler/exception_handler.cc",
            "windows/sender/crash_report_sender.cc",
        ]
    }
}
