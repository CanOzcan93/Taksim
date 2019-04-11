//
//  TSSheetFactory.swift
//  Blender
//
//  Created by Erhan Emre Eroğlu on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

extension Authentication {

    public class SheetFactory: CoreSheetFactory {
        
        private var splashSheet: SplashSheet?
        public func getSplashSheet() -> SplashSheet {
            
            guard splashSheet != nil else {
                splashSheet = SplashSheet()
                return splashSheet!
            }
            
            return splashSheet!
            
        }
        
        private var mainSheet: MainSheet?
        public func getMainSheet() -> MainSheet {
            
            guard mainSheet != nil else {
                mainSheet = MainSheet()
                return mainSheet!
            }
            
            return mainSheet!
            
        }
        
        private var onboardingSheet: OnboardingSheet?
        public func getOnBoardingSheet() -> OnboardingSheet {
            
            guard onboardingSheet != nil else {
                onboardingSheet = OnboardingSheet()
                return onboardingSheet!
            }
            
            return onboardingSheet!
            
        }
        
        private var loginSheet: LoginSheet?
        public func getLoginSheet() -> LoginSheet {
            
            guard loginSheet != nil else {
                loginSheet = LoginSheet()
                return loginSheet!
            }
            
            return loginSheet!
            
        }
        
        private var signupSheet: SignUpSheet?
        public func getSignUpSheet() -> SignUpSheet {
            
            guard signupSheet != nil else {
                signupSheet = SignUpSheet()
                return signupSheet!
            }
            
            return signupSheet!
            
        }
        
        private var loginVerificationSheet: LoginVerificationSheet?
        public func getLoginVerificationSheet() -> LoginVerificationSheet {
            
            guard loginVerificationSheet != nil else {
                loginVerificationSheet = LoginVerificationSheet()
                return loginVerificationSheet!
            }
            
            return loginVerificationSheet!
            
        }
        
        private var signUpVerificationSheet: SignUpVerificationSheet?
        public func getSignUpVerificationSheet() -> SignUpVerificationSheet {
            
            guard signUpVerificationSheet != nil else {
                signUpVerificationSheet = SignUpVerificationSheet()
                return signUpVerificationSheet!
            }
            
            return signUpVerificationSheet!
            
        }
        
        private var signUpFormSheet: SignUpFormSheet?
        public func getSignUpFormSheet() -> SignUpFormSheet {
            
            guard signUpFormSheet != nil else {
                signUpFormSheet = SignUpFormSheet()
                return signUpFormSheet!
            }
            
            return signUpFormSheet!
            
        }
        
    }

}
