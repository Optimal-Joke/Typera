//
//  WordFetchRequest.swift
//  Typera
//
//  Created by Hunter Holland on 1/5/22.
//

import Foundation

public protocol WordFetchRequest: Hashable {
    var word: String { get }
    var url: URL { get }
    var urlRequest: URLRequest { get }
    
    init(word: String)
    
    var result: Word? { get set }
    
    func execute()
}

extension WordFetchRequest {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(word)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.word == rhs.word
    }
}

// MARK: OED
public struct OEDWordFetchRequest: WordFetchRequest {
    public let word: String
    public var result: Word? = nil
    
    public init(word: String) {
        self.word = word
    }
    
    public var url: URL {
        let word_id = self.word.lowercased()
        let fields = "etymologies"
        let strictMatch = "false"
        
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(OxfordEnglishDictionary.language.code)/\(word_id)?fields=\(fields)&strictMatch=\(strictMatch)")!
        
        return url
    }
    
    public var urlRequest: URLRequest {
        var request = URLRequest(url: self.url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(OxfordEnglishDictionary.appId, forHTTPHeaderField: "app_id")
        request.addValue(OxfordEnglishDictionary.appKey, forHTTPHeaderField: "app_key")
        
        return request
    }
    
    public func execute() {
        URLSession.shared.dataTask(with: self.urlRequest) { data, response, error in
            if response != nil {
                let data = data
                if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    debugPrint(jsonData)
                } else {
                    debugPrint(error!)
                    debugPrint(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!)
                }
            }
        }.resume()
    }
}

// MARK: MW
public struct MWWordFetchRequest: WordFetchRequest {
    public let word: String
    public var result: Word? = nil
    
    public init(word: String) {
        self.word = word
    }
    
    public var url: URL {
        let word_id = word.lowercased()
        
        let url = URL(string: "https://www.dictionaryapi.com/api/v3/references/collegiate/json/\(word_id)?key=\(MerriamWebster.apiKey)")!
        
        return url
    }
    
    public var urlRequest: URLRequest {
        URLRequest(url: url)
    }
    
    public func execute() {
        URLSession.shared.dataTask(with: self.urlRequest) { data, response, error in
            if response != nil {
                let data = data
                if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    print(jsonData)
                } else {
                    print(error!)
                    print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!)
                }
            }
        }.resume()
    }
}

//extension WordFetchRequest where Self == {
//
//}
