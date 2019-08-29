//
//  SearchLocation-Main.swift
//  Taksim
//
//  Created by Can Özcan on 6.08.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import UIKit
import GooglePlaces
import Core

extension Main {
    
    public class SearchLocationSheet: Sheet<SearchLocationLayout> {
        
        
        public override func onLayoutReady(layout: Main.SearchLocationLayout) {
            
            layout.addressInput.onBackButtonClicked = {
                self.demonstrator.goBack()
            }
            
            layout.addressInput.ti_address.onTap {
                self.demonstrator.toAutoComplete()
            }
            
            self.apiManager.getCustomerAddress(userID: self.dataStorage.grabCurrentUser()!.userId, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) { (json) in
                print("Get Customer Address: \(json.rawString()!)")
                var homeBar: SearchLocationListItem? = nil
                var workBar: SearchLocationListItem? = nil
                var favoriteBars: [SearchLocationListItem] = [SearchLocationListItem]()
                if json["addressList"].exists() {
                    for addressJson in json["addressList"].array! {
                        if addressJson["name"].stringValue == "Home" {
                            homeBar = SearchLocationListItem(
                                status: .Home,
                                address: addressJson["address"].stringValue,
                                coordinate: CoreCoordinate(latitude: addressJson["lat"].doubleValue, longitude: addressJson["lon"].doubleValue),
                                addressID: addressJson["id"].uIntValue,
                                onClickItem: {
                                    if homeBar!.isActive {
                                        self.exchangeFlow.letSelectedPlace(place: CLLocationCoordinate2D(latitude: addressJson["lat"].doubleValue, longitude: addressJson["lon"].doubleValue))
                                        self.demonstrator.toCoordinateSelection()
                                    }
                                },
                                onClickButton: {
                                    if homeBar!.isActive {
                                        self.apiManager.removeCustomerAddress(addressID: homeBar!.addressID!, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) { (json) in
                                            homeBar!.resetItem()
                                        }
                                    }
                                    else {
                                        self.stateMachine.isEditingHomeLocation(state: true)
                                        self.demonstrator.toAutoComplete()
                                    }
                                })
                        } else if addressJson["name"].stringValue == "Work" {
                            workBar = SearchLocationListItem(
                                status: .Work,
                                address: addressJson["address"].stringValue,
                                coordinate: CoreCoordinate(latitude: addressJson["lat"].doubleValue, longitude: addressJson["lon"].doubleValue),
                                addressID: addressJson["id"].uIntValue,
                                onClickItem: {
                                    if workBar!.isActive {
                                        self.exchangeFlow.letSelectedPlace(place: CLLocationCoordinate2D(latitude: addressJson["lat"].doubleValue, longitude: addressJson["lon"].doubleValue))
                                        self.demonstrator.toCoordinateSelection()
                                    }
                                },
                                onClickButton: {
                                    if workBar!.isActive {
                                        self.apiManager.removeCustomerAddress(addressID: workBar!.addressID!, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) { (json) in
                                            workBar!.resetItem()
                                        }
                                    }
                                    else {
                                        self.stateMachine.isEditingWorkLocation(state: true)
                                        self.demonstrator.toAutoComplete()
                                    }
                                })
                        }
                        else {
                            
                            let favoriteSingleBar = SearchLocationListItem( status: .Favorites,
                                                        address: addressJson["address"].stringValue,
                                                        coordinate: CoreCoordinate(latitude: addressJson["lat"].doubleValue, longitude: addressJson["lon"].doubleValue),
                                                        addressID: addressJson["id"].uIntValue,
                                                        onClickItem: nil,
                                                        onClickButton: nil)
                            favoriteSingleBar.resetFunctions(
                                onClickItem: {
                                    if favoriteSingleBar.isActive {
                                        self.exchangeFlow.letSelectedPlace(place: CLLocationCoordinate2D(latitude: addressJson["lat"].doubleValue, longitude: addressJson["lon"].doubleValue))
                                        self.demonstrator.toCoordinateSelection()
                                    }
                                },
                                onClickButton: {
                                    if favoriteSingleBar.isActive {
                                        self.apiManager.removeCustomerAddress(addressID: favoriteSingleBar.addressID!, token: self.persistentStorage.recall(key: self.persistentStorage.tokenKey) as! String) { (json) in
                                            favoriteSingleBar.resetItem()
                                        }
                                    }
                                    else {
                                        self.stateMachine.isEditingFavoriteLocation(state: true)
                                        self.demonstrator.toAutoComplete()
                                    }
                                })
                            favoriteBars.append(favoriteSingleBar)
                        }
                    }
                }
//                if favoriteBars.count == 0 {
                if true {
                    favoriteBars.append(SearchLocationListItem(status: .Favorites, address: nil, coordinate: nil, addressID: nil,
                    onClickItem: nil,
                    onClickButton: {
                        self.stateMachine.isEditingFavoriteLocation(state: true)
                        self.demonstrator.toAutoComplete()
                    }))
                }
                if workBar == nil {
                    workBar = SearchLocationListItem(status: .Work, address: nil, coordinate: nil, addressID: nil, onClickItem: nil,
                    onClickButton: {
                            self.stateMachine.isEditingWorkLocation(state: true)
                            self.demonstrator.toAutoComplete()
                    })
                }
                favoriteBars.insert(workBar!, at: 0)
                if homeBar == nil {
                    homeBar = SearchLocationListItem(status: .Home, address: nil, coordinate: nil, addressID: nil, onClickItem: nil,
                    onClickButton: {
                        self.stateMachine.isEditingHomeLocation(state: true)
                        self.demonstrator.toAutoComplete()
                    })
                }
                favoriteBars.insert(homeBar!, at: 0)
                layout.lv.addItems(favoriteBars)
                
//                for i in (0..<favoriteBars.count) {
//                    favoriteBars[i].btn_plus.tag = i
//                }
            }
            
            
        }

        
    }
    
    
}

