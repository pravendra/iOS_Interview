//
//  AnalyticsManager.swift
//  ios-interview
//
//  Created by Praven on 12/21/16.
//  Copyright © 2016 Headspace. All rights reserved.
//

import UIKit

open class AnalyticsManager: NSObject {
    
    static let sharedInstance = AnalyticsManager()

    func sendEvent(_ event:String?,_ data:BaseDataModel?) {
        guard data != nil else {
            return
        }
        
        if event == Login.success.description() || event == Login.failure.description() || event == Login.unknown.description() {
            setupAnalyticsData(event,[AnalyticsSDK.google, AnalyticsSDK.snowplow],data!)
        }else {
            setupAnalyticsData(event,[AnalyticsSDK.google],data!)
        }
    }

    fileprivate func setupAnalyticsData(_ eventName: String?,_ analyticsSDK:[AnalyticsSDK],_ analyticsData:BaseDataModel?) {
        
        guard analyticsData != nil else {
            return
        }
        
        let dataObject: [[String:AnalyticsData]]?
        if eventName == Login.success.description() {
            dataObject = setupAnalyticsLoginData(eventName, analyticsSDK, analyticsData)
            trackEvents(eventName, dataObject!)
        }else if eventName == Meditation.completed.description() {
            dataObject = setupMeditationData(eventName, analyticsData)
            trackEvents(eventName, dataObject!)
        }
        
    }
    
    fileprivate func setupAnalyticsLoginData(_ eventName: String?,_ analyticsSDK:[AnalyticsSDK],_ analyticsData:BaseDataModel?) -> [[String:AnalyticsData]]? {
        guard analyticsData != nil else {
            return nil
        }
        //var loginAnalyticData: AnalyticsData?
        var analyticsDictionary = [[String: AnalyticsData]]()
        let userData = analyticsData as! UserDataModel
        for sdk in analyticsSDK {
            if sdk.rawValue == AnalyticsSDK.google.rawValue {
                let loginGoogleAnalytic = AnalyticsData(eventName!, userData.userId, [kButtonColor: userData.buttonColor! as String])
                analyticsDictionary.append([kLoginEvent:loginGoogleAnalytic])
            }else if sdk.rawValue == AnalyticsSDK.snowplow.rawValue {
                let loginSnowplowAnalytic = AnalyticsData(eventName!,nil, [kUserId: userData.userId! as String])
                analyticsDictionary.append([kLog_inEvent:loginSnowplowAnalytic])
            }
        }
        return analyticsDictionary
    }
    
    fileprivate func setupMeditationData(_ eventName: String?,_ analyticsData:BaseDataModel?) -> [[String:AnalyticsData]]? {
        guard analyticsData != nil else {
            return nil
        }
        var analyticsDictionary = [[String: AnalyticsData]]()
        var meditationAnalyticData: AnalyticsData?
        let userData = analyticsData as! UserDataModel
        meditationAnalyticData = AnalyticsData(eventName!, userData.userId, [kMeditationSessionId: userData.meditationSessionId! as String])
        analyticsDictionary.append([kMeditation:meditationAnalyticData!])
        return analyticsDictionary
    }
}

extension AnalyticsManager {
    
    fileprivate func trackEvents(_ event:String? ,_ analyticsData: [[String:AnalyticsData]]?) {
        guard analyticsData != nil else {
            return
        }
        var dataObject: AnalyticsData?
        if event == Login.success.description() {
            for data in analyticsData! {
                if data[kLoginEvent] != nil {
                    dataObject = data[kLoginEvent]
                    GoogleAnalyticsSDK.sharedInstance.sendEvent(event!, forUser: (dataObject?.userId)!, withData: dataObject?.eventData as! [String : String])
                }else if data[kLog_inEvent] != nil {
                    dataObject = data[kLog_inEvent]
                    SnowplowSDK.sharedInstance.dispatchEvent(kLog_inEvent, withPayload:(dataObject?.eventData)!)
                }
            }
        }else if event == Meditation.completed.description() {
            for data in analyticsData! {
            dataObject = data[kMeditation]
            GoogleAnalyticsSDK.sharedInstance.sendEvent(event!, forUser: (dataObject?.userId)!, withData: dataObject?.eventData as! [String : String])
            }
        }
        
    }
}
