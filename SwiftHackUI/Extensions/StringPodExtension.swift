//
//  StringPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension String {
    
    var localized: String {
        return Localization.text(self)
    }
    
    var onlyNumbers: String {
        let number = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return number
    }
    
    var firsttwo: String {
        return String(self.prefix(2))
    }
    
    var lastTwo: String {
        return String(self.suffix(2))
    }

    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    func alt(_ str:String) -> String {
        return self == "" ? str : self
    }
    
    func stringByRemovingCharacterSet(_ charSet:CharacterSet, withString:String = "") -> String {
        return self.components(separatedBy: charSet).joined(separator: withString)
    }
    
    mutating func replaceString(_ string:String, withString:String)
    {
        if let range = self.range(of: string) {
            self.replaceSubrange(range, with: withString)
        }
        //self = stringByReplacingOccurrencesOfString(string, withString: withString, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
    }
    
    var double: Double? {
        let set = CharacterSet(charactersIn: "0123456789.").inverted
        let stringArray = self.components(separatedBy: set)
        let newString = stringArray.joined(separator: "")
        if let value = Double(newString) {
            return value.roundToPlaces(2)
        }
        let numberFormatter: NumberFormatter = {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            nf.minimumFractionDigits = 0
            nf.maximumFractionDigits = 2
            return nf
        }()
        return numberFormatter.number(from: newString)?.doubleValue
    }
    
    func substring(toIndex:Int) -> String {
        if self.count <= toIndex {
            return ""
        }
        return (self as NSString).substring(to: toIndex)
    }

    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int, length: Int) -> String {
        let start = index(startIndex, offsetBy: i)
        let end = index(start, offsetBy: length)
        return String(self[start ..< end])
    }
    
    func substring(fromIndex: Int) -> String {
        let start = index(startIndex, offsetBy: fromIndex)
        return String(self[start...])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(start, offsetBy: r.upperBound - r.lowerBound)
        return String(self[start ..< end])
    }
    
    var urlEncoded:String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    var length:Int {
        return count
    }
    
    func index(of string: String, options: CompareOptions = .literal) -> Int? {
        if let index = range(of: string, options: options)?.lowerBound {
            return distance(from: startIndex, to: index)
        }
    
        return nil
    }
    
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
    
    func isBackspace() -> Bool {
        return strcmp(self.cString(using: String.Encoding.utf8)!, "\\b") == -92
    }
    
    func isAlphaNumeric() -> Bool {
        let alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return self.rangeOfCharacter(from: CharacterSet(charactersIn: alpha).inverted) == nil
    }
    
    func isAlphaNumericCharacterSet() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
    }
    
    func stringWithRange(_ range:NSRange, replaceString string:String) -> String {
        guard range.location != NSNotFound && range.length <= self.length - range.location else {
            return self     // 2018-09-10, deeje: not at all sure what to return if the range is invalid… self.length > 0 ? self : string
        }
        return (self as NSString).replacingCharacters(in: range, with: string)
    }
    
    func deletePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool {
        return self.range(of: find, options: NSString.CompareOptions.caseInsensitive) != nil
    }
    
    func PadLeft(_ totalWidth: Int,byString:String) -> String {
        let toPad = totalWidth - self.count
        if toPad < 1 {
            return self
        }
        return "".padding(toLength: toPad, withPad: byString, startingAt: 0) + self;
    }
    
    func rangeFromNSRange(_ nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex)
        let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.length, limitedBy: utf16.endIndex)
        
        if let from16 = from16, let from = String.Index(from16, within: self),
            let to16 = to16, let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }

    func inserted(_ stringToInsert: String, index: Int) -> String {
        let charsAfterIndex = self.length - index
        if charsAfterIndex < 0 {
            return String(self)
        }
        return String(self.prefix(index)) + stringToInsert + String(self.suffix(charsAfterIndex))
    }
    
    func contains(string: String) -> Bool{
        return self.range(of: string) != nil
    }
    
    func truncate(_ index: Int) -> String {
        return length <= index ? self : substring(toIndex: index)
    }
    
    func first(length: Int, suffix: String = "…") -> String {
      return self.count > length ? self.prefix(length) + suffix : self
    }
    
    func last(length: Int, prefix: String = "…") -> String {
      return self.count > length ? prefix + self.suffix(length) : self
    }
    
    var anyObject: AnyObject {
        return self as AnyObject
    }

    var base64: String? {
        return self.data(using: String.Encoding.utf8)?.base64EncodedString()
    }
}
