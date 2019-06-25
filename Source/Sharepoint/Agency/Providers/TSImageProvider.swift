//
//  TSImageProvider.swift
//  Materials
//
//  Created by Can Özcan on 18.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

public class TSImageProvider: CoreImageProvider {
    
    private var taxiIcon: UIImage?
    public func getTaxiIcon() -> UIImage {
        
        guard taxiIcon != nil else {
            taxiIcon = UIImage(named: "ic-taxi-black")
            return taxiIcon!
        }
        
        return taxiIcon!
        
    }
    
    private var markerIcon: UIImage?
    public func getMarkerIcon() -> UIImage {
        
        guard markerIcon != nil else {
            markerIcon = UIImage(named: "ic_marker")
            return markerIcon!
        }
        
        return markerIcon!
        
    }
    
    private var rounded_shadow: UIImage?
    public func getRoundedShadow() -> UIImage {
        
        guard rounded_shadow != nil else {
            rounded_shadow = UIImage(named: "rounded_shadow")
            return rounded_shadow!
        }
        
        return rounded_shadow!
        
    }
    
    private var background: UIImage?
    public func getBackgroundImage() -> UIImage {
        
        guard background != nil else {
            background = UIImage(named: "background")
            return background!
        }
        
        return background!
        
    }
    
    private var waves_light: UIImage?
    public func getLightWaves() -> UIImage {
        
        guard waves_light != nil else {
            waves_light = UIImage(named: "waves_light")
            return waves_light!
        }
        
        return waves_light!
        
    }
    
    private var logo: UIImage?
    public func getLogo() -> UIImage {
        
        guard logo != nil else {
            logo = UIImage(named: "logo")
            return logo!
        }
        
        return logo!
        
    }
    public func getLogoRatio() -> CGFloat {
        return (270 / 135)
    }
    public func getLogoReverseRatio() -> CGFloat {
        return (135 / 270)
    }
    
    private var cover: UIImage?
    public func getCoverImage() -> UIImage {
        
        guard cover != nil else {
            cover = UIImage(named: "cover")
            return cover!
        }
        
        return cover!
        
    }
    
    private var menu_background: UIImage?
    public func getMenuBackground() -> UIImage {
        
        guard menu_background != nil else {
            menu_background = UIImage(named: "menu_background")
            return menu_background!
        }
        
        return menu_background!
        
    }
    
    private var avatar: UIImage?
    public func getAvatar() -> UIImage {
        
        guard avatar != nil else {
            avatar = UIImage(named: "ic_avatar")
            return avatar!
        }
        
        return avatar!
        
    }
    
    private var profile: UIImage?
    public func getProfile() -> UIImage {
        
        guard profile != nil else {
            profile = UIImage(named: "ic_profile")
            return profile!
        }
        
        return profile!
        
    }
    
    private var credit_card: UIImage?
    public func getCreditCard() -> UIImage{
        
        guard credit_card != nil else {
            credit_card = UIImage(named: "ic_credit_card")
            return credit_card!
        }
        
        return credit_card!
    }
    
    private var home: UIImage?
    public func getHome() -> UIImage{
        
        guard home != nil else {
            home = UIImage(named: "ic_home")
            return home!
        }
        
        return home!
    }
    
    private var bell: UIImage?
    public func getBell() -> UIImage{
        
        guard bell != nil else {
            bell = UIImage(named: "ic_bell")
            return bell!
        }
        
        return bell!
    }
    
    private var cross_filled: UIImage?
    public func getFilledCross() -> UIImage{
        
        guard cross_filled != nil else {
            cross_filled = UIImage(named: "ic_cross_filled")
            return cross_filled!
        }
        
        return cross_filled!
    }
    
    private var present: UIImage?
    public func getPresent() -> UIImage {
        
        guard present != nil else {
            present = UIImage(named: "ic_present")
            return present!
        }
        
        return present!
        
    }
    
    private var phone: UIImage?
    public func getPhone() -> UIImage {
        
        guard phone != nil else {
            phone = UIImage(named: "ic_phone")
            return phone!
        }
        
        return phone!
        
    }
    
    private var list: UIImage?
    public func getList() -> UIImage {
        
        guard list != nil else {
            list = UIImage(named: "ic_list")
            return list!
        }
        
        return list!
        
    }
    
    private var help: UIImage?
    public func getHelp() -> UIImage {
        
        guard help != nil else {
            help = UIImage(named: "ic_help")
            return help!
        }
        
        return help!
        
    }
    
    private var speech_bubble: UIImage?
    public func getSpeechBubble() -> UIImage {
        
        guard speech_bubble != nil else {
            speech_bubble = UIImage(named: "ic_speech_bubble")
            return speech_bubble!
        }
        
        return speech_bubble!
        
    }
    
    private var facebook: UIImage?
    public func getFacebook() -> UIImage {
        
        guard facebook != nil else {
            facebook = UIImage(named: "ic_facebook")
            return facebook!
        }
        
        return facebook!
        
    }
    
    private var instagram: UIImage?
    public func getInstagram() -> UIImage {
        
        guard instagram != nil else {
            instagram = UIImage(named: "ic_instagram")
            return instagram!
        }
        
        return instagram!
        
    }
    
    private var twitter: UIImage?
    public func getTwitter() -> UIImage {
        
        guard twitter != nil else {
            twitter = UIImage(named: "ic_twitter")
            return twitter!
        }
        
        return twitter!
        
    }
    
