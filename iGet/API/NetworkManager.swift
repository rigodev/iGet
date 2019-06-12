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
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []), let jsonResults = json as? [[String: String]] else {
            print("Error processing entertainments: failed to convert data to JSON")
            return nil
        }
        
        var entertainments = [Entertainment]()
        
        for item in jsonResults {
            guard let stringId = item[Entertainment.Mapping.id], let id = Int(stringId),
                let name = item[Entertainment.Mapping.name] else { continue }
            
            entertainments.append(Entertainment(id: id, name: name))
        }
        return entertainments
    }
    
    private func getEntertainmentListURL() -> URL? {
        let URLString = "http://megakohz.bget.ru/test.php"
        return URL(string: URLString)
    }
}

// MARK: - fetching details of Entertainment
extension NetworkManager {
    
    func fetchEntertainmentDetails(forEntertainmentId id: Int, completion: @escaping (DetailedEntertainment?) -> Void) {
        
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
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []), let jsonResults = json as? [[String: String]] else {
            print("Error processing entertainment: failed to convert data to JSON")
            return nil
        }
        
        var detailedEntertainments = [DetailedEntertainment]()
        
        for item in jsonResults {
            guard let stringId = item[DetailedEntertainment.Mapping.id], let id = Int(stringId),
                let name = item[DetailedEntertainment.Mapping.name],
                let descr = item[DetailedEntertainment.Mapping.description] else { continue }
            
            detailedEntertainments.append(DetailedEntertainment(id: id, name: name, description: descr))
        }
        
        if detailedEntertainments.count > 1 {
            print("Warning processing entertainment: JSON contains more 1 result")
        }
        
        return detailedEntertainments.first
    }
    
    private func getEntertainmentDetailsURL(forEntertainmentId id: Int) -> URL? {
        
        guard let stringId = String(id).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        
        let URLString = "http://megakohz.bget.ru/test.php?id=\(stringId)"
        
        return URL(string: URLString)
    }
}
