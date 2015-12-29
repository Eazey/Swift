//
//  CityTableViewController.swift
//  WeatherOne
//
//  Created by WJnight on 15/11/30.
//  Copyright (c) 2015年 WJnight. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController,UISearchBarDelegate {
    
    //MARK: - Loading
    
    //读取plist文件
    var data = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("city", ofType: "plist")!)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let number = data?.count
        return number!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfSection = data?.allValues[section] as NSArray
        return numberOfSection.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title:AnyObject? = data?.allKeys[section]
        return title as? String
    }
    
    //cell里面放一行中的所有数据，例如苹果手机设置界面，一行有image，txt等
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //indexPath是个结构体，存放着哪一块和哪一行
        let cell = tableView.dequeueReusableCellWithIdentifier("testCell", forIndexPath: indexPath) as UITableViewCell
        let cityOfSectionIndex = data?.allValues[indexPath.section] as NSArray
        // Configure the cell...
        cell.textLabel?.text = cityOfSectionIndex[indexPath.row] as? String
        cell.imageView?.image = UIImage(named: "cityImage6")
        return cell
    }
    
    //点击cell时要做的事
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //get value
        let a = data?.allValues[indexPath.section] as? NSArray
        let b:AnyObject = a!.objectAtIndex(indexPath.row)
        //get Document path and create a son path.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as NSString
        let path = documentsDirectory.stringByAppendingPathComponent("LocalText.plist")
        //save dict in path
        let dict:NSMutableDictionary = ["cityName":"dalian"]
        dict.setObject(b, forKey: "cityName")
        dict.writeToFile(path, atomically: false)
        //查看path中被存储的文件
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Saved Test.plist file is --> \(resultDictionary?.description)")
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    //MARK: - Search bar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.data = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("city", ofType: "plist")!)
        }else{
            let searchArray = NSMutableArray()
            for values in self.data!.allValues{
                for cityName in values as NSArray{
                    if cityName.lowercaseString.hasPrefix(searchText){
                        searchArray.addObject(cityName)
                    }
                }
            }
            let searchData:NSDictionary = ["检索到的城市":searchArray]
            //Save new List in newCity.plist
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            let documentsDirectory = paths.objectAtIndex(0) as NSString
            let path = documentsDirectory.stringByAppendingPathComponent("newCity.plist")
            searchData.writeToFile(path, atomically:true)
            
            self.data = NSDictionary(contentsOfFile:path)
        }
        //update TableView
        self.tableView.reloadData()
    }

}
