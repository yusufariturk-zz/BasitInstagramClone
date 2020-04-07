//
//  anaSayfaCell.swift
//  instagramClone
//
//  Created by Yusuf ARİTÜRK on 30.03.2020.
//  Copyright © 2020 Yusuf ARİTÜRK. All rights reserved.
//

import UIKit
import Firebase

class anaSayfaCell: UITableViewCell {
    @IBOutlet weak var labelKullaniciMailCell: UILabel!
    @IBOutlet weak var labelKullaniciTarihCell: UILabel!
    @IBOutlet weak var resimKullaniciCell: UIImageView!
    @IBOutlet weak var labelKullaniciYorumCell: UILabel!
    @IBOutlet weak var labelKullaniciBegeniSayisiCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonKullaniciBegeniCell(_ sender: Any) {
        
        let fireStoreDataBase = Firestore.firestore()
        if let begeniYap = Int(labelKullaniciBegeniSayisiCell.text!) {
            
            let begeniAl = ["Begeni" : begeniYap + 1] as [String : Any]
            
            fireStoreDataBase.collection("mesaj").document(labelKullaniciTarihCell.text!).setData(begeniAl, merge: true)
            
            
        }
        
        
       
        
        
        
    }
    
}
