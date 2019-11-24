//
//  ListaController.swift
//  Marvel
//
//  Created by Máster Móviles on 07/11/2019.
//  Copyright © 2019 Universidad de Alicante. All rights reserved.
//

import UIKit
import Marvelous

class ListaController: UIViewController, UISearchBarDelegate {
    
    //MARK: Properties
    var comics: [RCComicsObject] = []
    var titles: [String] = []
    @IBOutlet weak var comicTV: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let marvelAPI = RCMarvelAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marvelAPI.publicKey = "a6927e7e15930110aade56ef90244f6d"
        marvelAPI.privateKey = "487b621fc3c0d6f128b468ba86c99c508f24d357"
        self.activityIndicator.hidesWhenStopped = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.bringSubviewToFront(self.activityIndicator)
        self.activityIndicator.startAnimating()
        mostrarComics(comienzanPor: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func mostrarComics(comienzanPor cadena : String) {
        let filtro = RCComicsFilter()
        filtro.titleStartsWith = cadena
        
        marvelAPI.comics(by: filtro) {
            resultados, info, error in
            if let comics = resultados as! [RCComicsObject]? {
                for comic in comics {
                    self.comics.append(comic)
                    self.titles.append(comic.title)
                }
                
                OperationQueue.main.addOperation() {
                    let miDS = self.comicTV.dataSource as! DSComicTable
                    miDS.setData(data: self.titles)
                    self.comicTV.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "itemDetail") {
            if let detail = segue.destination as? DetalleViewController {
                detail.oComic = comics[self.comicTV.indexPathForSelectedRow!.row]
            }
        }
    }

}
