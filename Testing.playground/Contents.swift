import Foundation

//protocol DataSource {
//    var appId: String? { get }
//    var appKey: String? { get }
//    var language: String? { get }
//
//    var apiKey: String? { get }
//}
//
//struct OxfordEnglishDictionary: DataSource {
//    let appId: String? = "1d601103"
//    let appKey: String? = "03e4244664f4116e9705f8f9f4082d02"
//    let language: String? = "en-gb"
//
//    var apiKey: String? = nil
//}
//
//struct MerriamWebster: DataSource {
//    let appId: String? = nil
//    let appKey: String? = nil
//    let language: String? = nil
//
//    let apiKey: String? = "28a08a51-c4e0-420e-b65a-5e1e91ad5a77"
//}
//
//protocol WordFetcher {
//
//    var word: String { get set }
//    var dataSource: DataSource { get set }
//
//    init(_ word: String, fetchData: Bool)
//
//    func fetchData()
//    func createURL(word: String) -> URL
//    func createURLRequest(url: URL) -> URLRequest
//    func executeURLSession(request: URLRequest)
//
//}
//
//class OEDWordFetcher: WordFetcher {
//
//    var word: String
//
//    var dataSource: DataSource = OxfordEnglishDictionary()
//
//    let appId: String
//    let appKey: String
//    let language: String
//
//    required init(_ word: String, fetchData: Bool = true) {
//        self.word = word
//        self.appId = self.dataSource.appId!
//        self.appKey = self.dataSource.appKey!
//        self.language = self.dataSource.language!
//
//        if fetchData {
//            self.fetchData()
//        }
//    }
//
//    func fetchData() {
//        let url = self.createURL(word: self.word)
//        let request = self.createURLRequest(url: url)
//        self.executeURLSession(request: request)
//    }
//}
//
//extension OEDWordFetcher {
//
//    func createURL(word: String) -> URL {
//        let word_id = word.lowercased()
//        let fields = "etymologies"
//        let strictMatch = "false"
//
//        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(self.language)/\(word_id)?fields=\(fields)&strictMatch=\(strictMatch)")!
//
//        return url
//    }
//
//    func createURLRequest(url: URL) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue(self.appId, forHTTPHeaderField: "app_id")
//        request.addValue(self.appKey, forHTTPHeaderField: "app_key")
//
//        return request
//    }
//
//    func executeURLSession(request: URLRequest) {
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if response != nil {
//                let data = data
//                if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
//                    print(jsonData)
//                } else {
//                    print(error!)
//                    print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!)
//                }
//            }
//        }.resume()
//    }
//
//}
//
//struct Word<FetcherType: WordFetcher> {
//    var headword: String
//    var fetcher: FetcherType
//
//    init(_ word: String, using fetcher: FetcherType.Type, fetchData: Bool = true) {
//        self.headword = word
//        self.fetcher = FetcherType(word, fetchData: true)
//    }
//
//    init(_ word: String, using fetcher: FetcherType, fetchData: Bool = true) {
//        self.init(word, using: fetcher, fetchData: fetchData)
//    }
//
//}
//
//Word("wonder", using: OEDWordFetcher.self)

// __________________________________________

protocol WordFetcher {
    
    var word: String { get set }
    var dataSource: DataSource { get set }
    
    init(_ word: String, fetchData: Bool)
    
    func fetchData()
    func createURL(word: String) -> URL
    func createURLRequest(url: URL) -> URLRequest
    func executeURLSession(request: URLRequest)
    
}

class OEDWordFetcher: WordFetcher {
    
    var word: String
    
    var dataSource: DataSource = .OxfordEnglishDictionary
    
    let appId: String = OxfordEnglishDictionary.appId
    let appKey: String = OxfordEnglishDictionary.appKey
    let language: String = OxfordEnglishDictionary.language
    
    required init(_ word: String, fetchData: Bool = true) {
        self.word = word
        
        if fetchData {
            self.fetchData()
        }
    }
    
    func fetchData() {
        let url = self.createURL(word: self.word)
        let request = self.createURLRequest(url: url)
        self.executeURLSession(request: request)
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
    
    func createURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(self.appId, forHTTPHeaderField: "app_id")
        request.addValue(self.appKey, forHTTPHeaderField: "app_key")
        
        return request
    }
    
    func executeURLSession(request: URLRequest) {
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
        let request = self.createURLRequest(url: url)
        self.executeURLSession(request: request)
    }
    
}

extension MWWordFetcher {
    
    func createURL(word: String) -> URL {
        let word_id = word.lowercased()
        
        let url = URL(string: "https://www.dictionaryapi.com/api/v3/references/collegiate/json/\(word_id)?key=\(self.apiKey)")!
        
        return url
    }
    
    func createURLRequest(url: URL) -> URLRequest {
        URLRequest(url: url)
    }
    
    func executeURLSession(request: URLRequest) {
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

struct Word {
    var headword: String
    var source: DataSource
    
    init(_ word: String, using dataSource: DataSource, fetchData: Bool = true) {
        self.headword = word
        self.source = dataSource
        
        switch dataSource {
        case .OxfordEnglishDictionary:
            OEDWordFetcher(word, fetchData: fetchData)
        case .MerriamWebster:
            MWWordFetcher(word, fetchData: fetchData)
        }
    }
}

enum DataSourceUsage {
    case primary
    case secondary
}

enum DataSource {
    case OxfordEnglishDictionary
    case MerriamWebster
}

struct OxfordEnglishDictionary {
    static let appId = "1d601103"
    static let appKey = "03e4244664f4116e9705f8f9f4082d02"
    static let language = "en-gb"
    static let usage = DataSourceUsage.secondary
}

struct MerriamWebster {
    static let apiKey = "28a08a51-c4e0-420e-b65a-5e1e91ad5a77"
    static let usage = DataSourceUsage.primary
}

//let OxfordEnglishDictionary = (appId: "1d601103",
//                               appKey: "03e4244664f4116e9705f8f9f4082d02",
//                               language: "en-gb",
//                               apiKey: "",
//                               usage: DataSourceUsage.secondary)

//let MerriamWebster = (appId: "",
//                      appKey: "",
//                      language: "",
//                      apiKey: "28a08a51-c4e0-420e-b65a-5e1e91ad5a77",
//                      usage: DataSourceUsage.primary)


Word("wonder", using: .MerriamWebster)






