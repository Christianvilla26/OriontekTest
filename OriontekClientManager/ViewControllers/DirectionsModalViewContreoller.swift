//
//  DirectionsModalViewContreoller.swift
//  OriontekClients
//
//  Created by Christian Villa Rhode on 5/5/21.
//

import UIKit

class DirectionsModalViewContreoller: UIViewController {
    
    var SelectedClient = ClientModel(id: "", name: "")
    var TempSrtuct: [Any] = []
    @IBOutlet weak var StreetNameTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PostalCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(TempSrtuct)
        
        if(TempSrtuct.count < 0){
            print(TempSrtuct)
            
            StreetNameTextField.text = (TempSrtuct[1] as! Directions).streetName
            NameTextField.text = (TempSrtuct[1] as! Directions).name
            PostalCode.text = (TempSrtuct[1] as! Directions).postalCode
        }
       
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SaveAddress(_ sender: UIButton) {
        let Direction = Directions(streetName: StreetNameTextField.text!, name: NameTextField.text!, postalCode: PostalCode.text!)
        ClientService.shared.CreateDirection(ClientID: SelectedClient.id!, Direction: Direction)
        
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
