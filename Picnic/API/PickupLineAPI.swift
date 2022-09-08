//
//  PickupLineAPI.swift
//  Picnic
//
//  Created by Adam Trafecanty on 5/2/22.
//

import Foundation

let PICKUPLINE_LINK = "https://getpickuplines.herokuapp.com/lines/random"

enum APIError: Error {
    case unexpectedAPIError
}

func getPickupLine() async throws -> PickupLine {
    guard let url = URL(string: "https://getpickuplines.herokuapp.com/lines/random") else {
        fatalError("Should never happen, but just in case…URL didn’t work 😔")
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedLine = try? JSONDecoder().decode(PickupLine.self, from: data) {
        return decodedLine
    } else {
        throw APIError.unexpectedAPIError
    }
}

