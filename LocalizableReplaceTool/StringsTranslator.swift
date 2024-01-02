//
//  StringsTranslator.swift
//  LocalReplaceTool
//
//  Created by  on 2024/1/2.
//

import Foundation

class StringsTranslator {
    /// Reads and translates the content of the file at `aStringsPath` using translations from `bStringsPath`.
    func translate(aStringsPath: String, bStringsPath: String, outputPath: String) {
        do {
            // Load the contents of both files
            let aStringsDict = NSDictionary(contentsOf: URL(fileURLWithPath: aStringsPath)) as! [String: String]

            let bStringsDict = NSDictionary(contentsOf: URL(fileURLWithPath: bStringsPath)) as! [String: String]
            
            // Create a new dictionary to hold the translated pairs
            var translatedDict = [String: String]()
            
            // Translate each value in aStringsDict using bStringsDict
            for (key, value) in aStringsDict {
                if let translatedValue = bStringsDict[value] {
                    translatedDict[key] = translatedValue
                } else {
                    translatedDict[key] = value // 找不到 保留原值
                }
            }
            
            // Create the output content
            let outputContent = translatedDict.map { "\"\($0.key)\" = \"\($0.value)\";" }.joined(separator: "\n")
            /// 下面的方法中文会显示Unicode
//            let outputContent = (translatedDict as NSDictionary).descriptionInStringsFileFormat
            
            // Write the translated content to the output file
            try outputContent.write(toFile: outputPath, atomically: true, encoding: .utf16)
        } catch {
            print("An error occurred: \(error)")
        }
    }

}




