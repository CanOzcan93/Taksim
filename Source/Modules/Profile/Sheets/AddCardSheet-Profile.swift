//
//  AddCardSheet-Profile.swift
//  Taksim
//
//  Created by Can Özcan on 17.10.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Foundation
//import SwiftyJSON

extension Profile {
    
    public class AddCardSheet: Sheet<AddCardLayout> {
        
        public override func onLayoutReady(layout: Profile.AddCardLayout) {
            
            var needBinChecked = true
            var card_brand = ""
            
            layout.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
            layout.gi_cvv.ti.onBeginEdit = {
                
                layout.gi_picker.hide()
                
            }
            
            layout.gi_card.ti.onBeginEdit = {
                
                layout.gi_picker.hide()
                
            }
            
            layout.gi_name.ti.onBeginEdit = {
                
                layout.gi_picker.hide()
                
            }
            
            
            
            layout.gi_picker.ti.onBeginEdit = {
                
                layout.gi_picker.show()
                DispatchQueue.main.async {
                    layout.endEditing(true)
                }
            }
            
            
        
            
            layout.gi_card.ti.whileEdit { ti in
                
                if ti.text != nil {
                    
                    if ti.text!.count == 6 && needBinChecked {
                        
                        self.apiManager.checkCreditCard(binNumber: ti.text!) { (json) in
                            
                            if json["status"] == "success" {
                                card_brand = json["brand"].stringValue
                            }
                            needBinChecked = false
                        }
                        
                    }
                    else if ti.text!.count <= 5 {
                        card_brand = ""
                        needBinChecked = true
                    }
                    
                    else if ti.text!.count > 16 {
                        ti.text = String(ti.text!.prefix(16))
                    }
                    
                }
                
                
            }
            
            layout.btn_accept.onClick {
                
                if layout.gi_card.ti.text != nil && layout.gi_card.ti.text!.count == 16  &&
                    layout.gi_name.ti.text != nil && layout.gi_cvv.ti.text != nil &&
                    layout.gi_picker.ti.text != nil {
                    
                    let dateSplitted = layout.gi_picker.ti.text!.split(separator: "/")
                    
                    let month = UInt(String(dateSplitted.first!))!
                    
                    let year = UInt(String(dateSplitted.last!))!
                    
                    let curUser = self.dataStorage.grabCurrentUser()!
                    
                    self.apiManager.addCreditCard(cardName: layout.gi_name.ti.text!,
                                                  cardNumber: layout.gi_card.ti.text!,
                                                  expiryMonth: month,
                                                  expiryYear: year,
                                                  cvv: UInt(layout.gi_cvv.ti.text!)!,
                                                  email: curUser.email,
                                                  nameAndSurname: curUser.nickname,
                                                  userPhone: self.persistentStorage.recall(key: self.persistentStorage.phoneNumberKey) as! String,
                                                  userID: curUser.userId,
                                                  cardCount: 0,
                                                  utoken: curUser.uToken )
                    { (str) in
                        self.exchangeFlow.letCardHtml(html: str)
                        self.demonstrator.toWebCardSheet()
                    }
                    
                }
                
            }
            
            
        }
        
    }
}
