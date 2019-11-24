//
//  DSComicTable.swift
//  Marvel
//
//  Created by Máster Móviles on 07/11/2019.
//  Copyright © 2019 Universidad de Alicante. All rights reserved.
//

import Foundation
import UIKit

class DSComicTable: NSObject, UITableViewDataSource {
    
    //MARK: Data
    var lista = [String]()
    
    func setData(data: [String]) {
        self.lista = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nuevaCelda = tableView.dequeueReusableCell(withIdentifier: "comicCell", for: indexPath)
        nuevaCelda.textLabel?.text = lista[indexPath.row]
        
        return nuevaCelda
    }
    
}
