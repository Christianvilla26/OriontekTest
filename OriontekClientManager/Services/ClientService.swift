//
//  ClientService.swift
//  OriontekClients
//
//  Created by Christian Villa Rhode on 5/5/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ClientService {
    static let shared = ClientService()
    let db = Firestore.firestore()
    
    func getClients(success: @escaping (_ clientes: [ClientModel]) -> (), failure: @escaping (_ error: String?) -> ()){
        var ClientArray:[ClientModel] = []
            db.collection("OriotekClients").getDocuments{ (document, error) in
            if let document = document {
                document.documents.forEach { (Documento) in
                    let tempClient = ClientModel(id: Documento.documentID , name:  Documento.data()["name"] as? String , directions: [])
                    ClientArray.append(tempClient)
                    print(Documento.data()["name"] ?? "No entiendo map")
                    print(Documento.data()["Directions"] ?? "No entiendo map")
                    print("Cached document data: \(Documento.data())")
                }
                print(ClientArray)
                success(ClientArray)
            } else {
                failure("Document does not exist in cache")
              print("Document does not exist in cache")
            }
          }
        
    }
    
    func CreateClient(ClientName: String) {
        db.collection("OriotekClients").addDocument(data: [
            "name": ClientName
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    func getClientsDirections(id:String, success: @escaping (_ direciones: [Directions]) -> (), failure: @escaping (_ error: String?) -> ()){
        var DirectionsArray:[Directions] = []
        let _: Void = db.collection("OriotekClients").document(id).collection("Directions").getDocuments{ (document, error) in
            if let document = document {
                document.documents.forEach { (Documento) in
                    let tempDirection = Directions(id: Documento.documentID, streetName: Documento.data()["streetName"] as! String , name: Documento.data()["name"] as! String, postalCode: Documento.data()["postalCode"] as! String)
                    DirectionsArray.append(tempDirection)
                }
                success(DirectionsArray)
            
            } else {
                failure("Document does not exist in cache")
              print("Document does not exist in cache")
            }
          }
            
    }
    
    func CreateDirection(ClientID: String, Direction: Directions) {
        db.collection("OriotekClients").document(ClientID).collection("Directions").addDocument(data: [
            "streetName": Direction.streetName,
            "name": Direction.name,
            "postalCode": Direction.postalCode
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func DeleteRecord(ClientID: String){
        db.collection("OriotekClients").document(ClientID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func DeleteUserDirection(ClientID: String, Direction: Directions){
        db.collection("OriotekClients").document(ClientID).collection("Directions").document(Direction.id!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    
    
    
    
    
}
