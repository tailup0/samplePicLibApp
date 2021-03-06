//
//  ViewController.swift
//  samplePicLibApp
//
//  Created by Muneharu Onoue on 2017/03/26.
//  Copyright © 2017年 Muneharu Onoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var myImageView: UIImageView!
    var myImagePicker: UIImagePickerController!
    let ud = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        myImagePicker = UIImagePickerController()
        myImagePicker.delegate = self
        myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        if let imgData = ud.object(forKey: "imagekey") as? Data {
            myImageView.image = UIImage(data: imgData)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pick(_ sender: Any) {
        present(myImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer { picker.dismiss(animated: true, completion: nil) }

        guard let myImageAny = info[UIImagePickerControllerOriginalImage] else { return }
        guard let myImage = myImageAny as? UIImage else { return }
        myImageView.image = myImage
        ud.set(UIImageJPEGRepresentation(myImage, 0), forKey: "imagekey")
        ud.synchronize()
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer { picker.dismiss(animated: true, completion: nil) }
    }

}
