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
        
        public override func onLayoutReady(layout: Main.CallLayout) {
            if self.stateMachine.callConnected() {
                layout.changeStatus(status: "Bağlandı")
            }
            
            layout.addDriverInfo(driver: self.dataStorage.grabDispatchedDriver()!, vehicle: self.dataStorage.grabDispatchedVehicle()!)
        }
        
        public override func onLayoutAppear(layout: Main.CallLayout) {
            
            self.echoCancellation = XBEchoCancellation.shared()
            self.echoCancellation.close()
            self.echoCancellation.open()
            
            self.echoCancellation.bl_input = { bufferList in
                
                let buffer = bufferList!.pointee.mBuffers
                let pcmBlock = NSData(bytes: buffer.mData, length: Int(buffer.mDataByteSize))
                let gain = Int32(1)
                let dataLength = pcmBlock.length
                let pPcm = pcmBlock.bytes.assumingMemoryBound(to: Int16.self)
                let len = dataLength/2
                let g711Buff = malloc(len)?.assumingMemoryBound(to: UInt8.self)
                memset(g711Buff, 0, len)
                for i in (0..<len) {
                    let currentByte = Int32(pPcm[i])
                    var gainedByte = currentByte * gain
                    if gainedByte > Int16.max {
                        gainedByte = Int32(Int16.max)
                    }
                    if gainedByte < Int16.min {
                        gainedByte = Int32(Int16.min)
                    }
                    g711Buff![i] = EncoderG711.linear2alaw(gainedByte)
                }
                let sendData = NSData(bytes: g711Buff, length: len)
                free(g711Buff)
                self.networkManager.sendVoice(data: sendData as Data)
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
                self.aqPlayer!.play(with: pcm as Data)
                
            }
            
            self.networkManager.didFail = { error in
                self.echoCancellation.stop()
            }
            
            self.networkManager.didClose = { arg0 in
                self.echoCancellation.stop()
            }
            
            layout.onHangUp = {
                self.echoCancellation.stop()
                self.networkManager.hangUp()
                self.demonstrator.goBackFromCallSheetToTripToPickUpPointSheet()
            }
        }
        
        public override func onLayoutDisappear(layout: Main.CallLayout) {
            layout.changeStatus(status: "Bağlanıyor")
        }
        
    }
    
}
