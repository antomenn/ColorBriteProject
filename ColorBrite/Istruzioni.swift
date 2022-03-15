//
//  istruzioni.swift
//  ColorBirite
//
//  Created by Antonio Mennillo on 22/05/2020.
//  Copyright © 2020 Antonio Mennillo. All rights reserved.
//

import SwiftUI

struct Istruzioni: View {
    var body: some View {
        
        
        VStack{
            
            Image("is").resizable().aspectRatio(contentMode: .fit)
            CustomButton(text: "  Start  ",font: .title,padding: 24)
            Spacer().frame(height:100)
        }
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        .background(Color(#colorLiteral(red: 0.07363793999, green: 0.07853061706, blue: 0.08279185742, alpha: 1)).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
    
}


struct istruzioni_Previews: PreviewProvider {
    static var previews: some View {
        Istruzioni()
    }
}
