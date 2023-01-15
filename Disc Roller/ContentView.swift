//
//  ContentView.swift
//  Disc Roller
//
//  Created by Yannick Müller on 14.01.23.
//

import SwiftUI

extension NSNotification.Name {
    public static let shakeDevice = NSNotification.Name("ShakeDevice")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .shakeDevice, object: event)
    }
}


struct ContentView: View {

    @State private var diceNumber = 1

    var body: some View {
        VStack {
            Spacer()
            Text("Dice Roller")
                .font(.largeTitle)
            Text("Role the dice by clicking on it or shake your smartphone")
                .multilineTextAlignment(.center)
                .onReceive(NotificationCenter.default.publisher(for: .shakeDevice)) { _ in
                    self.diceNumber = Int.random(in: 1...6)
                }
            Spacer()
            Button {
                self.diceNumber = Int.random(in: 1...6)
            } label: {
                Image("dice-\(self.diceNumber)")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
            }
            Spacer()
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
