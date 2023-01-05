//
//  NFCSessionWrite.swift
//  NFCHabits
//
//  Created by Egan Bisma on 1/5/23.
//

import CoreNFC


//NFC Write
class NFCSessionWrite: NSObject, NFCNDEFReaderSessionDelegate {
    var session: NFCNDEFReaderSession?
    
    var message = ""
    
    func beginScanning(message: String) {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("Scanning not support for this device")
            return
        }
        
        self.message = message
        
        session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near an NFC tag to write message"
        session?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        //        Do nothing unless want ot implement error
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        //        Do nothing here
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        //thi sis a silence console
    }
    
    
    // Write function
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        // Check if only 1 tag is found
        if tags.count > 1 {
            // restart session for 2 secconds
            let retryInterval = DispatchTimeInterval.milliseconds(2000)
            
            session.alertMessage = "More than 1 tag is detected. Remove all tag and try again."
            
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                session.restartPolling()
            }
            return
        }
        
        // Connect to the tag once we know only 1 tag is found
        let tag = tags.first!
        print("Got first tag")
        session.connect(to: tag) { (error) in
            if error != nil {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                print("Error connect")
                return
            }
            
            // Query tag if no error occur
            tag.queryNDEFStatus { (ndefStatus, capacity, error) in
                if error != nil {
                    session.alertMessage = "Unable to query the NFC NDEF tag."
                    session.invalidate()
                    print("Error query tag.")
                    return
                }
                
                // proceed to query
                switch ndefStatus {
                case .notSupported:
                    print("Not supported")
                    session.alertMessage = "Tag is not NDEF compliant"
                    session.invalidate()
                case .readWrite:
                    print("Read write")
                    let payload: NFCNDEFPayload?
                    
                    // Make sure our url is actual url
                    guard let url = URL(string: "https://nfchabits.com/\(self.message)") else {
                        print("Not a valid URL")
                        session.alertMessage = "Not a valid URL"
                        return
                    }
                    payload = NFCNDEFPayload.wellKnownTypeURIPayload(url: url)
                    
                    // make our message array
                    let nfcMessage = NFCNDEFMessage(records: [payload!])
                    
                    //write to tag
                    tag.writeNDEF(nfcMessage) { (error) in
                        if error != nil {
                            session.alertMessage = "Write NDEF fail: \(error!.localizedDescription)"
                            print("fail write: \(error!.localizedDescription)")
                        } else {
                            session.alertMessage = "Write NDEF successful."
                        }
                        session.invalidate()
                    }
                case .readOnly:
                    print("Read only")
                    session.alertMessage = "Tag is readonly"
                    session.invalidate()
                @unknown default:
                    print("Unknown Error")
                    session.alertMessage = "Unknown NDEF tag status"
                    session.invalidate()
                }
            }
        }
    }
}
