//
//  Loaction.swift
//  Bucketlist
//
//  Created by Areej Hussein on 27/12/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Buckingham palace", description: "Where the Queen lives", latitude: 51.501, longitude: -0.141)
}
