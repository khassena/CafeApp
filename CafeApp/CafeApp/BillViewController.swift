//
//  BillViewController.swift
//  UISwitch
//
//  Created by Amanzhan Zharkynuly on 19.09.2022.
//

import UIKit

class BillViewController: UIViewController {

    var fioCustomer: String?
    var elseInfoCustomer: String?
    var servicesCustomer: String?
    var costServices: String?
    var tempStackView: [UIStackView] = [UIStackView()]
    var totalCostCustomer: String?
    
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var elseInfolabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var rootStackView: UIStackView!
    @IBOutlet weak var totalCost: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for stack in tempStackView {
            rootStackView.addArrangedSubview(stack)
            print(stack)
        }
        fioLabel.text = fioCustomer
        elseInfolabel.text = elseInfoCustomer
        servicesLabel.text = "Салат цезарь"
        costLabel.text = "\(Costs.ceaserSalad.rawValue)$"
        totalCost.text = totalCostCustomer
        self.hideKeyboardWhenTappedAround() 
    }


}
