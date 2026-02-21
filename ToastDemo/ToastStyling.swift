//
//  ToastStyling.swift
//  ToastDemo
//
//  Created by Raushan, Rakesh Kumar on 21/02/26.
//

// ToastDemo/ToastStyling.swift
import Foundation
import ToastKit

class AppToastStyle: ToastStyleProvider {
    
    func backgroundColor(for type: ToastType) -> ToastColor {
        switch type {
        case .success:
            return ToastColor.green
        case .error:
            return ToastColor.red
        case .warning:
            return ToastColor.orange
        case .info:
            return ToastColor.blue
        }
    }
    
    func textColor(for type: ToastType) -> ToastColor {
        return ToastColor.white
    }
    
    func iconName(for type: ToastType) -> String? {
        switch type {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
}
