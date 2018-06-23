//
//  UIImageExtension.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache <AnyObject,AnyObject>()

extension UIImage {
    
    func imageFromServer(urlString: String, completion: @escaping (UIImage) -> Void) {
        let blank = #imageLiteral(resourceName: "default")
        guard let url = URL(string: urlString) else { completion(blank); return }
        
        NetworkService.sharedInstance.fetchRocketImage(imageURL: url) { (imageData) in
            if let imageData = imageData,
                let image = UIImage(data: imageData) {
                completion(image)
            } else {
                completion(blank)
            }
        }
    }
}

extension UIImageView {
    
    func loadUsingCache(_ theUrl: String) {
        
        self.image = #imageLiteral(resourceName: "default")
        
        //check cache for image
        if let cachedImage = imageCache.object(forKey: theUrl as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise download it
        guard let url = URL(string: theUrl) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            
            //print error
            if (error != nil){
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: theUrl as AnyObject)
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}

extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    public func presentNormalNavigationBar() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
        navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationController?.navigationBar.tintColor = .white
        
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
