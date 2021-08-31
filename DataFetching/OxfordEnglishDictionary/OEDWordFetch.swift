//
//  WordFetch.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import Foundation

class OEDWordFetcher: WordFetcher {
    
    var word: String
    
    var dataSource: DataSource = .OxfordEnglishDictionary
    
    let appId: String = OxfordEnglishDictionary.appId
    let appKey: String = OxfordEnglishDictionary.appKey
    let language: String = OxfordEnglishDictionary.language?.code ?? ""
    
    required init(_ word: String, fetchData: Bool = true) {
        self.word = word
        
        if fetchData {
            self.fetchData()
        }
    }
    
    func fetchData() {
        let url = self.createURL(word: self.word)
        let request = self.createURLRequest(from: url)
        self.executeURLSession(from: request)
    }
}

extension OEDWordFetcher {
        
    func createURL(word: String) -> URL {
        let word_id = word.lowercased()
        let fields = "etymologies"
        let strictMatch = "false"
        
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(self.language)/\(word_id)?fields=\(fields)&strictMatch=\(strictMatch)")!
        
        return url
    }
    
    func createURLRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(self.appId, forHTTPHeaderField: "app_id")
        request.addValue(self.appKey, forHTTPHeaderField: "app_key")
        
        return request
    }
    
    func executeURLSession(from request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
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
