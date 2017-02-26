protocol TmType {
    var extensionType: String { get }
    var fileName: String { get }
}

enum TmTheme: String, TmType {
    case tomorrowBright = "Tomorrow-Night-Bright"
    case tomorrow = "Tomorrow"

    var extensionType: String { return "tmTheme" }
    var fileName: String { return self.rawValue }
}

enum TmLanguage: String, TmType {
    case swift = "Swift"

    var extensionType: String { return "tmLanguage" }
    var fileName: String { return self.rawValue }
}
