//
//  MainView.swift
//  ColorBrite
//
//  Created by Aiello Giovanni on 23/05/2020.
//  Copyright © 2020 ColorBriteTeam. All rights reserved.
//

import Foundation
import SwiftUI



struct MainView : View {
    
    @EnvironmentObject var gameCenter : GameKitHelper
    
    
    @State private var isShowingGameCenter = false
        { didSet           {
            PopupControllerMessage
                .GameCenter
                .postNotification() } }
    
    var body: some View {
        
        NavigationView{
          
            
            VStack (alignment: .center){
                Image("Logo").resizable().aspectRatio(contentMode: .fit)
                    .padding(10)
                Spacer().frame(height: 170)
                CustomButton(text: "  Start  ",font: .title,padding: 24)
                 Spacer().frame(height: 20)
                VStack(spacing:15){
                InstructionsButton(text:" Instruction ",font: .none,padding: 15)
                if self.gameCenter.enabled
                {
                    Button(action:{ self.isShowingGameCenter.toggle()})
                    { Text(
                        "Leaderboard")
                        .bold()
                        .font(.none)
                        .padding(15)
                          .foregroundColor(.white)
                         .padding(.horizontal,15)
                        .background(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                        .border(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                        .cornerRadius(10)
                    
                    }
                }
                }
                Spacer().frame(height: 70)
            }
            
                
            .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
            .background(Color(#colorLiteral(red: 0.07363793999, green: 0.07853061706, blue: 0.08279185742, alpha: 1)).edgesIgnoringSafeArea(.all))
            
            
        }
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        .background(Color(#colorLiteral(red: 0.07363793999, green: 0.07853061706, blue: 0.08279185742, alpha: 1)).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        
    }
    
    
}


struct CustomButton : View {
    
    @EnvironmentObject var time : Time
    var text : String
    var font : Font?
    var padding: CGFloat
    
    var body : some View {
        
        
        NavigationLink(destination: CentralView()) {
            Text(text)
                
                .fontWeight(.bold)
                .font(font)
                .padding(padding)
                .foregroundColor(.white)
                .padding(.horizontal,padding)
                .background(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                .border(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                .cornerRadius(10)
                .padding(20)
        }
        .simultaneousGesture(TapGesture().onEnded({ (value) in
            self.time.circleValue = 1.1
            self.time.gameOver = false
            print("ciao")
            
        }))
        
        
    }
    
}


struct InstructionsButton : View {
    
    var text : String
    var font : Font?
    var padding: CGFloat
    
    var body : some View {
        
        
        NavigationLink(destination: Istruzioni()) {
            Text(text)
                
                .fontWeight(.bold)
                .font(font)
                .padding(padding)
                .foregroundColor(.white)
                .padding(.horizontal,padding)
                .background(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                .border(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                .cornerRadius(10)
             
        }
        
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
