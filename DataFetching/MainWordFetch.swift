//
//  MainWordFetch.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

// MARK: - Word
public protocol Word {
    var headword: String { get }
}

// MARK: OED
public struct OEDWord: Word {
    public var headword: String
}

// MARK: MW
public struct MWWord: Word {
    public var headword: String
}

//Word("wonder", using: .OxfordEnglishDictionary)
//Word("wonder", using: .MerriamWebster)
