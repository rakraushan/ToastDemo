//
//  ToastConfiguration.swift
//  ToastDemo
//
//  Created by Raushan, Rakesh Kumar on 21/02/26.
//

// ToastDemo/ToastConfiguration.swift
import Foundation
import ToastKit

class AppToastConfiguration: ToastConfigurationProvider {
    
    var maxConcurrentToasts: Int {
        return 3  // Show max 3 toasts at once
    }
    
    var defaultDuration: TimeInterval {
        return 3.0  // 3 seconds default
    }
    
    var allowStacking: Bool {
        return true  // Allow multiple toasts
    }
}
