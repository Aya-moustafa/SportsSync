//
//  NetworkManager.swift
//  SportsSync
//
//  Created by Aya Mostafa on 14/05/2024.
//

import Foundation
import UIKit
import Reachability

class NetworkManager {
   static let shared = NetworkManager()
    private var reachability : Reachability!
    
    init() {
        self.reachability = try? Reachability()
    }
    
    
    func startMonitoring () {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    @objc func networkStatusChanged (_ notification: Notification) {
        let reachability = notification.object as! Reachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            print("Network reachable")
            DispatchQueue.main.async {
                // Fetch data when network is reachable
                NotificationCenter.default.post(name: .networkRestored, object: nil)
            }
        case .unavailable, .none:
            print("Network not reachable")
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
    }
    
    func showAlert() {
            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                topController.present(alert, animated: true, completion: nil)
            }
        }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
}
extension Notification.Name {
    static let networkRestored = Notification.Name("networkRestored")
}
