//
//  WriteNfcHabitView.swift
//  NFCHabits
//
//  Created by Egan Bisma on 1/5/23.
//

import SwiftUI

struct Payload {
    var type: RecordType
    var pickerMsg: String
}

struct WriteNfcHabitView: View {
    @State var record = ""
    @State private var selection = 0
    
    @Binding var isActive: Bool
    
    var sessionWrite = NFCSessionWrite()
    var recordType = [Payload(type: .text, pickerMsg: "Text"), Payload(type: .url, pickerMsg: "URL")]
    
    var body: some View {
        Form {
            Section {
                TextField("Message Here...", text: self.$record)
            }
            
            Section {
                Picker(selection: self.$selection, label: Text("Pick a record type.")) {
                    ForEach(0..<self.recordType.count) {
                        Text(self.recordType[$0].pickerMsg)
                    }
                }
            }
            
            Section {
                Button {
                    self.sessionWrite.beginScanning(message: self.record, recordType: self.recordType[selection].type)
                } label: {
                    Text("Write")
                }
            }
            
            Section {
                Text("Write View")
                    .navigationBarTitle("NFC Write", displayMode: .inline)
                    .padding(.top, 20)
            }
        }
    }
}

struct WriteNfcHabitView_Previews: PreviewProvider {
    static var previews: some View {
        WriteNfcHabitView(isActive: .constant(true))
    }
}
