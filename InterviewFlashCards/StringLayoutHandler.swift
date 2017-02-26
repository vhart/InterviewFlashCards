import UIKit
import Foundation

struct StringLayoutHandler {

    enum SerializationTokens: String {
        case tab = "T"
        case newline = "N"

        var token: String { return "#" + rawValue }
    }

    enum TabLength: Int {
        case short = 2
        case regular = 4

        func padding() -> String {
            return "".padding(toLength: rawValue, withPad: " ", startingAt: 0)
        }
    }

    private var tabLength: TabLength
    private var font: UIFont

    init(tabLength: TabLength, font: UIFont) {
        self.tabLength = tabLength
        self.font = font
    }

    func deserializedString(input: String) -> String {
        var formatted = input
        formatted = formatted.replacingOccurrences(of: SerializationTokens.tab.token,
                                                   with: tabLength.padding())
        formatted = formatted.replacingOccurrences(of: SerializationTokens.newline.token,
                                                   with: "\n")
        return formatted
    }

    func applyFont(to input: NSAttributedString) -> NSAttributedString {
        let attributes = [NSFontAttributeName: font]
        let styledString = NSMutableAttributedString(attributedString: input)
        styledString.beginEditing()
        let fullRange = NSMakeRange(0, styledString.length)
        styledString.removeAttribute(NSFontAttributeName, range: fullRange)
        styledString.addAttributes(attributes, range: fullRange)
        styledString.endEditing()
        return styledString
    }
}
