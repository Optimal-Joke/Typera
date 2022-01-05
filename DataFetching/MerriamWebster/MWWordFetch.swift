//
//  MWWordFetch.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import Foundation
import DequeModule

struct MWWordFetcher: WordFetcher {
    typealias Request = MWWordFetchRequest
    
    init() { }
    
    var queue: Deque<Request> = []
    var seen: Set<Request> = []

}
