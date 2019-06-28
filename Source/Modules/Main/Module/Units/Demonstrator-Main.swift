//
//  Demonstrator-Main.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core
import GooglePlaces
import GoogleMaps

extension Main {
    
    public class Demonstrator: CoreDemonstrator {
        
        private var module: Module!
        
        private var factory: Factory!
        
        private var sheetFactory: SheetFactory!
        private var transitionFactory: TransitionFactory!
        
        private var autoCompleteController: GMSAutocompleteViewController?
        
        public required init() {
            
            module = Module.getInstance()
            
            factory = module.factory
            
            sheetFactory = factory.sheetFactory
            transitionFactory = factory.transitionFactory
            
        }
        
        public func toMainSheet() {
            
            sheet = sheetFactory.getMainSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toCreditCardsSheet() {
            
            let profileModule = Profile.Module.getInstance()
            let profileFactory = profileModule.factory!
            let profileSheetFactory = profileFactory.sheetFactory!
            sheet = profileSheetFactory.getCreditCardsSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
        }
        
        
        public func toAddressSheet() {
            
            let profileModule = Profile.Module.getInstance()
            let profileFactory = profileModule.factory!
            let profileSheetFactory = profileFactory.sheetFactory!
            sheet = profileSheetFactory.getAddressSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
        }
        
        public func toProfile() {
            
            let profileModule = Profile.Module.getInstance()
            let profileFactory = profileModule.factory!
            let profileSheetFactory = profileFactory.sheetFactory!
            
            sheet = profileSheetFactory.getMainSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toNotifications() {
            
            let profileModule = Profile.Module.getInstance()
            let profileFactory = profileModule.factory!
            let profileSheetFactory = profileFactory.sheetFactory!
            
            sheet = profileSheetFactory.getNotificationsSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toOrderHistory() {
            
            let profileModule = Profile.Module.getInstance()
            let profileFactory = profileModule.factory!
            let profileSheetFactory = profileFactory.sheetFactory!
            
            sheet = profileSheetFactory.getOrderHistorySheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toPromotion() {
            
            let postLoginModule = PostLogin.Module.getInstance()
            let postLoginFactory = postLoginModule.factory!
            let postLoginSheetFactory = postLoginFactory.sheetFactory!
            
            sheet = postLoginSheetFactory.getPromotionSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toHelp() {
            
            let aboutModule = About.Module.getInstance()
            let aboutFactory = aboutModule.factory!
            let aboutSheetFactory = aboutFactory.sheetFactory!
            
            sheet = aboutSheetFactory.getHelpSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toFaq() {
            
            let aboutModule = About.Module.getInstance()
            let aboutFactory = aboutModule.factory!
            let aboutSheetFactory = aboutFactory.sheetFactory!
            
            sheet = aboutSheetFactory.getFaqSheet()
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
        }
        
        public func toAutoComplete(delegate: GMSAutocompleteViewControllerDelegate) {
            
            let locationFilter = GMSAutocompleteFilter()
            locationFilter.country = "tr"
            
            autoCompleteController = GMSAutocompleteViewController()
            autoCompleteController!.autocompleteFilter = locationFilter
            autoCompleteController!.delegate = delegate
            
            sheet = autoCompleteController!
            transition = transitionFactory.getFromRightToLeft()
            
            present()
            
            setCurrent(vc: autoCompleteController!)
            
        }
        
        public func goBack() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
        }
        
        public func toCoordinateSelection() {
           
            transition = transitionFactory.getFromRightToLeft()
            sheet = sheetFactory.getCoordinateSelectionSheet()
           
            present()
            
        }
        
        public func goBackFromCoordinateSelectionToMainSheet() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            dismiss()
            
            autoCompleteController?.dismiss(animated: false, completion: nil)
            
        }
        
        public func goBackFromCoordinateSelectionToAutoComplete() {
            transition = transitionFactory.getFromLeftToRight()
            dismiss()
            setCurrent(vc: autoCompleteController!)
        }
        
        public func toTripToPickUpPoint(completion: Action?) {
            transition = transitionFactory.getFromRightToLeft()
            sheet = sheetFactory.getTripToPickUpPointSheet()
            present {
                completion?()
            }
        }
        
        public func toTripToDestinationPoint() {
            transition = transitionFactory.getFromRightToLeft()
            sheet = sheetFactory.getTripToDestinationPointSheet()
            present()
        }
        
        public func toCallSheet() {
            
            sheet = sheetFactory.getCallSheet()
            transition = transitionFactory.getFade()
            
            present()
            
        }
        
        public func goBackFromCallSheetToTripToPickUpPointSheet() {
            
            transition = transitionFactory.getFade()
            
            dismiss()
            
        }
        
        public func goBackToMainSheet() {
            self.sheetFactory.getTripToPickUpPointSheet().networkManager.close()
            self.sheetFactory = SheetFactory()
            transition = transitionFactory.getFromLeftToRight()
            dismiss()
            
        }
        
        public func goBackFromTripToDestinationPointSheetToMainSheet() {
            
            transition = transitionFactory.getFromLeftToRight()
            
            if sheetFactory.existTripToPickUpPointSheet() {
                let tripPickUpSheet = sheetFactory.getTripToPickUpPointSheet()
                tripPickUpSheet.dismiss(animated: false) {
                    tripPickUpSheet.networkManager.disposable.dispose()
                    tripPickUpSheet.networkManager.close()
                    self.sheetFactory = SheetFactory()
                    self.sheet = self.sheetFactory.getMainSheet()
                    self.dismiss()
                }
            }
            else {
                sheet = sheetFactory.getMainSheet()
                self.sheetFactory = SheetFactory()
                dismiss()
            }
            
            
        }
    }
    
}
