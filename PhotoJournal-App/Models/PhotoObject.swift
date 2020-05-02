//
//  PhotoObject.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation

struct PhotoObject: Codable, Equatable {
    var imageData: Data
    let date = Date()
    let identifier = UUID().uuidString
    
    var convertedDate: String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    var photoComment: String
}
