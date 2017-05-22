//
//  ViewController.swift
//  testmysql
//
//  Created by Jirawut on 5/13/2560 BE.
//  Copyright © 2560 karmolrut. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var sement_out: UISegmentedControl!
    
    
    @IBOutlet weak var label_singin: UILabel!
    
    
    @IBOutlet weak var usernamee: UITextField!
    
    @IBOutlet weak var passwords: UITextField!
    
    @IBOutlet weak var submit: UIButton!
    
    var isSignIn:Bool = true
    
    
 
    
    @IBAction func submit(_ sender: UIButton) {
        if let users = usernamee.text, let pass = passwords.text {
        
        if isSignIn{
            FIRAuth.auth()?.signIn(withEmail: users, password:pass, completion: { (user, error) in
                if let u = user {
                self.performSegue(withIdentifier: "tabbar", sender: self)
                }
                else{
                    
                }
                
            })
            }
        else {
            FIRAuth.auth()?.createUser(withEmail: users, password: pass, completion: { (user, error) in
                if let u = user {
                self.performSegue(withIdentifier: "tabbar", sender: self)
                }
                else{
                }
            })
        }
        }
        }
        
    
    
    @IBAction func singregit(_ sender: UISegmentedControl) {
        isSignIn = !isSignIn
        if isSignIn{
            
        label_singin.text = "Sing In"
            submit.setTitle("Sing In", for: .normal)
        }
        else {
            label_singin.text = "Register"
            submit.setTitle("Register", for: .normal)
        }
    }
    
    //hide keyboard when user tapps on return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.usernamee.delegate = self
        self.passwords.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
}




