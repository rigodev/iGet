//
//  NetworkManager.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let instance = NetworkManager()
    
    private init() {}
}

// MARK: - fetching list of Entertainments
extension NetworkManager {
    func fetchEntertainmentList(completion: @escaping ([Entertainment]?) -> Void) {
        
        guard let entertainmentsURL = getEntertainmentListURL() else { return }
        
        let requestURL = URLRequest(url: entertainmentsURL)
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { [weak self] (data, response, error) in
            
            guard let self = self, let result = self.processEntertainmentListResponse(withData: data, withError: error) else { return }
            
            completion(result)
        }
        
        dataTask.resume()
    }
    
    private func processEntertainmentListResponse(withData data: Data?, withError error: Error?) -> [Entertainment]? {
        
        if let error = error {
            print("Error fetching entertainments: \(error.localizedDescription)")
            return nil
        }
        
        guard let data = data else {
            print("Error processing entertainments: data is nil")
            return nil
        }
        
        guard let entertainments = try? JSONDecoder().decode([Entertainment].self, from: data) else {
            print("Error processing entertainments: failed to convert data via JSONDecoder")
            return nil
        }
        
        return entertainments
    }
    
    private func getEntertainmentListURL() -> URL? {
        let URLString = "http://megakohz.bget.ru/test.php"
        return URL(string: URLString)
    }
}

struct Str: Decodable {
    let id: String
    let namedd: String
}

// MARK: - fetching details of Entertainment
extension NetworkManager {
    
    func fetchEntertainmentDetails(forEntertainmentId id: String, completion: @escaping (DetailedEntertainment?) -> Void) {
        
        guard let entertainmentURL = getEntertainmentDetailsURL(forEntertainmentId: id) else { return }
        
        let requestURL = URLRequest(url: entertainmentURL)
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { [weak self] (data, response, error) in
            
            guard let self = self, let result = self.processEntertainmentDetailsResponse(withData: data, withError: error) else { return }
            
            completion(result)
        }
        
        dataTask.resume()
    }
    
    private func processEntertainmentDetailsResponse(withData data: Data?, withError error: Error?) -> DetailedEntertainment? {
        
        if let error = error {
            print("Error fetching entertainment: \(error.localizedDescription)")
            return nil
        }
        
        guard let data = data else {
            print("Error processing entertainment: data is nil")
            return nil
        }
        
        guard let detailedIntertainments = try? JSONDecoder().decode([DetailedEntertainment].self, from: data) else {
            print("Error processing entertainment: failed to convert data via JSONDecoder")
            return nil
        }
        
        switch detailedIntertainments.count {
            
        case 0:
            print("Warning processing entertainment: empty results")
            return nil
            
        case 2...:
            print("Warning processing entertainment: more than 1 result")
            fallthrough
            
        case 1:
            return detailedIntertainments.first
            
        default:
            return nil
        }
    }
    
    private func getEntertainmentDetailsURL(forEntertainmentId id: String) -> URL? {
        
        guard let id = id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        
        let URLString = "http://megakohz.bget.ru/test.php?id=\(id)"
        
        return URL(string: URLString)
    }
}
