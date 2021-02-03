//
//  EventsData.swift
//  Assessment
//
//  Created by HaroldDavidson on 1/29/21.
//

import Foundation

struct EventsData: Decodable {
    let events: [Events]
}

struct Events: Decodable {
    let id: Int
    let short_title: String
    let datetime_local: String
    let venue: Venue
    let performers: [Performers]
}

struct Venue: Decodable {
    let display_location: String
}

struct Performers: Decodable {
    let image: String
}
