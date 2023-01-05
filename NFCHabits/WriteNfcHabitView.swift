//
//  WriteNfcHabitView.swift
//  NFCHabits
//
//  Created by Egan Bisma on 1/5/23.
//

import SwiftUI



struct WriteNfcHabitView: View {
    @State var record = ""
    @State private var selection = 0
    
    @Binding var isActive: Bool
    
    var sessionWrite = NFCSessionWrite()
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("name", text: self.$record)
                }
                
                Section {
                    Button {
                        self.sessionWrite.beginScanning(message: self.record)
                    } label: {
                        Text("Link to NFC")
                    }
                }
            }
            
            Spacer()
            
            Button {
                isActive.toggle()
            } label: {
                Text("Add")
            }
            
            
            Spacer()
        }
        .navigationTitle("Add Habit")
    }
}

struct WriteNfcHabitView_Previews: PreviewProvider {
    static var previews: some View {
        WriteNfcHabitView(isActive: .constant(true))
    }
}
