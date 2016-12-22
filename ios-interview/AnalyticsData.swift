//
//  AnalyticsData.swift
//  ios-interview
//
//  Created by Praven on 12/21/16.
//  Copyright © 2016 Headspace. All rights reserved.
//

import UIKit

// Login enum
enum Login {
    case success
    case failure
    case unknown
    
    func description() -> String {
        switch self {
        case .success,.failure,.unknown: return kLoginEvent
        }
    }
}

// Meditation enum
enum Meditation {
    case started
    case completed
    
    func description() -> String {
        switch self {
        case .started: return kMeditationStarted
        case .completed: return kMeditationCompleted
        }
    }
}

// sdk selection enum
enum AnalyticsSDK: String{
    case google
    case snowplow
}

open class AnalyticsData: NSObject {
    
    // private variables
    fileprivate (set) var event: String?
    fileprivate (set) var userId: String?
    fileprivate (set) var eventData: [String:Any]?
    
    // Designated initializer for event and event data
    init(_ event: String?,_ userId: String?,_ eventData: [String:Any]? = nil) {
        self.event = event
        self.userId = userId
        self.eventData = eventData
    }
}
