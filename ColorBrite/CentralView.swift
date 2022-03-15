//
//  CentralView.swift
//  ColorBrite
//
//  Created by Aiello Giovanni on 05/06/2020.
//  Copyright © 2020 ColorBriteTeam. All rights reserved.
//

import SwiftUI
import GameKit

struct CentralView: View {
    
    @EnvironmentObject var time: Time
    
    var body: some View {
        
        return VStack {
            if(time.gameOver == false) {
                CircleView()
            }
            else { GameOverView()
                
            }
        }
        
    }
}

struct CentralView_Previews: PreviewProvider {
    static var previews: some View {
        CentralView()
    }
}

struct GameOverView: View {
    @EnvironmentObject var time: Time
    
    var body: some View {
        NavigationView {
            
            
            VStack{
                Image("GameOver")
                    .padding(10)
                Spacer().frame(height:40)
                VStack(spacing:30){
                    VStack{
                        Image("Score")
                        
                        Text("\(time.score)")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                            .font(.title)
                    }
                    VStack{
                        Image("Best")
                        Text("\(UserDefaults.standard.integer(forKey: "BestScore"))")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color(#colorLiteral(red: 0.8931982517, green: 0.2030253708, blue: 0.1163413301, alpha: 1)))
                    }
                }
                Spacer().frame(height:35)
                CustomNav(text: "Play Again", font: .none, padding: 18)
                
                CustomNav1(text: "  Home  ", font: .none, padding: 18)
                
                Spacer().frame(height:180)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .background(Color(#colorLiteral(red: 0.07363793999, green: 0.07853061706, blue: 0.08279185742, alpha: 1)).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }
        .onAppear(){
            let score = UserDefaults.standard.integer(forKey: "BestScore")
            if (score < self.time.score){
                UserDefaults.standard.set(self.time.score, forKey: "BestScore")
                
            }
            self.submitScore()
        }
        
        
        
        
        
    }
    
    struct CustomNav : View {
        
        @EnvironmentObject var time: Time
        @EnvironmentObject var UniversalColor: UniversalColor
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
                    .animation(.spring())
            }
            .simultaneousGesture(TapGesture().onEnded({ (value) in
                self.time.gameOver = false
                self.time.score = 0
                self.time.circleValue = 1.1
                self.UniversalColor.number = 3
                self.UniversalColor.newColor(darkness: 15)
            }))
            
            
            
        }
        
    }
    
    
    func submitScore() {
        
        let score = GKScore(leaderboardIdentifier: "ColorBriteTeam.ColorBrite.Scores" )
        score.value = Int64(time.score)
        
        
        
        GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Score submitted")
                
            }
        })
        
    }
    struct CustomNav1 : View {
        
        var text : String
        var font : Font?
        var padding: CGFloat
        
        var body : some View {
            
            NavigationLink(destination: MainView()) {
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
            
            
            
        }
        
    }
    
    
    
    
}
