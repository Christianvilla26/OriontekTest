//
//  ViewController.swift
//  OriontekClients
//
//  Created by Christian Villa Rhode on 5/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ClientNameTextField: UITextField!
    
    @IBAction func CreateClient(_ sender: UIButton) {
        ClientService.shared.CreateClient(ClientName: ClientNameTextField.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

