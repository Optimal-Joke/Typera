//
//  MWWordFetch.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import Foundation

struct MWWordFetcher: WordFetcher {

    var word: String

    var dataSource: DataSource = .MerriamWebster

    let apiKey: String = MerriamWebster.apiKey
    
    init(_ word: String, fetchData: Bool = true) {
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

extension MWWordFetcher {
    
    func createURL(word: String) -> URL {
        let word_id = word.lowercased()
        
        let url = URL(string: "https://www.dictionaryapi.com/api/v3/references/collegiate/json/\(word_id)?key=\(self.apiKey)")!
        
        return url
    }
    
    func createURLRequest(from url: URL) -> URLRequest {
        URLRequest(url: url)
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
