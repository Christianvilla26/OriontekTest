//
//  DirectionsTableViewController.swift
//  OriontekClients
//
//  Created by Christian Villa Rhode on 5/5/21.
//

import UIKit

class DirectionsTableViewController: UITableViewController {

    var SelectedClient = ClientModel(id: "", name: "")
    var DirectionArray: [Directions] = []
    
    @IBOutlet var DirectionsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        ClientService.shared.getClientsDirections(id: SelectedClient.id!) { (direciones) in
            self.DirectionArray = direciones
            self.DirectionsTable.reloadData()
            print(self.DirectionArray)
        } failure: {
            (error) in
            print(error!)
        }

        print(SelectedClient)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DirectionArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionCell", for: indexPath)
        cell.textLabel?.text = DirectionArray[indexPath.row].name
        cell.detailTextLabel?.text = DirectionArray[indexPath.row].streetName
        // Configure the cell...

        return cell
    }
    
    
    
     @IBAction func OpenModal(_ sender: UIButton) {
        let SelectedClient: ClientModel = self.SelectedClient
        self.performSegue(withIdentifier: "DirectionModal", sender: SelectedClient)
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Oriontek Client Manager", message: "Select one option above", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {_ in
            ClientService.shared.DeleteUserDirection(ClientID: self.SelectedClient.id!, Direction: self.DirectionArray[indexPath.row])
            self.DirectionArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DirectionModal"
        {
            let SelectedClient = sender as! ClientModel
            let DirectionModal:DirectionsModalViewContreoller = segue.destination as! DirectionsModalViewContreoller
            DirectionModal.SelectedClient = SelectedClient
        }
        if segue.identifier == "editDirection"
        {
            let TempSrtuct = sender as! Dictionary<String, Directions>
            let DirectionModal:DirectionsModalViewContreoller = segue.destination as! DirectionsModalViewContreoller
            DirectionModal.TempSrtuct = TempSrtuct
        }
    }
    
}
