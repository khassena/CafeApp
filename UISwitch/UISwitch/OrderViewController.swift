//
//  SecondViewController.swift
//  UISwitch
//
//  Created by Amanzhan Zharkynuly on 18.09.2022.
//

import UIKit

public enum Costs: Double {
    case booking = 0.00
    case prepaiment = -5.00
    case vipRoom = 30.00
    case ceaserSalad = 6.99
}

class OrderViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var amountOfGuestsTF: UITextField!
    @IBOutlet weak var tableNumberTF: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var billButtonOutlet: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    public var totalBill: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextFields()
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func billCheckButton(_ sender: UIButton) {
        for info in textFields {
            guard let texts = info.text, texts.count != 0 else {
                return checkTextFieldsEmpty("Please enter \(info.restorationIdentifier ?? "nil")")
            }
        }
        billAlert()
    }
    
    private func checkTextFieldsEmpty(_ message: String) {
        errorMessage.isHidden = false
        errorMessage.textColor = .red
        errorMessage.numberOfLines = 0
        errorMessage.text = message
        billButtonOutlet.shake()
    }
    
    private func billAlert() {
        let alertController = UIAlertController(title: "Выставить счет?", message: "нажмите - Да", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Да", style: .default) { [self]_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let billVC = storyboard.instantiateViewController(withIdentifier: "BillVC") as? BillViewController else { return }
            billVC.fioCustomer = self.nameTF.text
            billVC.elseInfoCustomer = "\(self.amountOfGuestsTF.text!) гостей, за \(self.tableNumberTF.text!) столиком"
            
            for item in switches {
                if item.isOn {
                    switch item.tag {
                    case 0: _ = (billVC.tempStackView.append(UIStackView.createStackView(item.restorationIdentifier!, Costs.booking)), totalBill += Costs.booking.rawValue)
                    case 1: _ = (billVC.tempStackView.append(UIStackView.createStackView(item.restorationIdentifier!, Costs.prepaiment)), totalBill += Costs.prepaiment.rawValue)
                    case 2: _ = (billVC.tempStackView.append(UIStackView.createStackView(item.restorationIdentifier!, Costs.vipRoom)), totalBill += Costs.vipRoom.rawValue)
                    default: break
                    }
                }
            }
            billVC.tempStackView.removeFirst()

            totalBill += Costs.ceaserSalad.rawValue
            billVC.totalCostCustomer = "Итого: " + String(round(totalBill * 100) / 100.0) + "$"
            self.show(billVC, sender: nil)
            totalBill = 0
        }
        let action2 = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(action2)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setUpTextFields() {
        errorMessage.isHidden = true
        for texts in textFields {
            texts.createBottomLine()
        }
    }

}

extension UIStackView {
    static func createStackView(_ service: String, _ cost: Costs) -> UIStackView {
        let serviceLabel = UILabel()
        let costLabel = UILabel()
        costLabel.font = UIFont.systemFont(ofSize: 19)
        serviceLabel.font = UIFont.systemFont(ofSize: 19)
        serviceLabel.text = service
        costLabel.text = "\(cost.rawValue)$"
        let stackView = UIStackView(arrangedSubviews: [serviceLabel, costLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10.0
        stackView.subviews.last?.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return stackView
    }
}


