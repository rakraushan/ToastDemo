//
//  ToastObserver.swift
//  ToastDemo
//
//  Created by Raushan, Rakesh Kumar on 21/02/26.
//

// ToastDemo/ToastObserver.swift
import Foundation
import ToastKit

class AppToastObserver: ToastEventObserver {
    
    // Callback to update UI
    var onToastUpdate: (() -> Void)?
    
    func toastDidShow(_ toast: Toast) {
        print("📱 App received: Toast shown - \(toast.message)")
        onToastUpdate?()
    }
    
    func toastDidDismiss(_ toast: Toast) {
        print("📱 App received: Toast dismissed - \(toast.message)")
        onToastUpdate?()
    }
    
    func toastDidTap(_ toast: Toast) {
        print("📱 App received: Toast tapped - \(toast.message)")
        // Could navigate, show details, etc.
        onToastUpdate?()
    }
}
