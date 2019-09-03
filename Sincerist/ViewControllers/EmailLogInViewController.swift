//
//  EmailLogInViewController.swift
//  Sincerist
//
//  Created by Yun Zhang on 8/24/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailLogInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func submitTapped(_ sender: Any)
    {
        // validate login info

        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // sign in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil
            {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                // in closure you need self?
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController // where store HomeVC in constants
                
                self.view.window?.rootViewController = homeViewController // the id of view Controller
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElements()
    }
    func setupElements(){
        // hide error label
        errorLabel.alpha = 0
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
