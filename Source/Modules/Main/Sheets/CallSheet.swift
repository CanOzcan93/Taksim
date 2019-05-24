//
//  CallSheet.swift
//  Taksim
//
//  Created by E.E.E. on 31.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import AVFoundation

extension Main {
    
    public class CallSheet: Sheet<CallLayout> {
        
        public var aqPlayer = AQPlayer(sampleRate: 8000)
        private var echoCancellation: XBEchoCancellation!
        
        public override func onLayoutAppear(layout: Main.CallLayout) {
            
            if self.stateMachine.callConnected() {
                layout.changeStatus(status: "Bağlandı")
            }
            
            self.echoCancellation = XBEchoCancellation.shared()
            self.echoCancellation.close()
            self.echoCancellation.open()
            
            self.echoCancellation.bl_input = { bufferList in
                
                let buffer = bufferList!.pointee.mBuffers
                let pcmBlock = NSData(bytes: buffer.mData, length: Int(buffer.mDataByteSize))
                
                let dataLength = pcmBlock.length
                let pPcm = pcmBlock.bytes.assumingMemoryBound(to: Int16.self)
                let len = dataLength/2
                let g711Buff = malloc(len)?.assumingMemoryBound(to: UInt8.self)
                memset(g711Buff, 0, len)
                for i in (0..<len) {
                    g711Buff![i] = EncoderG711.linear2alaw(Int32(pPcm[i]))
                }
                let sendData = NSData(bytes: g711Buff, length: len)
                free(g711Buff)
                
                self.networkManager.sendVoice(data: sendData as Data)
                print(sendData)
            }
            
            self.networkManager.hangUpResult = {
                self.echoCancellation.stop()
                self.demonstrator.goBackFromCallSheetToTripToPickUpPointSheet()
            }
            
            self.networkManager.callOutResult = { accepted in
                
                if accepted {
                    layout.changeStatus(status: "Bağlandı")
                    self.echoCancellation.startInput()
                }
                else {
                    self.demonstrator.goBackFromCallSheetToTripToPickUpPointSheet()
                }
                
            }
            
            self.networkManager.receiveVoice = { voiceData in
                
                let voiceNsData = voiceData as NSData
                let dataLength = voiceNsData.length
                let inLen = Int32(dataLength)
                let g711Buf = voiceNsData.bytes.assumingMemoryBound(to: Int16.self)
                var outlen = inLen*2
                let pcmBuff = malloc(Int(outlen))?.assumingMemoryBound(to: UInt8.self)
                g711_decode(pcmBuff, &outlen, g711Buf, inLen, Int32(TP_ALAW.rawValue))
                let pcm = NSData(bytes: pcmBuff, length: Int(outlen))
                free(pcmBuff)
                self.mediaManager.aqPlayer.play(with: pcm as Data)
                
            }
            
            self.networkManager.didFail = { error in
                self.echoCancellation.stop()
            }
            
            self.networkManager.didClose = { arg0 in
                self.echoCancellation.stop()
            }
            
            self.stateMachine.isCallSheetAppear(state: true)
            
            layout.addDriverInfo(driver: self.dataStorage.grabDispatchedDriver()!, vehicle: self.dataStorage.grabDispatchedVehicle()!)
            
            layout.onHangUp = {
                self.echoCancellation.stop()
                self.networkManager.hangUp()
                self.demonstrator.goBackFromCallSheetToTripToPickUpPointSheet()
            }
            
            
        }
        
        public override func onLayoutReappear(layout: Main.CallLayout) {
            self.stateMachine.isCallSheetAppear(state: true)
        }
        
        public override func onLayoutDisappear(layout: Main.CallLayout) {
            layout.changeStatus(status: "Bağlanıyor")
        }
        
    }
    
}
