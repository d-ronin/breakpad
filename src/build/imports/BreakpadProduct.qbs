import qbs
import qbs.FileInfo

Product {
    Depends { name: "cpp" }

    property bool consoleApplication: true
    property bool installable: true

    cpp.cxxLanguageVersion: "c++11"
    cpp.minimumMacosVersion: "10.9"

    Properties {
        condition: qbs.targetOS.contains("linux")
        property pathList includePaths: project.commonIncludePaths.concat([project.sourceDirectory + "/src/third_party/mac_headers"])
        cpp.defines: project.commonDefines.concat(["HAVE_A_OUT_H", "HAVE_MACH_O_NLIST_H"])
    }
    Properties {
        condition: qbs.targetOS.contains("macos")
        property pathList includePaths: project.commonIncludePaths.concat([project.sourceDirectory + "/src/common/mac"])
        cpp.defines: project.commonDefines.concat(["HAVE_MACH_O_NLIST_H"])
    }
    Properties {
        property string diaSdk: FileInfo.path(cpp.compilerPath) + "/../../DIA SDK"
        condition: qbs.targetOS.contains("windows") && qbs.toolchain.contains("msvc")
        property pathList includePaths: project.commonIncludePaths.concat([diaSdk + "/include"])
        cpp.defines: project.commonDefines
        cpp.libraryPaths: [diaSdk + "/lib"]
        // TODO: move this to where it's needed only
        cpp.staticLibraries: ["diaguids.lib", "imagehlp.lib", "mincore.lib", "wininet.lib"]
    }
    cpp.defines: project.commonDefines

    cpp.includePaths: includePaths

    property pathList commonSource: {
        var files = [
            "convert_UTF.c",
            "md5.cc",
            "module.cc",
            "simple_string_dictionary.cc",
            "string_conversion.cc",
            "test_assembler.cc",
        ];
        
        if (qbs.targetOS.contains("linux") || qbs.targetOS.contains("macos")) {
            files = files.concat([
                "dwarf_cfi_to_module.cc",
                "dwarf_cu_to_module.cc",
                "dwarf_line_to_module.cc",
                "language.cc",
                "stabs_reader.cc",
                "stabs_to_module.cc",
                "dwarf/bytereader.cc",
                "dwarf/elf_reader.cc",
                "dwarf/dwarf2reader.cc",
                "dwarf/cfi_assembler.cc",
                "dwarf/dwarf2diehandler.cc",
                "dwarf/functioninfo.cc",
            ]);
        }

        if (qbs.targetOS.contains("linux")) {
            files = files.concat([
                "linux/crc32.cc",
                "linux/dump_symbols.cc",
                "linux/elf_core_dump.cc",
                "linux/elf_symbols_to_module.cc",
                "linux/elfutils.cc",
                "linux/file_id.cc",
                "linux/google_crashdump_uploader.cc",
                "linux/guid_creator.cc",
                "linux/http_upload.cc",
                "linux/libcurl_wrapper.cc",
                "linux/linux_libc_support.cc",
                "linux/memory_mapped_file.cc",
                "linux/safe_readlink.cc",
                "linux/symbol_upload.cc",
                "linux/synth_elf.cc",
            ]);
        }

        if (qbs.targetOS.contains("macos")) {
            files = files.concat([
                "mac/MachIPC.mm",
                "mac/arch_utilities.cc",
                "mac/bootstrap_compat.cc",
                "mac/dump_syms.cc",
                "mac/file_id.cc",
                "mac/macho_id.cc",
                "mac/macho_reader.cc",
                "mac/macho_utilities.cc",
                "mac/macho_walker.cc",
                "mac/string_utilities.cc",
            ]);
        }

        if (qbs.targetOS.contains("windows")) {
            files = files.concat([
                "windows/dia_util.cc",
                "windows/guid_string.cc",
                "windows/http_upload.cc",
                "windows/omap.cc",
                "windows/pdb_source_line_writer.cc",
                "windows/string_utils.cc",
            ]);
        }

        for (var index = 0; index < files.length; index++)
            files[index] = project.sourceDirectory + "/src/common/" + files[index]

        return files;
    }

    Group {
        condition: installable
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: product.type.contains("application") ? "bin" : "lib"
    }
}
