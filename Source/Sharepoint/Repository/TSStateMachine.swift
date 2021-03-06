//
//  TSStateMachine.swift
//  Blender
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

public class TSStateMachine: CoreStateMachine {
    
    private var pickUpPointEditing: Bool = false
    public func isEditingPickUpPoint(state: Bool) {
        self.pickUpPointEditing = state
    }
    public func editingPickUpPoint() -> Bool {
        return self.pickUpPointEditing
    }
    public func notEditingPickUpPoint() -> Bool {
        return !self.pickUpPointEditing
    }
    
    private var destinationPointEditing: Bool = false
    public func isEditingDestinationPoint(state: Bool) {
        self.destinationPointEditing = state
    }
    public func editingDestinationPoint() -> Bool {
        return self.destinationPointEditing
    }
    public func notEditingDestinationPoint() -> Bool {
        return !self.destinationPointEditing
    }
    
    
    private var pickUpPointSelection: Bool = false
    public func isPickUpPointSelected(state: Bool) {
        self.pickUpPointSelection = state
    }
    public func pickUpPointSelected() -> Bool {
        return self.pickUpPointSelection
    }
    public func pickUpPointNotSelected() -> Bool {
        return !self.pickUpPointSelection
    }
    
    private var destionationPointSelection: Bool = false
    public func isDestinationPointSelected(state: Bool) {
        self.destionationPointSelection = state
    }
    public func destinationPointSelected() -> Bool {
        return self.destionationPointSelection
    }
    public func destinationPointNotSelected() -> Bool {
        return !self.destionationPointSelection
    }
    
    private var stateOfMainSheetReset: Bool = false
    public func shouldMainSheetBeReset(state: Bool) {
        self.stateOfMainSheetReset = state
    }
    public func mainSheetShouldBeReset() -> Bool {
        return self.stateOfMainSheetReset
    }
    
    private var stateOfMainSheetReview: Bool = false
    public func shouldMainSheetShowReview(state: Bool) {
        self.stateOfMainSheetReview = state
    }
    public func mainSheetShouldShowReview() -> Bool {
        return self.stateOfMainSheetReview
    }
    
    private var loginState: Bool = false
    public func isLoggedInApp(state: Bool) {
        self.loginState = state
    }
    public func loggedInApp() -> Bool{
        return self.loginState
    }
    public func notLoggedInApp() -> Bool {
        return !self.loginState
    }
    
    private var stateOfQuickOrder: Bool = true
    public func isQuickOrder(state: Bool) {
        self.stateOfQuickOrder = state
    }
    public func quickOrderStarted() -> Bool {
        return self.stateOfQuickOrder
    }
    public func notQuickOrderStarted() -> Bool {
        return !self.stateOfQuickOrder
    }
    
    private var statePickUpSheetAppeared: Bool = false
    public func isPickUpSheetAppear(state: Bool) {
        self.statePickUpSheetAppeared = state
    }
    
    public func pickUpSheetAppeared() -> Bool {
        return self.statePickUpSheetAppeared
    }
    public func notPickUpSheetAppeared() -> Bool {
        return !self.statePickUpSheetAppeared
    }
    
    private var stateCallConnected: Bool = false
    public func isCallConnected(state: Bool) {
        self.stateCallConnected = state
    }
    
    public func callConnected() -> Bool {
        return self.stateCallConnected
    }
    public func notCallConnected() -> Bool {
        return !self.stateCallConnected
    }
    
    private var stateEditingHomeLocation: Bool = false
    public func isEditingHomeLocation(state: Bool) {
        self.stateEditingHomeLocation = state
    }
    
    public func editingHomeLocation() -> Bool {
        return self.stateEditingHomeLocation
    }
    public func notEditingHomeLocation() -> Bool {
        return !self.stateEditingHomeLocation
    }
    
    private var stateEditingWorkLocation: Bool = false
    public func isEditingWorkLocation(state: Bool) {
        self.stateEditingWorkLocation = state
    }
    
    public func editingWorkLocation() -> Bool {
        return self.stateEditingWorkLocation
    }
    public func notEditingWorkLocation() -> Bool {
        return !self.stateEditingWorkLocation
    }
    
    private var stateEditingFavoriteLocation: Bool = false
    public func isEditingFavoriteLocation(state: Bool) {
        self.stateEditingFavoriteLocation = state
    }
    
    public func editingFavoriteLocation() -> Bool {
        return self.stateEditingFavoriteLocation
    }
    public func notEditingFavoriteLocation() -> Bool {
        return !self.stateEditingFavoriteLocation
    }
    
//    private var stateClickedCashPayment: Bool = false
//    public func isClickedCashPayment(state: Bool) {
//        self.stateClickedCashPayment = state
//    }
//    
//    public func clickedCashPayment() -> Bool {
//        return self.stateClickedCashPayment
//    }
//    public func notClickedCashPayment() -> Bool {
//        return !self.stateClickedCashPayment
//    }
    
    
}
