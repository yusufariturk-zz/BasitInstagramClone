//
//  ayalarrVC.swift
//  instagramClone
//
//  Created by Yusuf ARİTÜRK on 24.03.2020.
//  Copyright © 2020 Yusuf ARİTÜRK. All rights reserved.
//

import UIKit
import Firebase

class ayarlarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonCikis(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "gitViewController", sender: nil)
            
        } catch {
            
        }
        
    }
    

}
