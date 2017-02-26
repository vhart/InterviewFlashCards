//
//  Theme.swift
//  SyntaxKit
//
//  Represents a TextMate theme file (.tmTheme). Currently only supports the
//  foreground text color attribute on a local scope.
//
//  Created by Sam Soffes on 10/11/14.
//  Copyright © 2014-2015 Sam Soffes. All rights reserved.
//

#if !os(OSX)
    import UIKit
#else
    import AppKit
#endif

public typealias Attributes = [String: AnyObject]

public struct Theme {

    // MARK: - Properties

    public let uuid: UUID
    public let name: String
    public let attributes: [String: Attributes]

    public var backgroundColor: Color {
        return attributes[Language.globalScope]?[NSBackgroundColorAttributeName] as? Color ?? Color.white
    }

    public var foregroundColor: Color {
        return attributes[Language.globalScope]?[NSForegroundColorAttributeName] as? Color ?? Color.black
    }


    // MARK: - Initializers

    init?(dictionary: [String: Any]) {
        guard let uuidString = dictionary["uuid"] as? String,
            let uuid = UUID(uuidString: uuidString),
            let name = dictionary["name"] as? String,
            let rawSettings = dictionary["settings"] as? [[String: AnyObject]]
            else { return nil }

        self.uuid = uuid
        self.name = name

        var attributes = [String: Attributes]()
        for raw in rawSettings {
            guard var setting = raw["settings"] as? [String: AnyObject] else { continue }

            if let value = setting.removeValue(forKey: "foreground") as? String {
                setting[NSForegroundColorAttributeName] = Color(hex: value)
            }

            if let value = setting.removeValue(forKey: "background") as? String {
                setting[NSBackgroundColorAttributeName] = Color(hex: value)
            }

            // TODO: caret, invisibles, lightHighlight, selection, font style

            if let patternIdentifiers = raw["scope"] as? String {
                for patternIdentifier in patternIdentifiers.components(separatedBy: ",") {
                    let key = patternIdentifier.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    attributes[key] = setting
                }
            } else if !setting.isEmpty {
                attributes[Language.globalScope] = setting
            }
        }
        self.attributes = attributes
    }
}
