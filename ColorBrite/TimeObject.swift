//
//  TimeObject.swift
//  ColorBrite
//
//  Created by Aiello Giovanni on 22/05/2020.
//  Copyright © 2020 ColorBriteTeam. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Time: ObservableObject {
    
    @Published var circleValue : CGFloat = 1.0
    
    @Published var gameOver : Bool = false
    
    @Published var score : Int = 0
    
    @Published var enable = false
    
    init() {
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.circleValue -= 0.05
            if (self.circleValue <= -0.1) {
                self.gameOver = true
                
            }
            
        }
        
    }
    
}
