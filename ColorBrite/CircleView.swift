//
//  CircleView.swift
//  ColorBrite
//
//  Created by Aiello Giovanni on 21/05/2020.
//  Copyright © 2020 ColorBriteTeam. All rights reserved.
//

import Foundation
import SwiftUI
import AVKit
import GameKit

struct CircleView : View {

    @EnvironmentObject var UniversalColor : UniversalColor
    @EnvironmentObject var time : Time
    
    var body: some View {
        VStack(alignment:.center){
            
            TimerView()
            Spacer().frame(height:50)
            ForEach(1...self.UniversalColor.number, id: \.self) {
                CustomView( uniqueColor: self.UniversalColor.counterX == $0 ? true : false , color: self.UniversalColor.counterX == $0 ? true : false)
            }
            Spacer().frame(height:50)
            
            
        }
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        .background(Color(#colorLiteral(red: 0.07363793999, green: 0.07853061706, blue: 0.08279185742, alpha: 1)).edgesIgnoringSafeArea(.all))
        .animation(.spring())
        .navigationBarBackButtonHidden(true)
       
    }
    
    
    
}


struct CustomView : View {
    
    @EnvironmentObject var UniversalColor : UniversalColor
    
    var uniqueColor : Bool
    
    var color : Bool
    
    var body: some View {
        
        HStack {
            ForEach(1...self.UniversalColor.number,id:\.self) {
                
                CustomCircle(uniqueColor: self.uniqueColor ? (self.UniversalColor.counterY == $0 ? true : false ) : false)
                
            }
            
        }
            
        .frame(width: 200, height: 50, alignment: .center)
        
        
    }
    
    struct CustomCircle: View {
        
        @EnvironmentObject var player : AudioPlayer
        
        @State var sound = Bundle.main.path(forResource: "Error", ofType: "mp3")
        
        @State var darkness : CGFloat = -15
        
        @EnvironmentObject var time : Time
        
        @EnvironmentObject var UniversalColor : UniversalColor
        
        var uniqueColor : Bool
        
        @State var triggerAnimation = false
        
        var body: some View {
            
            Circle()
                .fill( uniqueColor ? self.UniversalColor.uniqueColor : self.UniversalColor.allColors)
                .scaleEffect(self.triggerAnimation ? 1.5 : 1)
                .animation(self.triggerAnimation ? .easeInOut: .easeOut)
                .gesture(TapGesture().onEnded({ (value) in
                    
                    if (self.uniqueColor) {
                        
                        self.player.playSounds(soundfile: "Win.mp3")
                        
                        self.UniversalColor.newColor(darkness: self.darkness)
                        self.triggerAnimation = false
                        
                        self.time.circleValue = 1.1
                        self.time.score += 1
                        
                        switch self.time.score  {
                            
                        case 25 :
                            self.UniversalColor.number = 4
                            
                        case 50 :
                            self.UniversalColor.number = 5
                            
                        case 100:
                            self.UniversalColor.number = 6
                            self.darkness = -5
                            
                        case 200:
                            self.UniversalColor.number = 7
                            
                        case 500:
                            self.UniversalColor.number = 8
                            
                        default:
                            print("")
                            
                        }
                    }
                    else {
                        
                        self.triggerAnimation = true
                        self.player.playSounds(soundfile: "Error.mp3")
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.triggerAnimation = false
                        }
                    }
                    
                }))
                .onAppear() {
                    
                    
            }
            
            
        }
    }
    
    
}

extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
}

class UniversalColor : ObservableObject {
    
    var unique = UIColor.init(red: CGFloat.random(in: 10...255)/255, green: CGFloat.random(in: 10...255)/255, blue: CGFloat.random(in: 10...255)/255, alpha: 100)
    
    @Published var allColors : Color
    
    @Published var uniqueColor : Color
    
    @Published var isUnique : Bool
    
    @Published var number : Int = 3
    
    @Published var counterX = Int.random(in: 1...3)
    
    @Published var counterY = Int.random(in: 1...3)
    
    
    init () {
        
        self.allColors = Color.init(self.unique)
        self.uniqueColor = Color.init(self.unique.adjust(by: -15)!)
        self.isUnique = true
        
    }
    
    func newColor(darkness: CGFloat) {
        
        let unique = UIColor.init(red: CGFloat.random(in: 10...255)/255, green: CGFloat.random(in: 10...255)/255, blue: CGFloat.random(in: 10...255)/255, alpha: 100)
        self.uniqueColor = Color.init(unique.adjust(by: darkness)!)
        self.allColors = Color.init(unique)
        self.counterX = Int.random(in: 1...self.number)
        self.counterY = Int.random(in: 1...self.number)
        
        
    }
    
    
}




class AudioPlayer : ObservableObject{
    
    @Published var player : AVAudioPlayer!
    
    @Published var sound: String = "Win.mp3"
    
    init(){
        start(soundfile: self.sound)
    }
    
    func start(soundfile: String) {
        
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
            
            do{
                
                self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                self.player?.prepareToPlay()
                
            }catch {
                print("Error")
            }
        }
    }
    
    func playSounds(soundfile: String) {
        
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
            
            do{
                
                self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                self.player?.play()
                
            }catch {
                print("Error")
            }
        }
    }
    
}
