//
//  Localization.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

public final class Localization {
    
    public static let preferedLocaleLanguage = Locale.preferredLanguages.first
    
    public class var currentLocale: Locale {
        if let identifier = preferedLocaleLanguage {
            let locale = Locale(identifier: identifier)
            return locale
        }
        return Locale.current
    }
    
    public class var language: String {
        if let preferedLanguage = preferedLocaleLanguage {
            return preferedLanguage
        }
        return Locale.current.languageCode ?? "en"
    }
    
    public class func text(_ str:String) -> String {
        return Bundle.main.localizedString(forKey: str, value: "", table: nil)
    }
}
