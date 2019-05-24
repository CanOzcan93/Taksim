//
//  SheetFactory-Main.swift
//  Taksim
//
//  Created by Can Özcan on 9.01.2019.
//  Copyright © 2019 RedBlac. All rights reserved.
//

import Core

extension Main {
    
    public class SheetFactory: CoreSheetFactory {
        
        private var mainSheet: MainSheet?
        public func getMainSheet() -> MainSheet {
            
            guard mainSheet != nil else {
                mainSheet = MainSheet()
                return mainSheet!
            }
            
            return mainSheet!
            
        }
        
        private var coordinateSelectionSheet: CoordinateSelectionSheet!
        public func getCoordinateSelectionSheet() -> CoordinateSelectionSheet {
            
            guard coordinateSelectionSheet != nil else {
                coordinateSelectionSheet = CoordinateSelectionSheet()
                return coordinateSelectionSheet!
            }
            
            return coordinateSelectionSheet!
            
        }
        
        private var tripToPickUpPointSheet: TripToPickUpPointSheet!
        public func getTripToPickUpPointSheet() -> TripToPickUpPointSheet {
            
            guard tripToPickUpPointSheet != nil else {
                tripToPickUpPointSheet = TripToPickUpPointSheet()
                return tripToPickUpPointSheet!
            }
            
            return tripToPickUpPointSheet!
            
        }
        
        private var tripToDestinationPointSheet: TripToDestinationPointSheet!
        public func getTripToDestinationPointSheet() -> TripToDestinationPointSheet {
            
            guard tripToDestinationPointSheet != nil else {
                tripToDestinationPointSheet = TripToDestinationPointSheet()
                return tripToDestinationPointSheet!
            }
            
            return tripToDestinationPointSheet!
            
        }
        
        private var callSheet: CallSheet!
        public func getCallSheet() -> CallSheet {
            
            guard callSheet != nil else {
                callSheet = CallSheet()
                return callSheet!
            }
            
            return callSheet!
            
        }
        
        public func resetSheetsButMainSheet() {
            self.tripToPickUpPointSheet = nil
            self.tripToDestinationPointSheet = nil
            self.callSheet = nil
        }
        
    }
    
}
