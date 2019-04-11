//
//  TSStateMachine.swift
//  Blender
//
//  Created by Erhan Emre Eroğlu on 18.12.2018.
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
    
}