    private var exit: UIImage?
    public func getExit() -> UIImage {
        
        guard exit != nil else {
            exit = UIImage(named: "ic_exit")
            return exit!
        }
        
        return exit!
        
    }
    
    private var left_arrow: UIImage?
    public func getLeftArrow() -> UIImage {
        
        guard left_arrow != nil else {
            left_arrow = UIImage(named: "ic_left_arrow")
            return left_arrow!
        }
        
        return left_arrow!
        
    }
    
    private var left_arrow_white: UIImage?
    public func getWhiteLeftArrow() -> UIImage {
        
        guard left_arrow_white != nil else {
            left_arrow_white = UIImage(named: "ic_left_arrow_white")
            return left_arrow_white!
        }
        
        return left_arrow_white!
        
    }
    
    private var backGrayIcon: UIImage?
    public func getBackGrayIcon() -> UIImage {
        
        guard backGrayIcon != nil else {
            backGrayIcon = UIImage(named: "ic_back")
            return backGrayIcon!
        }
        
        return backGrayIcon!
        
    }
    
    private var cameraIcon: UIImage?
    public func getCameraIcon() -> UIImage {
        
        guard cameraIcon != nil else {
            cameraIcon = UIImage(named: "ic_camera")
            return cameraIcon!
        }
        
        return cameraIcon!
        
    }
    
    private var turnCameraIcon: UIImage?
    public func getTurnCameraIcon() -> UIImage {
        
        guard turnCameraIcon != nil else {
            turnCameraIcon = UIImage(named: "ic_turn_camera")
            return turnCameraIcon!
        }
        
        return turnCameraIcon!
        
    }
    
    private var plus: UIImage?
    public func getPlus() -> UIImage {
        
        guard plus != nil else {
            plus = UIImage(named: "ic_plus")
            return plus!
        }
        
        return plus!
        
    }
    
    private var down_arrow: UIImage?
    public func getDownArrow() -> UIImage {
        
        guard down_arrow != nil else {
            down_arrow = UIImage(named: "ic_down_arrow")
            return down_arrow!
        }
        
        return down_arrow!
        
    }
    
    private var bullsEye: UIImage?
    public func getBullsEye() -> UIImage {
        
        guard bullsEye != nil else {
            bullsEye = UIImage(named: "ic_bulls_eye")
            return bullsEye!
        }
        
        return bullsEye!
    }
    
    private var vertical_dots: UIImage?
    public func getVerticalDots() -> UIImage {
        
        guard vertical_dots != nil else {
            vertical_dots = UIImage(named: "ic_vertical_dots")
            return vertical_dots!
        }
        
        return vertical_dots!
    }
    
    private var location: UIImage?
    public func getLocation() -> UIImage {
        
        guard location != nil else {
            location = UIImage(named: "ic_location")
            return location!
        }
        
        return location!
    }
    
    private var star_filled: UIImage?
    public func getFilledStar() -> UIImage {
        
        guard star_filled != nil else {
            star_filled = UIImage(named: "ic_star_filled")
            return star_filled!
        }
        
        return star_filled!
    }
    
    private var star_outlined: UIImage?
    public func getOutlinedStar() -> UIImage {
        
        guard star_outlined != nil else {
            star_outlined = UIImage(named: "ic_star_outlined")
            return star_outlined!
        }
        
        return star_outlined!
    }
    
    private var hamburger_menu: UIImage?
    public func getHamburgerMenu() -> UIImage {
        
        guard hamburger_menu != nil else {
            hamburger_menu = UIImage(named: "ic_hamburger_menu")
            return hamburger_menu!
        }
        
        return hamburger_menu!
    }
    
    
    private var izmir_tutorial: UIImage?
    public func getIzmirTutorial() -> UIImage {
        
        guard izmir_tutorial != nil else {
            izmir_tutorial = UIImage(named: "ic_izmir_tutorial")
            return izmir_tutorial!
        }
        
        return izmir_tutorial!
    }
    
    private var map_tutorial: UIImage?
    public func getMapTutorial() -> UIImage {
        
        guard map_tutorial != nil else {
            map_tutorial = UIImage(named: "ic_map_tutorial")
            return map_tutorial!
        }
        
        return map_tutorial!
    }
    
    private var safety_tutorial: UIImage?
    public func getSafetyTutorial() -> UIImage {
        
        guard safety_tutorial != nil else {
            safety_tutorial = UIImage(named: "ic_safety_tutorial")
            return safety_tutorial!
        }
        
        return safety_tutorial!
    }
    
    private var wallet_tutorial: UIImage?
    public func getWalletTutorial() -> UIImage {
        
        guard wallet_tutorial != nil else {
            wallet_tutorial = UIImage(named: "ic_wallet_tutorial")
            return wallet_tutorial!
        }
        
        return wallet_tutorial!
    }
    
    private var ic_hang_up: UIImage?
    public func getHangUpIcon() -> UIImage {
        
        guard ic_hang_up != nil else {
            ic_hang_up = UIImage(named: "ic_hang_up")
            return ic_hang_up!
        }
        
        return ic_hang_up!
    }
    
    private var ic_cur_loc: UIImage?
    public func getCurrentLocationIcon() -> UIImage {
        
        guard ic_cur_loc != nil else {
            ic_cur_loc = UIImage(named: "ic_currentLoc")
            return ic_cur_loc!
        }
        
        return ic_cur_loc!
    }
    
    
}
