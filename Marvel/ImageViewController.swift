//
//  ImageViewController.swift
//  Marvel
//
//  Created by Máster Móviles on 17/11/2019.
//  Copyright © 2019 Universidad de Alicante. All rights reserved.
//

import UIKit
import Marvelous

class ImageViewController: UIViewController {
    
    // MARK: Properties
    var oComic = RCComicsObject()
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        OperationQueue().addOperation {
            if let thumb = self.oComic.thumbnail {
              let url = "\(thumb.basePath!).\(thumb.extension!)"
              let urlHttps = url.replacingOccurrences(of: "http", with: "https")
                if let urlFinal = URL(string:urlHttps) {
                    do {
                       let datos = try Data(contentsOf:urlFinal)
                        if let img = UIImage(data: datos) {
                            OperationQueue.main.addOperation {
                                self.image.image = img
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
}
