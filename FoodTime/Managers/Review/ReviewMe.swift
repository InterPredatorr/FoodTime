//
//  ReviewMe.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 01.10.23.
//

import UIKit
import StoreKit

class ReviewMe {
    
    
    let launchCountUserDefaultsKey = "launchCount"
        
    func isReviewViewToBeDisplayed(minimumLaunchCount:Int) -> Bool {
        
        let launchCount = UserDefaults.standard.integer(forKey: launchCountUserDefaultsKey)
        if launchCount >= minimumLaunchCount {
            return true
        } else {
            UserDefaults.standard.set((launchCount + 1), forKey: launchCountUserDefaultsKey)
        }
        print(launchCount)
        
        return false
    }
        
    func showReviewView(afterMinimumLaunchCount:Int){
        if(self.isReviewViewToBeDisplayed(minimumLaunchCount: afterMinimumLaunchCount)){
            SKStoreReviewController.requestReview()
        }
    }
}
