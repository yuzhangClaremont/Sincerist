//
//  HomeViewController.swift
//  Sincerist
//
//  Created by Yun Zhang on 8/24/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    @IBAction func logOutTapped(_ sender: Any) {
        // sign in user
        do {
            try  Auth.auth().signOut()
            // in closure you need self?
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as? ViewController // where store HomeVC in constants
            
            self.view.window?.rootViewController = ViewController // the id of view Controller
            self.view.window?.makeKeyAndVisible()
        } catch let err {
            print(err)
        }
       
        
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if error != nil
//            {
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
//            }else{
//                // in closure you need self?
//                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController // where store HomeVC in constants
//
//                self.view.window?.rootViewController = homeViewController // the id of view Controller
//                self.view.window?.makeKeyAndVisible()
//            }
//        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
