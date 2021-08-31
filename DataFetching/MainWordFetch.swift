//
//  MainWordFetch.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import Foundation

struct Word {
    var headword: String
    
    let source: DataSource
    let fetcher: WordFetcher
    
    init(_ word: String, using dataSource: DataSource, fetchData: Bool = true) {
        self.headword = word
        self.source = dataSource
        
        switch dataSource {
        case .OxfordEnglishDictionary:
            self.fetcher = OEDWordFetcher(word, fetchData: fetchData)
        case .MerriamWebster:
            self.fetcher = MWWordFetcher(word, fetchData: fetchData)
        }
    }
}

//Word("wonder", using: .OxfordEnglishDictionary)
//Word("wonder", using: .MerriamWebster)
