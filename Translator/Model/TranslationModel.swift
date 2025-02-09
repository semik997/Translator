//
//  TranslationModel.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import Foundation


class TranslationModel {
    
    // Translation examples
    static func getTranslatedText() -> String {
        let exampleText = ["Hello", "What are you doing human?",
                           "I'm hungry!!!",
                           "I',m don'n understand you",
                           "I missed you so much, but I don't understand what you're saying, please repeat it.",
                           "Will you continue watching for a long time?"]
        return exampleText.randomElement() ?? "Something went wrong..."
    }
}
