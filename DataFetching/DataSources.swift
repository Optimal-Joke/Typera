//
//  DataSources.swift
//  Typera
//
//  Created by Hunter Holland on 5/7/21.
//

import Foundation

enum DataSource {
    case OxfordEnglishDictionary
    case MerriamWebster
}

struct OxfordEnglishDictionary {
    static let appId = "1d601103"
    static let appKey = "03e4244664f4116e9705f8f9f4082d02"
    static let language = Language(code: "en-gb")
    static let usage = DataSourceUsage.secondary
}

struct MerriamWebster {
    static let apiKey = "28a08a51-c4e0-420e-b65a-5e1e91ad5a77"
    static let usage = DataSourceUsage.primary
}

enum DataSourceUsage {
    case primary
    case secondary
}
