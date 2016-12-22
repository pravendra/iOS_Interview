//
//  ViewController.swift
//  ios-interview
//
//  Copyright © 2016 Headspace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Actions
    

    @IBAction func login(_ sender: UIButton) {
        // Send login event to Google Analytics and Snowplow.

        // User data model for saving user data after login.
        let userData = UserDataModel("HSUSER_234234","", "blue")
        
        // Login event
        AnalyticsManager.sharedInstance.sendEvent(Login.success.description(), userData)
    }

    @IBAction func completeMeditation(_ sender: UIButton) {
        // Send meditation completion event to Google Analytics
        
        // Meditation data model for saving data after completion.
        let meditationData = UserDataModel("HSUSER_234234", "HSSESSION_123111","")
        
        // Meditation completion event
        AnalyticsManager.sharedInstance.sendEvent(Meditation.completed.description(), meditationData)
    }
}
