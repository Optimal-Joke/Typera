//
//  WordFetch.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import Foundation
import DequeModule

struct OEDWordFetcher: WordFetcher {
    typealias Request = OEDWordFetchRequest
    
    init() { }
    
    var queue: Deque<Request> = []
    var seen: Set<Request> = []
    
}
