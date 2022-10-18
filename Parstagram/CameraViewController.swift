//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Sunny Yu on 10/10/22.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var commenField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts") //dict
        
        post["caption"] = commenField.text
        post["author"] = PFUser.current()! //whoever is logged in
        
        let imageData = imageView.image?.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                // dismiss exits out of the post page and go back to the prev page
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }
            else {
                print("error saving!")
            }
        }
        
        
        
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        // take a pic, shows the pic, edit the pic
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // upon tapping on the camera button, the photo album/camera will pop
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // if camera is avaliable -> default: open up camera
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
            
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
