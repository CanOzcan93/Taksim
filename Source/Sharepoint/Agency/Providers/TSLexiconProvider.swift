//
//  LexiconProvider.swift
//  Taksim
//
//  Created by Can Özcan on 10.12.2018.
//  Copyright © 2018 RedBlac. All rights reserved.
//

import Core

public class TSLexiconProvider: CoreLexiconProvider<TSLexicon, TSLanguage> {
    
    public override func onInit() -> Dictionary<String, TSLexicon>? {
        
        var dict = Dictionary<String, TSLexicon>()
        
        dict["login"] = TSWord(en: "Login", tr: "Giriş")
        dict["login_phone"] = TSPhrase(en: "Please enter your phone number", tr: "Lütfen telefon numaranızı giriniz")
        dict["login_verification_sms"] = TSPhrase(en: "Enter the code that is sent by SMS", tr: "SMS ile gönderilen kodu giriniz")
        dict["signup"] = TSPhrase(en: "Sign Up", tr: "Üye Ol")
        dict["signup_phone"] = TSPhrase(en: "Please enter your phone number", tr: "Lütfen telefon numaranızı giriniz")
        dict["signup_verification_sms"] = TSPhrase(en: "Enter the code that is sent by SMS", tr: "SMS ile gönderilen kodu giriniz")
        dict["signup_account"] = TSPhrase(en: "Enter your account info", tr: "Bilgilerinizi giriniz")
        dict["next"] = TSWord(en: "Next", tr: "İlerle")
        dict["faq"] = TSWord(en: "F.A.Q.", tr: "S.S.S.")
        dict["profile"] = TSWord(en: "Profile", tr: "Profilim")
        dict["credit_cards"] = TSWord(en: "Credit Cards", tr: "Kredi Kartlarım")
        dict["locations"] = TSWord(en: "Locations", tr: "Adreslerim")
        dict["notifications"] = TSWord(en: "Notifications", tr: "Bildirimlerim")
        dict["promotion"] = TSWord(en: "Promotion", tr: "Promosyon")
        dict["help"] = TSWord(en: "Help", tr: "Yardım")
        dict["exit"] = TSWord(en: "Exit", tr: "Çıkış")
        dict["trips"] = TSWord(en: "Trips", tr: "Yolculuklarım")
        dict["follow_us"] = TSPhrase(en: "Follow Us", tr: "Bizi takip edin")
        dict["current_location"] = TSPhrase(en: "Current Location", tr: "Başlangıç Adresiniz")
        dict["destination_location"] = TSPhrase(en: "Destination Location", tr: "Varmak İstediğiniz Yer")
        dict["name"] = TSWord(en: "Name", tr: "Adınız")
        dict["last_name"] = TSWord(en: "Last Name", tr: "Soyadınız")
        dict["phone"] = TSWord(en: "Phone", tr: "Telefon")
        dict["email"] = TSWord(en: "Email", tr: "E-Posta")
        dict["save"] = TSWord(en: "Save", tr: "Kaydet")
        dict["estimated_time"] = TSPhrase(en: "Estimated Time", tr: "Varış Zamanı")
        dict["cancellation"] = TSPhrase(en: "Are you sure you want to cancel this process", tr: "İşleminizi iptal etmek istiyor musunuz")
        dict["yes"] = TSWord(en: "Yes", tr: "Evet")
        dict["no"] = TSWord(en: "No", tr: "Hayır")
        dict["rate_trip"] = TSPhrase(en: "Rate this trip", tr: "Yolcuğunuzu değenlendirin")
        dict["comment_phase"] = TSPhrase(en: "Add Comment", tr: "Yorum yazmak için tıklayınız")
        dict["cancel"] = TSWord(en: "Cancel", tr: "İptal")
        dict["send"] = TSWord(en: "Send", tr: "Gönder")
        
        return dict
        
    }
    
    public override func onInitialLanguage() -> TSLanguage? {
        return TSLanguage.tr
    }
    
    public override func get(_ key: String) -> String {
        
        switch language! {
        case .en:
            return dictionary[key]!.en
        case .tr:
            return dictionary[key]!.tr
        }
        
    }
    
}
