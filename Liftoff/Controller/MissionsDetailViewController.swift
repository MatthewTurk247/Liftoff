//
//  MissionsDetailViewController.swift
//  Rockety
//
//  Created by Antoine Bellanger on 22.05.18.
//  Copyright © 2018 Antoine Bellanger. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import SafariServices
import SwiftLinkPreview

class MissionsDetailViewController: UITableViewController, MKMapViewDelegate {
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    @IBOutlet weak var launchTextView: UITextView!
    @IBOutlet weak var rocketTextView: UITextView!
    @IBOutlet weak var launchMapView: MKMapView!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var rocketImageView: UIImageView!
    
    var downloaded = false
    var isComingFromAgency = false
    var hasinfoURL = false
    var hasWikiURL = false
    
    var mission: Mission? {
        didSet {
            configureView()
        }
    }
    var rocket: Rocket? {
        didSet {
            configureView()
        }
    }
    
    var launch: Launch? {
        didSet {
            configureView()
        }
    }
    var rocketAPI: API.Rocket = .rocket999
    
    var missionPayloadType: Payloads = .notAvailable
    
    func configureView() {
        // Update the user interface for the detail item.
        if let launch = launch {
            if !launch.missions.isEmpty {
                if let textView = rocketTextView {
                                do {
                        let string = try String(contentsOf: URL(string: rocketAPI.descriptionURL())!).replacingOccurrences(of: "\\n", with: "\n")
                        textView.text = string
                    } catch {
                        print("Error")
                        textView.text = "No description available for this rocket."
                    }
                }
                if let textView = launchTextView {
                    textView.text = launch.missions[0].missionDescription
                }
            } else {
                if let textView = rocketTextView {
                    textView.text = "N/A"
                }
                if let textView = launchTextView {
                    textView.text = "N/A"
                }
            }
//            if let mission = launch.missions.first {
//                if let textView = launchTextView {
//                    textView.text = String(mission.description)
//                }
//            }
            if let map = launchMapView {
                let loc = CLLocation(latitude: launch.location.pads[0].latitude, longitude: launch.location.pads[0].longitude)
                map.centerToLocation(loc)
                let pin = MKPointAnnotation()
                pin.title = launch.name
                pin.coordinate = CLLocationCoordinate2D(latitude: launch.location.pads[0].latitude, longitude: launch.location.pads[0].longitude)
                map.addAnnotation(pin)
            }
            if let countdown = countdownLabel {
                switch launch.status {
                case 1:
                    countdown.textColor = UIColor(named: "Mint Leaf")
                case 2:
                    countdown.textColor = UIColor(named: "Chi-Gong")
                default:
                    countdown.textColor = UIColor(named: "Exodus Fruit")
                }
                countdown.text = launch.net
            }
            
        } else {
            self.tableView.isHidden = true
        }
        
        if let launch = launch {
            title = launch.name
        }
        
        if let imageView = rocketImageView {
            downloadImage(url: URL(string: rocketAPI.imageURL())!, imageView: imageView)
        }
    }
    
    override func viewDidLoad() {
        let slp = SwiftLinkPreview(session: URLSession.shared,
        workQueue: SwiftLinkPreview.defaultWorkQueue,
        responseQueue: DispatchQueue.main,
            cache: DisabledCache.instance)
        if let id = launch?.rocket.id {
            rocketAPI = API.Rocket(id: id)
        }
        
        configureView()
    }
    
   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 1:
                if let links = mission?.links {
                    if links.article_link != nil {
                        print(links.article_link)
                    } else if links.reddit_campaign != nil {
                        print(links.reddit_campaign)
                    }
                }
            case 2:
                let vc = SFSafariViewController(url: URL(string: "https://wikipedia.org")!)
                present(vc, animated: true, completion: nil)
                print("wiki")
            default:
                print()
            }
        }
    }*/
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView: UIImageView) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print("Download Finished")
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 5000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
