//
//  UserDataModel.swift
//  ios-interview
//
//  Created by Praven on 12/21/16.
//  Copyright © 2016 Headspace. All rights reserved.
//

import UIKit

/* User Data Model*/
class UserDataModel: BaseDataModel {
    
    // private variables
    fileprivate (set) var userId: String?
    fileprivate (set) var meditationSessionId: String?
    fileprivate (set) var buttonColor: String?
    
    // Designated initializer for Login and Meditation data
    init(_ userId: String,_ meditationSessionId: String,_ buttonColor: String) {
        self.userId = userId
        self.meditationSessionId = meditationSessionId
        self.buttonColor = buttonColor
    }
}
