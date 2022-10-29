//
//  ViewController.swift
//  UISwitch
//
//  Created by Amanzhan Zharkynuly on 17.09.2022.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var signInButtonOutlet: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var stackViewEmail: UIStackView!
    
    var iconClick = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        self.hideKeyboardWhenTappedAround() 
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        for texts in textFields {
            guard let temp = texts.text, temp.count != 0 else {
                return checkEmailPassword("Please enter \(texts.restorationIdentifier!)")
            }
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: "OrderVC") as? OrderViewController else { return }
        errorMessage.isHidden = true
        show(secondVC, sender: nil)
    }
    
    private func checkEmailPassword(_ message: String) {
        errorMessage.text = message
        errorMessage.textColor = .red
        errorMessage.isHidden = false
        signInButtonOutlet.shake()
    }
    
    private func setupTextField() {
        errorMessage.isHidden = true
        for texts in textFields {
            texts.createBottomLine()
        }
        imageIcon.image = UIImage(named: "closed-eye")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if iconClick {
            iconClick = false
            imageIcon.image = UIImage(named: "open-eye")
        } else {
            iconClick = true
            imageIcon.image = UIImage(named: "closed-eye")
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    
}

extension UITextField {
    func createBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2.0, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}

extension UIButton {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
