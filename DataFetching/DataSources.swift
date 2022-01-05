//
//  DataSources.swift
//  Typera
//
//  Created by Hunter Holland on 5/7/21.
//

public enum DataSourceUsagePriority {
    case primary
    case secondary
}

public protocol DataSourceProtocol {
    static var usagePriority: DataSourceUsagePriority { get }
}

struct OxfordEnglishDictionary: DataSourceProtocol {
    static let usagePriority: DataSourceUsagePriority = .secondary
    
    static let appId = "1d601103"
    static let appKey = "03e4244664f4116e9705f8f9f4082d02"
    static let language = Language(code: "en-gb")
}

struct MerriamWebster: DataSourceProtocol  {
    static let usagePriority: DataSourceUsagePriority = .primary
    
    static let apiKey = "28a08a51-c4e0-420e-b65a-5e1e91ad5a77"
}
