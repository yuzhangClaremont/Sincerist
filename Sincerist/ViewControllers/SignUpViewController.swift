//
//  SignUpViewController.swift
//  Sincerist
//
//  Created by Yun Zhang on 8/24/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase



class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passWordText: UITextField!
    
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    

    
    // check field and falidate th edata. if correct, return nil, otherwise, return error message
    func validateFields() -> String?{
        // check all fields are filled in
        let userName = userNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passWordText.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPW = confirmPasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if userName == "" || email == "" || password == "" || confirmPW == ""
            {
                return "Please fill in all fields."
            }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: emailText.text!)
            {
               return "Your email pattern is not valid."
            }
        
        if passWordText.text! != confirmPasswordText.text!
            {
                return "Passwords do not match."
            }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any)
    {
        
        // validate the fields
        let error = validateFields()
        let userName = userNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passWordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let confirmPW = confirmPasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if error != nil
        {
            self.errorLabel.text = error
            self.errorLabel.alpha = 1
        }else{
            // create the user
            // double click authdata to open closure
            Auth.auth().createUser(withEmail: email, password: password)
            { (result, err) in             // return to a tuple
                print("result\(String(describing: result)), error:\(String(describing: err))")
                if err != nil
                {
                    self.errorLabel.text = "Error creating user"
                    self.errorLabel.alpha = 1
                }else
                {
                    self.errorLabel.alpha = 0
                    let db = Firestore.firestore()
                    // Add a new document with a generated ID
//                    var ref: DocumentReference? = nil
                    db.collection("users").addDocument(data: [
                        "userName": userName,
                        "email": email,
                        "password": password,
                        "bio": "Start your new journey with Sincerist",
                        "uid": result!.user.uid
                    ])
                    { err in
                        if err != nil
                        {
                            self.errorLabel.text = "error saving user data "
                            self.errorLabel.alpha = 1
                        }
//                        if let err = err {
//                            print("Error adding document: \(err)")
//                        } else {
//                            print("Document added with ID: \(ref!.documentID)")
//                        }
                    }
                }
            }
            // transition to the home screen
            self.transitionToHome()
           
        }

    }
    
    func transitionToHome()
    {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController // where store HomeVC in constants
        
        view.window?.rootViewController = homeViewController // the id of view Controller
        view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0

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
