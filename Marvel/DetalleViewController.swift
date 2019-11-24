//
//  DetalleViewController.swift
//  Marvel
//
//  Created by Máster Móviles on 07/11/2019.
//  Copyright © 2019 Universidad de Alicante. All rights reserved.
//

import UIKit
import Marvelous

class DetalleViewController: UIViewController {
    
    //MARK: Properties
    var oComic = RCComicsObject()
    @IBOutlet weak var oTitle: UILabel!
    @IBOutlet weak var oDescription: UITextView!
    @IBOutlet weak var oImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let title = oComic.title {
            self.oTitle.text = title
        }
        
        self.oDescription.text = oComic.summary
        
        OperationQueue().addOperation {
            if let thumb = self.oComic.thumbnail {
              let url = "\(thumb.basePath!)/portrait_uncanny.\(thumb.extension!)"
              let urlHttps = url.replacingOccurrences(of: "http", with: "https")
                if let urlFinal = URL(string:urlHttps) {
                    do {
                       let datos = try Data(contentsOf:urlFinal)
                        if let img = UIImage(data: datos) {
                            OperationQueue.main.addOperation {
                                self.oImage.image = img
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "imageDetail") {
            if let detail = segue.destination as? ImageViewController {
                detail.oComic = oComic
            }
        }
    }
    
    @IBAction func imageUnwind(segue: UIStoryboardSegue) {
        
    }

}
