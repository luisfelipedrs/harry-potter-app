//
//  Endpoint.swift
//  HarryPotterApp
//
//  Created by Luis Felipe on 21/12/22.
//

import Foundation

public enum Endpoint {
    case characters
    
    var type: String {
        switch self {
        case .characters:
            return "characters"
        }
    }
}
