//
//  ContentView.swift
//  NFCHabits
//
//  Created by Egan Bisma on 12/28/22.
//

import SwiftUI
import CoreNFC

struct ContentView: View {
    @State var data = "" // the read NDEF message
    @State var showWrite = false
    @EnvironmentObject var sceneDelegate: FSSceneDelegate
    @State private var url: String = ""
    
    
    let holder = "Read message will display here"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("nfcHabit url: \(url.count > 0 ? url : sceneDelegate.url)").foregroundColor(.black)
                
                Spacer()
            }
            .padding(.top, 20)
            .background(.white)
            .navigationTitle("NFCHabits")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: WriteNfcHabitView(isActive: $showWrite),
                                   isActive: $showWrite) {
                        Button{
                            showWrite.toggle()
                        } label: {
                            Text("Write NFC Habit")
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .onOpenURL { url in
            // This will only get invoked the first couple of times the NFC is triggered.
            // When the tap defaults to the app, the scene delegate starts to get called, not this

            print("onOpenUrl called \(url.absoluteString)")
            self.url = url.absoluteString
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    @UIApplicationDelegateAdaptor(FSAppDelegate.self) var appDelegate
    
    static var previews: some View {
        ContentView()
    }
}
