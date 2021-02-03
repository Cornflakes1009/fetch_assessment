//
//  EventsManager.swift
//  Assessment
//
//  Created by HaroldDavidson on 1/29/21.
//

import UIKit

var events = [Events]()

struct EventsManager {
    let seatGeekUrl = "https://api.seatgeek.com/2/events?client_id=MjE1MjA0NTN8MTYxMTg4NjQ2My4yMzY4NDcy&q="
    
    func fetchEvents(for term: String) {
        let urlString = seatGeekUrl + term
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(eventsData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func setImage(url: String, imageView: UIImageView) {
        let url: URL = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if data != nil {
                let image = UIImage(data: data!)
                if image != nil {
                    DispatchQueue.main.async(execute: {
                        imageView.image = image
                    })
                }
            }
        })
        task.resume()
    }
    
    func parseJSON(eventsData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(EventsData.self, from: eventsData)
            
            events.removeAll()
            
            for event in decodedData.events {
                events.append(event)
            }
            
            print("EVENTS: \(events.count)")
        } catch {
            print(error)
        }
        
    }
}
