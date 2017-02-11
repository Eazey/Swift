//
//  ViewController.swift
//  WeatherOne
//
//  Created by WJnight on 15/11/24.
//  Copyright (c) 2015年 WJnight. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var weatherNew = WeatherDataDeal()
    
    //MARK: - Show Data
    
    //MARK: - ---- Operation
    
    //var opTmp = "°"        //温度
    var opWindLevel = "级" //风力等级
    var opFlTmp = "°"      //体感温度
    var opPcpn = "毫米"    //降雨量
    var opVis = "公里"     //能见度
    var opHum = "%"       //湿度
    var opPres = "百帕"    //气压
    
    //MARK: - ---- Basic Data (Top)
    
    @IBOutlet weak var theCityName: UILabel!
    @IBOutlet weak var nowWeatherDes: UILabel!
    @IBOutlet weak var nowCityTmp: UILabel!
    @IBOutlet weak var basicWeatherUpdateWeekAndTime: UILabel!
    @IBOutlet weak var aqiNumAndQltyNow: UILabel!
    @IBOutlet weak var basicWeatherMaxAndMinTmp: UILabel!
    
    //MARK: - ---- Daily Data (Middle)
    
    @IBOutlet weak var dailyForecastWeekArray1: UILabel!
    @IBOutlet weak var dailyForecastWeatherCodeArray1: UIImageView!
    @IBOutlet weak var dailyForecastTmpMaxArray1: UILabel!
    @IBOutlet weak var dailyForecastTmpMinArray1: UILabel!
    
    @IBOutlet weak var dailyForecastWeekArray2: UILabel!
    @IBOutlet weak var dailyForecastWeatherCodeArray2: UIImageView!
    @IBOutlet weak var dailyForecastTmpMaxArray2: UILabel!
    @IBOutlet weak var dailyForecastTmpMinArray2: UILabel!
    
    @IBOutlet weak var dailyForecastWeekArray3: UILabel!
    @IBOutlet weak var dailyForecastWeatherCodeArray3: UIImageView!
    @IBOutlet weak var dailyForecastTmpMaxArray3: UILabel!
    @IBOutlet weak var dailyForecastTmpMinArray3: UILabel!
    
    @IBOutlet weak var dailyForecastWeekArray4: UILabel!
    @IBOutlet weak var dailyForecastWeatherCodeArray4: UIImageView!
    @IBOutlet weak var dailyForecastTmpMaxArray4: UILabel!
    @IBOutlet weak var dailyForecastTmpMinArray4: UILabel!
    
    @IBOutlet weak var dailyForecastWeekArray5: UILabel!
    @IBOutlet weak var dailyForecastWeatherCodeArray5: UIImageView!
    @IBOutlet weak var dailyForecastTmpMaxArray5: UILabel!
    @IBOutlet weak var dailyForecastTmpMinArray5: UILabel!
    
    @IBOutlet weak var dailyForecastWeekArray6: UILabel!
    @IBOutlet weak var dailyForecastWeatherCodeArray6: UIImageView!
    @IBOutlet weak var dailyForecastTmpMaxArray6: UILabel!
    @IBOutlet weak var dailyForecastTmpMinArray6: UILabel!
    
    //MARK: - ---- Now Data (Bottom)
    
    @IBOutlet weak var aqiPM25Now: UILabel!
    @IBOutlet weak var nowCityFl: UILabel!
    @IBOutlet weak var nowCityHum: UILabel!
    @IBOutlet weak var nowCityPcpn: UILabel!
    @IBOutlet weak var nowCityPres: UILabel!
    @IBOutlet weak var nowCityVis: UILabel!
    @IBOutlet weak var nowWindDir: UILabel!
    @IBOutlet weak var nowWindSc: UILabel!
    @IBOutlet weak var suggestionUltravioletRaysAdvice: UILabel!
    
    //MARK: - Show Data End
    
    //MARK: - Loading
    
    override func viewDidLoad() {
        if let cityName = loadGameData(){
            requestData(cityName)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if let cityName = loadGameData(){
            requestData(cityName)
        }
        updateUI()
    }
    
    func loadGameData() -> String?{
        // getting path to GameData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as String
        let path = documentsDirectory.stringByAppendingPathComponent("LocalText.plist")
        let fileManager = NSFileManager.defaultManager()
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("LocalText", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("Bundle LocalText.plist file is --> \(resultDictionary?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
            } else {
                println("LocalText.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("LocalText.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded LocalText.plist file is --> \(resultDictionary?.description)")
        var myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            //loading and get values
            let cityName: AnyObject? = dict.objectForKey("cityName")
            return cityName as? String
        } else {
            println("WARNING: Couldn't create dictionary from LocalText.plist! Default values will be used!")
            return nil
        }
    }
    
    func requestData(cityName:String){
        weatherNew.dataRequest(citySearchName: cityName)
        theCityName.text = cityName
    }
    
    //MARK: - Update
    
    func updateUI(){
        updateBasicData()
        updateNowData()
        updateAqiData()
        updateSuggestionData()
        updateDailyForecastData()
    }
    
    func updateBasicData(){
        basicWeatherUpdateWeekAndTime.text = weatherNew.basicWeatherUpdateWeek + "  " + weatherNew.basicWeatherUpdateTime
        basicWeatherMaxAndMinTmp.text = "         " + weatherNew.basicWeatherMinTmp + "° / " + weatherNew.basicWeatherMaxTmp + "°"
        
    }
    
    func updateNowData(){
        nowCityTmp.text = weatherNew.nowCityTmp
        nowWeatherDes.text = weatherNew.nowWeatherDes
        nowCityFl.text = weatherNew.nowCityFl + opFlTmp
        nowCityHum.text = weatherNew.nowCityHum + opHum
        nowCityPcpn.text = weatherNew.nowCityPcpn + opPcpn
        nowCityPres.text = weatherNew.nowCityPres + opPres
        nowCityVis.text = weatherNew.nowCityVis + opVis
        nowWindDir.text = weatherNew.nowWindDir
        nowWindSc.text = weatherNew.nowWindSc + opWindLevel
    }
    
    func updateAqiData(){
        aqiNumAndQltyNow.text = weatherNew.aqiNumNow + "    " + weatherNew.aqiQltyNow
        aqiPM25Now.text = weatherNew.aqiPM25Now
    }
    
    func updateSuggestionData(){
        suggestionUltravioletRaysAdvice.text = weatherNew.suggestionUltravioletRaysAdvice
    }
    
    func updateDailyForecastData(){
        dailyForecastWeekArray1.text = weatherNew.dailyForecastWeekArray[1]
        dailyForecastTmpMinArray1.text = weatherNew.dailyForecastTmpMinArray[1]
        dailyForecastTmpMaxArray1.text = weatherNew.dailyForecastTmpMaxArray[1]
        dailyForecastWeatherCodeArray1.image = UIImage(named: "\(weatherNew.dailyForecastWeatherCodeArray[1])")
        
        dailyForecastWeekArray2.text = weatherNew.dailyForecastWeekArray[2]
        dailyForecastTmpMinArray2.text = weatherNew.dailyForecastTmpMinArray[2]
        dailyForecastTmpMaxArray2.text = weatherNew.dailyForecastTmpMaxArray[2]
        dailyForecastWeatherCodeArray2.image = UIImage(named: "\(weatherNew.dailyForecastWeatherCodeArray[2])")
        
        dailyForecastWeekArray3.text = weatherNew.dailyForecastWeekArray[3]
        dailyForecastTmpMinArray3.text = weatherNew.dailyForecastTmpMinArray[3]
        dailyForecastTmpMaxArray3.text = weatherNew.dailyForecastTmpMaxArray[3]
        dailyForecastWeatherCodeArray3.image = UIImage(named: "\(weatherNew.dailyForecastWeatherCodeArray[3])")
        
        dailyForecastWeekArray4.text = weatherNew.dailyForecastWeekArray[4]
        dailyForecastTmpMinArray4.text = weatherNew.dailyForecastTmpMinArray[4]
        dailyForecastTmpMaxArray4.text = weatherNew.dailyForecastTmpMaxArray[4]
        dailyForecastWeatherCodeArray4.image = UIImage(named: "\(weatherNew.dailyForecastWeatherCodeArray[4])")
        
        dailyForecastWeekArray5.text = weatherNew.dailyForecastWeekArray[5]
        dailyForecastTmpMinArray5.text = weatherNew.dailyForecastTmpMinArray[5]
        dailyForecastTmpMaxArray5.text = weatherNew.dailyForecastTmpMaxArray[5]
        dailyForecastWeatherCodeArray5.image = UIImage(named: "\(weatherNew.dailyForecastWeatherCodeArray[5])")
        
        dailyForecastWeekArray6.text = weatherNew.dailyForecastWeekArray[6]
        dailyForecastTmpMinArray6.text = weatherNew.dailyForecastTmpMinArray[6]
        dailyForecastTmpMaxArray6.text = weatherNew.dailyForecastTmpMaxArray[6]
        dailyForecastWeatherCodeArray6.image = UIImage(named: "\(weatherNew.dailyForecastWeatherCodeArray[6])")
    }
}

