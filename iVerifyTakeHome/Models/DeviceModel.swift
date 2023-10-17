//
//  DeviceModel.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-16.
//

import Foundation

struct DeviceList: Codable {
    let devices: [Device]
}


struct Device : Codable, Identifiable {
    
    let id = UUID()
    let name: String
    let code: String
    let latestInsecureScanDate: String
    let device: String
    
    var formattedDate : Date {
        let dateFormatter = DateFormatter()
        // Set the input format of the date string
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: latestInsecureScanDate) {
            return date
        }
        return Date()
    }
    
}
