//
//  anaSayfaVC.swift
//  instagramClone
//
//  Created by Yusuf ARİTÜRK on 24.03.2020.
//  Copyright © 2020 Yusuf ARİTÜRK. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class anaSayfaVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
 

    @IBOutlet weak var tableView: UITableView!
        var kullaniciEmailDegis = [String]()
        var kullaniciYorumDegis = [String]()
        var kullaniciBegeniDegis = [Int]()
        var kullaniciResimDegis = [String]()
        var kullaniciDokumanID = [String]()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
        
        
        
        veriAlmaFireStore()
        
    }
    
    
    func veriAlmaFireStore() {
               
               let dataBaseFireStore = Firestore.firestore()
               
        dataBaseFireStore.collection("mesaj").order(by: "Tarih", descending: true).addSnapshotListener { (snapshot, error) in
                   if error != nil {
                       print(error?.localizedDescription)
                   } else {
                       
                       if snapshot?.isEmpty != true && snapshot != nil {
                 
                        self.kullaniciResimDegis.removeAll(keepingCapacity: false)
                        self.kullaniciBegeniDegis.removeAll(keepingCapacity: false)
                        self.kullaniciEmailDegis.removeAll(keepingCapacity: false)
                        self.kullaniciYorumDegis.removeAll(keepingCapacity: false)
                        self.kullaniciDokumanID.removeAll(keepingCapacity: false)
                        
                        
                       
                           for document in snapshot!.documents {
                               let dokumanID = document.documentID
                               self.kullaniciDokumanID.append(dokumanID)
                               
                               
                               
                               if let kiminMesaji = document.get("KiminMesaji") as? String {
                                   self.kullaniciEmailDegis.append(kiminMesaji)
                               }
                               
                               if let mesajYorum = document.get("mesajYorum") as? String {
                                   self.kullaniciYorumDegis.append(mesajYorum)
                               }
                               
                               if let Begeni = document.get("Begeni") as? Int {
                                   self.kullaniciBegeniDegis.append(Begeni)
                               }
                                    
                               if let resimUrl = document.get("resimUrl") as? String {
                                   self.kullaniciResimDegis.append(resimUrl)
                               }
                               
                               
                               
           
                           }
                           
                           self.tableView.reloadData()
                           
                       }
                       
                       
                       
                   }
               }
               
               
               
               
               
           }
           
           
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kullaniciEmailDegis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! anaSayfaCell
        cell.labelKullaniciMailCell.text = kullaniciEmailDegis[indexPath.row]
        cell.labelKullaniciYorumCell.text = kullaniciYorumDegis[indexPath.row]
        cell.labelKullaniciBegeniSayisiCell.text = String(kullaniciBegeniDegis[indexPath.row])
        cell.resimKullaniciCell.sd_setImage(with: URL(string: self.kullaniciResimDegis[indexPath.row]))
        cell.labelKullaniciTarihCell.text = kullaniciDokumanID[indexPath.row]
        return cell
    }

    
    
    
}
