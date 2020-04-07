//
//  ViewController.swift
//  instagramClone
//
//  Created by Yusuf ARİTÜRK on 24.03.2020.
//  Copyright © 2020 Yusuf ARİTÜRK. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textSifre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            self.performSegue(withIdentifier: "gitAnaSayfaVC", sender: nil) 
        }
    }
    
    
    
    // giriş yap ile ilgili kodlama bölümü
    @IBAction func buttonGiris(_ sender: Any) {
        
        if textEmail.text != "" && textSifre.text != "" {
            
            Auth.auth().signIn(withEmail: textEmail.text!, password: textSifre.text!) { (authdata, error) in
                
                
                if error != nil {
                    self.hata(titleNotu: "Hata!", messageNotu: error?.localizedDescription ?? "Hata bulundu")
                    
                } else {
                    self.performSegue(withIdentifier: "gitAnaSayfaVC", sender: nil)
                }
            }
            
            
        }else {
          hata(titleNotu: "Hata!", messageNotu: "Kullanıcı adı ve şifre boş")
            
        }
        
        
    }
    
    
    
    
    // Kayıt ol ile ilgili kodlama bölümü
    @IBAction func buttonKayitOl(_ sender: Any) {
        
        if textEmail.text != "" && textSifre.text != "" {
            Auth.auth().createUser(withEmail: textEmail.text!, password: textSifre.text!) { (authdata, error) in
                
                
                if error != nil {
                    
                    self.hata(titleNotu: "Hata!", messageNotu: error?.localizedDescription ?? "Hata bulundu")
                } else {
                    self.performSegue(withIdentifier: "gitAnaSayfaVC", sender: nil)
                }
            }
            
        }else {
           hata(titleNotu: "Hata!", messageNotu: "Kullanıcı adı ve şifre boş")
        }
        
       
    }
    
    // HATA KODLAMASI UYARISI
       
       
       func hata(titleNotu : String, messageNotu : String) {
           
           let alert = UIAlertController(title: titleNotu, message: messageNotu, preferredStyle: UIAlertController.Style.alert)
           let tamamButton =  UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(tamamButton)
           self.present(alert, animated: true, completion: nil)
           
           
           
       }
    
}

