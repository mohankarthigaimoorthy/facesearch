//
//  ViewController.swift
//  faceSearch
//
//  Created by Imcrinox Mac on 25/12/1444 AH.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nametxtField: UITextField!
    @IBOutlet weak var searchPerson: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        nametxtField.delegate = self
        self.searchPerson.alpha = 0
        self.searchPerson.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let textFieldContent = textField.text {
            
            do {
                try wikiPedia.faceForPerson(textFieldContent, size: CGSize(width: 300, height: 400), completion: { (image: UIImage?, imageFound: Bool) -> () in
                    if imageFound == true {
                        DispatchQueue.main.async {
                            
                            self.searchPerson.image = image
                            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { () -> Void
                                in
                                
                                self.searchPerson.transform = CGAffineTransform(scaleX: 1, y: 1)
                                self.searchPerson.alpha = 1
                                
                                self.searchPerson.layer.shadowOpacity = 0.4
                                self.searchPerson.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
                                self.searchPerson.layer.shadowRadius = 15.0
                                self.searchPerson.layer.shadowColor = UIColor.black.cgColor
                            },completion: nil)
                        }
                    }
        })
                
            }
            catch wikiPedia.WikiFaceError.CouldNotDownloadImage{
                print("Could not access wikipedia for downloading an image")

            }
            catch {
                print(error)
            }
        }
        return true
        
    }

}

