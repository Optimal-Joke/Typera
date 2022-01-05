//
//  WordFetcher.swift
//  Typera
//
//  Created by Hunter Holland on 5/6/21.
//

import DequeModule

public protocol WordFetcher {
    associatedtype Request: WordFetchRequest
    
    init()
    
    /// An ordered collection storing all words in a document, in order.
    var queue: Deque<Request> { get set }
    /// A set of all words in a document that have been analyzed.
    var seen: Set<Request> { get set }
    
}

// MARK: Adding and Fetching
extension WordFetcher {
    /// Wraps a word in a ``WordFetchRequest`` and adds it to the queue to be analyzed.
    public mutating func add(_ word: String) {
        let request = Self.Request(word: word)
        self.queue.append(request)
    }
    
    /// Checks if a word is present in the queue and, if so, fetches the data for it.
    public func fetch(word: String) {
        guard let wordRequest = self.queue.first(where: { $0.word == word }) else { return }
        wordRequest.execute()
    }
    
    /// Fetches the data for all words in the queue.
    mutating func fetchAll() {
        for request in self.queue {
            if !seen.contains(request) { request.execute() }
            seen.insert(request)
        }
    }
}

// MARK: Bookkeeping
extension WordFetcher {
    /// Removes all elements from the data collection queue, ``queue``.
    mutating func emptyQueue() {
        self.queue.removeAll()
    }
    
    /// Returns a Boolean value indicating whether the WordFetcher has enqueued the given word.
    func queueContains(_ word: String) -> Bool {
        self.queue.contains(where: { $0.word == word })
    }
    
    func reset() {
    
    }
}
