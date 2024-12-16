//
//  ViewController.swift
//  UIKitTextFieldExample
//
//  Created by Kader Kaya on 16.12.2024.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var activityIn:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        successLabel.isHidden = true
    }
    var userName = "kaderkaaaya"
    let password = "Kader12."
    @IBAction func didTapButton(_ sender: UIButton) {
        print("UserName: \(String(describing: firstText.text))")
        print("Password: \(secondText.text ?? "Şifre girilmedi.") ")
        print(successLabel.text ?? "no")
        let firstTextValue = firstText.text
        let secondTextValue = secondText.text
        
        if firstTextValue == nil || (firstTextValue != userName) {
            label.isHidden = false
            label.text = "Kullanıcı adınız yanlış ya da eksik"
            label.textColor = UIColor.red
        }
        else if secondTextValue == nil || (secondTextValue != password) {
            label.isHidden = false
            label.text = "Şifreniz eksik ya da yanlış"
            label.textColor = UIColor.blue
        }
        else {
            successLabel.isHidden = false
            successLabel.textColor = UIColor.purple
            label.isHidden = true
        }
        
        if(userName == firstTextValue && password == secondTextValue ) {
            activityIn.startAnimating()
        }
      
    }
     

    

}

