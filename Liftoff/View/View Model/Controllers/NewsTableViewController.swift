//
//  NewsTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/14/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SafariServices

typealias RequestCompleted = () -> ()

class Article {
    var author: String!
    var title: String!
    var descriptionTitle: String!
    var publishedAt: String!
    var urlToImage: String!
    var url: String!
    var content: String!
    
    init() {
        
    }
}

class NewsTableViewController: UITableViewController {
    
    let countryCode = "us"
    private let apiKey = "127f06e85b3a49bf91ac8e3ce8ace028"
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=127f06e85b3a49bf91ac8e3ce8ace028")
    var newsItems = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.title = "News"
        
    }
    
    func fetchAppCategories(completed: @escaping RequestCompleted)  {
        
        Alamofire.request(self.url!).responseJSON{
            response in
            
            if let result  = response.result.value as? Dictionary<String, Any>{
                
                if let mainDict = result["articles"] as? [Dictionary<String, Any>]{
                    if !mainDict.isEmpty{
                        for article in mainDict {
                            
                            let newsItem = Article()
                            if let author = article["author"] as? String {
                                newsItem.author = author
                            } else {
                                newsItem.author = ""
                            }
                            if let title = article["title"] as? String {
                                newsItem.title = title
                            } else {
                                newsItem.title = ""
                            }
                            if let descriptionTitle = article["description"] as? String {
                                newsItem.descriptionTitle = descriptionTitle
                            } else {
                                newsItem.descriptionTitle = ""
                            }
                            if let url = article["url"] as? String {
                                newsItem.url = url
                            } else {
                                newsItem.url = ""
                            }
                            if let urlToImage = article["urlToImage"] as? String {
                                newsItem.urlToImage = urlToImage
                            } else {
                                newsItem.urlToImage = ""
                            }
                            if let publishedAt = article["publishedAt"] as? String {
                                newsItem.publishedAt = publishedAt
                            } else {
                                newsItem.publishedAt = ""
                            }
                            
                            self.newsItems.append(newsItem)
                        }
                    }
                }
                completed()
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var i = 0
        fetchAppCategories {
            i = self.newsItems.count
        }
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsIdentifier", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        fetchAppCategories {
            cell.titleLabel.text = self.newsItems[indexPath.row].title
            cell.articleImage.loadUsingCache(self.newsItems[indexPath.row].urlToImage)
            print("INFO", self.newsItems[indexPath.row].author, self.newsItems[indexPath.row].publishedAt)
            // make the cells like Summit and put publication date with the author
            /*if self.newsItems[indexPath.row].descriptionTitle == "" {
                cell.titleLabel.clearConstraints()
                cell.titleLabel.numberOfLines = 0
            } else {
                cell.descriptionTitleLabel.text = self.newsItems[indexPath.row].descriptionTitle
            }*/
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "newsSegue", sender: indexPath)
        fetchAppCategories {
           
            if let url = URL(string: self.newsItems[indexPath.row].url!) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let vc = SFSafariViewController(url: url, configuration: config)
                self.present(vc, animated: true)
            }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/

}
