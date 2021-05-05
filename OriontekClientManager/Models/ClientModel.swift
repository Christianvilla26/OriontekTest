//
//  ClientModel.swift
//  OriontekClients
//
//  Created by Christian Villa Rhode on 5/5/21.
//

import Foundation


struct ClientResponse {
    let results: [String:ClientModel]
}

struct DataBaseModel: Decodable {
    let id: String?;
    
}


struct ClientModel {
    
    let id: String?
    let name: String?
    var directions: [Directions]?
    

}

struct Directions: Decodable {
    var id: String?;
    var streetName: String;
    var name: String;
    var postalCode: String;
}
