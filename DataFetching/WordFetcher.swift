//
//  WordFetcher.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import Foundation

protocol WordFetcher {
    
    var word: String { get set }
    var dataSource: DataSource { get set }
    
    init(_ word: String, fetchData: Bool)
    
    func fetchData()
    func createURL(word: String) -> URL
    func createURLRequest(from: URL) -> URLRequest
    func executeURLSession(from request: URLRequest)
    
}


