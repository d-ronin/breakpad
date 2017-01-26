import qbs 1.0

Project {
    name: "tools"

    references: [
        "linux/tools_linux.qbs",
        "mac/tools_mac.qbs",
        "windows/tools_windows.qbs",
    ]
}
