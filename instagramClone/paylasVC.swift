//
//  paylasVC.swift
//  instagramClone
//
//  Created by Yusuf ARİTÜRK on 24.03.2020.
//  Copyright © 2020 Yusuf ARİTÜRK. All rights reserved.
//

import UIKit
import Firebase

class paylasVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var resimPaylas: UIImageView!
    @IBOutlet weak var textPaylas: UITextField!
    @IBOutlet weak var buttonPaylas: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resimPaylas.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(resimSec))
        resimPaylas.addGestureRecognizer(recognizer)
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func resimSec() {
        
        
        let toplayici = UIImagePickerController()
        toplayici.delegate = self
        toplayici.sourceType = .photoLibrary
        present(toplayici, animated: true, completion: nil)
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        resimPaylas.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func uyarlamak (titleNot : String, messageNot : String) {
        
        let alert = UIAlertController(title: titleNot, message: messageNot, preferredStyle: UIAlertController.Style.alert)
        let tamamButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(tamamButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    @IBAction func buttonPaylasIslem(_ sender: Any) {
        
        let media = Storage.storage()
        let storageRefarans = media.reference()
        
        let mediaResim = storageRefarans.child("resim")
        
        if let data = resimPaylas.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let resimRefarans = mediaResim.child("\(uuid).jpg")
            resimRefarans.putData(data, metadata: nil)  { (metdata, error) in
                if error != nil {
                    
                    self.uyarlamak(titleNot: "Hata!", messageNot: error?.localizedDescription ?? "Hata Var")
                } else {
                    
                    resimRefarans.downloadURL { (url, error) in
                        if error == nil {
                            // hata yok ise
                            
                            
                            let resimUrl = url?.absoluteString
                            print("Paylaş resim url si : \(resimUrl!)")
                            
                            // DATABASE
                            
                            
                            let fireStoreDataBase = Firestore.firestore()
                            
                            var fireSoreRefarans : DocumentReference? = nil
                            
                            let fireStoreMesaj = ["resimUrl" : resimUrl!, "KiminMesaji" : Auth.auth().currentUser!.email!, "mesajYorum" : self.textPaylas.text!, "Tarih" : FieldValue.serverTimestamp(), "Begeni" : 0] as [String : Any]
                            
                            
                            fireSoreRefarans = fireStoreDataBase.collection("mesaj").addDocument(data: fireStoreMesaj, completion: { (error) in
                                
                                if error != nil {
                                    
                                    
                                    self.uyarlamak(titleNot: "Hata!", messageNot: error?.localizedDescription ?? "Hata Var")
                                    
                                } else {
                                    
                                    self.resimPaylas.image = UIImage(named: "paylasResim.png")
                                    self.textPaylas.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                                
                                
                                
                            })
                            
                         
                        
                        
                        }
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    

}
