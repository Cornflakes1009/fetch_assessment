//
//  Storage.swift
//  Assessment
//
//  Created by HaroldDavidson on 1/31/21.
//

import Foundation

let defaults     =   UserDefaults.standard
var favorites    =   defaults.object(forKey: "favorites") as? [Int] ?? [Int]()

