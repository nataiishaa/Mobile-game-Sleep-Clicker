//
//  IntExtension.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 30.03.2024.
//

import Foundation

extension Int
{
    public func dateToString(format: String) -> String
    {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
