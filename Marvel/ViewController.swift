//
//  ViewController.swift
//  Marvel
//
//  Created by Otto Colomina Pardo on 5/11/17.
//  Copyright © 2017 Universidad de Alicante. All rights reserved.
//

import UIKit
import Marvelous


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mostrarPersonajes(comienzanPor: "Spider")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mostrarPersonajes(comienzanPor cadena : String) {
        let marvelAPI = RCMarvelAPI()
        //PUEDES CAMBIAR ESTO PARA PONER TUS CLAVES
        marvelAPI.publicKey = "a6927e7e15930110aade56ef90244f6d"
        marvelAPI.privateKey = "487b621fc3c0d6f128b468ba86c99c508f24d357"
        let filtro = RCCharacterFilter()
        filtro.nameStartsWith = cadena
        marvelAPI.characters(by: filtro) {
            resultados, info, error in
            if let personajes = resultados as! [RCCharacterObject]? {
                for personaje in personajes {
                    if let name = personaje.name {
                        print(name)
                    }
                }
                print("Hay \(personajes.count) personajes")
            }
        }
    }


}

