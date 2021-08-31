//
//  Language.swift
//  Typera
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation

struct Language {
    var code: String
    init?(code: String) {
        if code.hasPrefix("en-") {
            self.code = code
        } else {
            print("Sorry, only English variants are supported." )
            return nil
        }
    }
}
