//
//  ContentView.swift
//  ColorBrite
//
//  Created by Aiello Giovanni on 21/05/2020.
//  Copyright © 2020 ColorBriteTeam. All rights reserved.
//

import SwiftUI
import GameKit
import UIKit

struct ContentView: View {
    
    @EnvironmentObject var player : AudioPlayer
    
  
    
    var body: some View {
        
        VStack {
            
            MainView()
            
            
        }
        
        .onAppear() {
            GameKitHelper.sharedInstance.authenticateLocalPlayer() }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}










// Messages sent using the Notification Center to trigger
// Game Center's Popup screen
public enum PopupControllerMessage : String
{
    case PresentAuthentication = "PresentAuthenticationViewController"
    case GameCenter = "GameCenterViewController"
}

extension PopupControllerMessage
{
    public func postNotification() {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: self.rawValue),
            object: self)
    }
    
    public func addHandlerForNotification(_ observer: Any,
                                          handler: Selector) {
        NotificationCenter.default .
            addObserver(observer, selector: handler, name:
                NSNotification.Name(rawValue: self.rawValue), object: nil)
    }
    
}

// based on code from raywenderlich.com
// helper class to make interacting with the Game Center easier

open class GameKitHelper: NSObject,  ObservableObject,  GKGameCenterControllerDelegate  {
    public var authenticationViewController: UIViewController?
    public var lastError: Error?
    
    @EnvironmentObject var time : Time
    
    private static let _singleton = GameKitHelper()
    
    public class var sharedInstance: GameKitHelper {
        return GameKitHelper._singleton
    }
    
    private override init() {
        super.init()
    }
    @Published public var enabled :Bool = false
    
    public var  gameCenterEnabled : Bool {
        return GKLocalPlayer.local.isAuthenticated
        
    }
    
    public func authenticateLocalPlayer () {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) in
            
            self.lastError = error as NSError?
            self.enabled = GKLocalPlayer.local.isAuthenticated
            if viewController != nil {

                self.authenticationViewController = viewController
                PopupControllerMessage
                    .PresentAuthentication
                    .postNotification()
            }
        }
    }
    
    public var gameCenterViewController : GKGameCenterViewController? { get {
        
        guard gameCenterEnabled else {
            print("Local player is not authenticated")
            return nil }
        
        let gameCenterViewController = GKGameCenterViewController()
        
        gameCenterViewController.gameCenterDelegate = self
        
        gameCenterViewController.viewState = .leaderboards
        
        
        return gameCenterViewController
        }
        
    }
    
    open func gameCenterViewControllerDidFinish(_
        gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismiss(
            animated: true, completion: nil)
    }
    
    
    
}



