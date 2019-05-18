//
//  ViewController.swift
//  Test
//
//  Created by Sandeep Ahuja on 5/17/19.
//  Copyright © 2019 Sandeep Ahuja. All rights reserved.
//

import UIKit

struct Country {
    var name = ""
    var alpha2Code = ""
    var alpha3Code = ""
}
class ViewController: UIViewController {

    let url_Str = "https://restcountries.eu/rest/v2/all"
    
    var toDoListArray:[Country] = []
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlRequest = URLRequest.init(url: URL.init(string: url_Str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        urlRequest.allHTTPHeaderFields = ["content-type":"application/json"]
        urlRequest.httpMethod = "get"
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil{
                if let JsonArray = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:Any]] {
                    
                    for dict in JsonArray{
                        self.toDoListArray.append(Country.init(name: dict["name"] as? String ?? "", alpha2Code: dict["alpha2Code"] as? String ?? "", alpha3Code: dict["alpha3Code"] as? String ?? ""))
                        
                    }
//                    print(self.toDoListArray.description)
                    DispatchQueue.main.async {
                        Thread.sleep(forTimeInterval: 1)
                        self.tblView.reloadData()
                    }
                }
            }else{
                print("error")
            }
            
        }
        task.resume()
        
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell")
        
        let data = toDoListArray[indexPath.row]
        
        cell?.textLabel?.text = data.name
        cell?.textLabel?.font = UIFont(name:"Avenir-Heavy", size: 20)
        
        
        return cell!
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        secondVC?.alpha2 = toDoListArray[indexPath.row].alpha2Code
        secondVC?.alpha3 = toDoListArray[indexPath.row].alpha3Code
        
        self.navigationController?.pushViewController(secondVC!, animated: true)
    }
    
}

