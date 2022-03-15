//
//  TimerView.swift
//  ColorBrite
//
//  Created by Aiello Giovanni on 21/05/2020.
//  Copyright © 2020 ColorBriteTeam. All rights reserved.
//



import Foundation
import SwiftUI


struct TimerView: View {
    
    @EnvironmentObject var time : Time
    
    @State var temp : CGFloat = 1.0
    
    var body : some View {
        
        ZStack {
            Circle()
                .trim(from: 0.0, to: self.time.circleValue)
                .stroke(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)), lineWidth: 10)
            
            Text("\(self.time.score)")
                .bold()
                .font(.title)
                .foregroundColor(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                .animation(nil)
        
        }
        .frame(width: 150, height: 150, alignment: .center)
        .animation(.easeIn)
        .padding(20)
        
    }
    
    
    
}




