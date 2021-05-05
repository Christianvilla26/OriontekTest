//
//  ClientViewController.swift
//  OriontekClients
//
//  Created by Christian Villa Rhode on 5/5/21.
//

import UIKit

class ClientViewController: UITableViewController {
    
    var ClientArray: [ClientModel] = []
    @IBOutlet var ClientTableView: UITableView!
    
    @IBAction func OpenModal(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }

        
    override func viewWillAppear(_ animated: Bool) {
        ClientService.shared.getClients(){(Client) in
            print("Stop Cargando")
            self.ClientArray = Client
            self.ClientTableView.reloadData()
        } failure: {
            (error) in
            print(error!)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ClientArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell", for: indexPath)
        cell.textLabel?.text = self.ClientArray[indexPath.row].name
        return cell
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Oriontek Client Manager", message: "Select one option above", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Address List", style: .default, handler: {_ in
            let SelectedClient: ClientModel = self.ClientArray[indexPath.row]
            self.performSegue(withIdentifier: "directionDetail", sender: SelectedClient)
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {_ in
            ClientService.shared.DeleteRecord(ClientID: self.ClientArray[indexPath.row].id!)
            self.ClientArray.remove(at: indexPath.row)
            self.ClientTableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "directionDetail"
        {
            let SelectedClient = sender as! ClientModel
            let DirectionsController:DirectionsTableViewController = segue.destination as! DirectionsTableViewController
            DirectionsController.SelectedClient = SelectedClient
        }
    }
}
