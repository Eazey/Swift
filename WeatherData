//
//  WeatherData.swift
//  WeatherOne
//
//  Created by WJnight on 15/11/25.
//  Copyright (c) 2015年 WJnight. All rights reserved.
//

import Foundation

class WeatherDataDeal{
    
    var myErrorDeal = ErrorSolution()
    var knowWeeks = Dictionary<Int,String>()
    
    //MARK: - Data
    
    //MARK: - ---- Basic 
    
    //天气更新的基础数据
    var basicWeatherUpdateCnty = "N/A"//数据更新的所在国家
    var basicWeatherUpdateCity = "N/A"//数据更新的所在城市@@@
    var basicWeatherUpdateTime = "N/A"//数据更新的时间@@@
    var basicWeatherUpdateDate = "N/A"//数据更新的日期
    var basicWeatherUpdateWeek = "N/A"//数据更新的星期@@@
    var basicWeatherMaxTmp = "N/A"    //当天最高温度@@@
    var basicWeatherMinTmp = "N/A"    //当天最低温度@@@
    
    //MARK: - ---- Now
    
    //实时天气情况
    var nowWeatherDes = "N/A"//天气状况描述，例：晴@@@
    var nowWeatherImg = ""//天气状况的图片代号，例：100
    var nowCityFl = "N/A"    //体感温度@@@
    var nowCityHum = "N/A"   //湿度@@@
    var nowCityPcpn = "N/A"  //降雨量@@@
    var nowCityTmp = "N/A"   //温度@@@
    var nowCityPres = "N/A"  //气压@@@
    var nowCityVis = "N/A"   //能见度@@@
    var nowWindDir = "N/A"   //风向@@@
    var nowWindSc = "N/A"    //风力等级@@@
    
    //MARK: - ---- Aqi
    
    //实时空气质量情况
    var aqiNumNow = "N/A"  //空气质量指数@@@
    var aqiQltyNow = "N/A" //空气质量，例：优@@@
    var aqiPM25Now = "N/A" //PM2.5指数@@@

    //MARK: - ---- Suggestions
    
    //生活建议（每种数据都成对出现）
    var suggestionFeelAdvice = "N/A"           //体感指数，例：较为舒适
    var suggestionFeelRemind = "N/A"           //体感详细建议（文字较多）
    var suggestionWashCarAdvice = "N/A"        //洗车指数
    var suggestionWashCarRemind = "N/A"        //洗车提醒
    var suggestionWearClothesAdvice = "N/A"    //穿衣指数
    var suggestionWearClothesRemind = "N/A"    //穿衣提醒
    var suggestionHaveColdAdvice = "N/A"       //感冒指数
    var suggestionHaveColdRemind = "N/A"       //感冒提醒
    var suggestionSportsAdvice = "N/A"         //运动指数
    var suggestionSportsRemind = "N/A"         //运动提醒
    var suggestionTourismAdvice = "N/A"        //旅游指数
    var suggestionTourismRemind = "N/A"        //旅游提醒
    var suggestionUltravioletRaysAdvice = "N/A"//紫外线指数
    var suggestionUltravioletRaysRemind = "N/A"//紫外线提醒
    
    //MARK: - ---- Daily Forecast
    
    //天气预报
    let dayNum = 6;                                                                //预报的最大天数（不超过6）
    var dailyForecastDateArray = ["N/A","N/A","N/A","N/A","N/A","N/A","N/A"]       //预报当天日期
    var dailyForecastWeatherCodeArray = ["","","","","","",""]                     //预报当天天气图@@@
    var dailyForecastWeatherDesArray = ["N/A","N/A","N/A","N/A","N/A","N/A","N/A"] //预报当天天气描述
    var dailyForecastTmpMaxArray = ["N/A","N/A","N/A","N/A","N/A","N/A","N/A"]     //预报当天最高气温@@@
    var dailyForecastTmpMinArray = ["N/A","N/A","N/A","N/A","N/A","N/A","N/A"]     //预报当天最低气温@@@
    var dailyForecastWeekArray = ["N/A","N/A","N/A","N/A","N/A","N/A","N/A"]       //预报当天星期@@@
    
    init(){
        knowWeeks[2] = "星期一"
        knowWeeks[3] = "星期二"
        knowWeeks[4] = "星期三"
        knowWeeks[5] = "星期四"
        knowWeeks[6] = "星期五"
        knowWeeks[7] = "星期六"
        knowWeeks[1] = "星期日"
    }
    //MARK: - Data End
    
    //MARK: - Data Request

    func dataRequest(#citySearchName:String){
        
        //请求并验证数据
        let urlStr = "http://api.heweather.com/x3/weather?city=\(citySearchName)&key=bb07728c9379403a85f4c1878a3baf36"
        let utf8url = NSString(string: urlStr).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url = NSURL(string: utf8url!)
        let data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        if myErrorDeal.requestedDataFailure(data){
            return
        }
        
        //解析总数据并验证
        let jsonData:AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        let heWeatherData:AnyObject? = jsonData?.objectForKey("HeWeather data service 3.0")
        let weatherData:AnyObject? = heWeatherData?.objectAtIndex(0)
        if myErrorDeal.noAllWeatherData(weatherData){
            return
        }
        
        //解析模块数据
        var weatherDataTypeArray:[String] = ["daily_forecast","basic","aqi","now","suggestion"]
        for index in 0..<weatherDataTypeArray.count {
            let dataRequested:AnyObject? = weatherData?.objectForKey(weatherDataTypeArray[index])
            dataSelection(weatherDataTypeArray[index],weatherDataType:dataRequested)
        }
        //myPrint()
    }
    
    private func dataSelection(weatherDataName:String,weatherDataType:AnyObject?){
        if myErrorDeal.noWeatherData(weatherDataType){
            return
        }
        switch weatherDataName{
        case "basic" :
            dataOfBasic(weatherDataType)
        case "aqi":
            dataOfNowAqi(weatherDataType)
        case "now" :
            dataOfNowWeather(weatherDataType)
        case "suggestion" :
            dataOfSuggestions(weatherDataType)
        case "daily_forecast" :
            dataOfDailyForecast(weatherDataType)
        default:
            return
        }
    }
    
    private func dataOfNowWeather(nowData:AnyObject?){
        //天气描述
        let cond_now:AnyObject? = nowData?.objectForKey("cond")
        //天气状况
        let txt_cond_now:AnyObject? = cond_now?.objectForKey("txt")
        var weatherDes = txt_cond_now as? String
        self.nowWeatherDes = weatherDes!
        //天气状况图
        let code_cond_now:AnyObject? = cond_now?.objectForKey("code")//天气获取图片代码
        var weatherCode = code_cond_now as? String
        self.nowWeatherImg = weatherCode!
        
        //风力
        let wind_now:AnyObject? = nowData?.objectForKey("wind")
        //风力方向
        let dir_wind_now:AnyObject? = wind_now?.objectForKey("dir")
        var windDir = dir_wind_now as? String
        self.nowWindDir = windDir!
        //风力级别
        let sc_wind_now:AnyObject? = wind_now?.objectForKey("sc")
        var windSc = sc_wind_now as? String
        self.nowWindSc = windSc!
        
        var nowDataArray:[String] = ["fl","hum","pcpn","tmp","pres","vis"]
        for index in 0..<nowDataArray.count{
            let dataRequested:AnyObject? = nowData?.objectForKey(nowDataArray[index])
            let data = dataRequested as? String
            switch nowDataArray[index]{
            case "fl" :
                self.nowCityFl = data!
            case "hum" :
                self.nowCityHum = data!
            case "pcpn" :
                self.nowCityPcpn = data!
            case "tmp" :
                self.nowCityTmp = data!
            case "pres" :
                self.nowCityPres = data!
            case "vis" :
                self.nowCityVis = data!
            default :
                return
            }
        }
    }
    
    private func dataOfBasic(basicData:AnyObject?){
        //数据更新国家
        let basic_cnty:AnyObject? = basicData?.objectForKey("cnty")
        var weatherCnty = basic_cnty as? String
        self.basicWeatherUpdateCnty = weatherCnty!
        //数据更新城市
        let basic_city:AnyObject? = basicData?.objectForKey("city")
        var weatherCity = basic_city as? String
        self.basicWeatherUpdateCity = weatherCity!
        //数据更新时间
        let basic_update:AnyObject? = basicData?.objectForKey("update")
        //数据更新的当地时间
        let basic_update_loc:AnyObject? = basic_update?.objectForKey("loc")
        var weatherLoc = basic_update_loc as? String
        let weatherTimeAndDate = weatherLoc!
        let weatherTimeAndDateArr = split(weatherTimeAndDate){$0 == " "}.map{String($0)}
        self.basicWeatherUpdateTime = weatherTimeAndDateArr[1]
        self.basicWeatherUpdateDate = self.dailyForecastDateArray[0]
        self.basicWeatherUpdateWeek = self.dailyForecastWeekArray[0]
        self.basicWeatherMaxTmp = self.dailyForecastTmpMaxArray[0]
        self.basicWeatherMinTmp = self.dailyForecastTmpMinArray[0]
    }
    
    private func dataOfNowAqi(aqiData:AnyObject?){
        
        //空气质量城市
        let aqi_city:AnyObject? = aqiData?.objectForKey("city")
        
        let aqiDataArray:[String] = ["aqi","qlty","pm25"]
        for index in 0..<aqiDataArray.count{
            let dataRequested:AnyObject? = aqi_city?.objectForKey(aqiDataArray[index])
            let data = dataRequested as? String
            switch aqiDataArray[index]{
            case "aqi" :
                self.aqiNumNow = data!
            case "qlty" :
                self.aqiQltyNow = data!
            case "pm25" :
                self.aqiPM25Now = data!
            default :
                return
            }
        }
    }

    private func dataOfSuggestions(suggestionData:AnyObject?){
        
        let suggestionArray:[String] = ["comf","cw","drsg","flu","sport","trav","uv"]
        let suggestionDetailsArray:[String] = ["brf","txt"]
        var dataDetailsArray:[String?] = ["",""]
        for index1 in 0..<suggestionArray.count{
            let dataRequested1:AnyObject? = suggestionData?.objectForKey(suggestionArray[index1])
            if dataRequested1 == nil{
                continue
            }
            for index2 in 0..<suggestionDetailsArray.count{
                let dataRequested2:AnyObject? = dataRequested1?.objectForKey(suggestionDetailsArray[index2])
                if dataRequested2 == nil{
                    continue
                }
                dataDetailsArray[index2] = dataRequested2 as? String
            }
            switch suggestionArray[index1]{
            case "comf" :
                self.suggestionFeelAdvice = dataDetailsArray[0]!
                self.suggestionFeelRemind = dataDetailsArray[1]!
            case "cw" :
                self.suggestionWashCarAdvice = dataDetailsArray[0]!
                self.suggestionWashCarRemind = dataDetailsArray[1]!
            case "drsg" :
                self.suggestionWearClothesAdvice = dataDetailsArray[0]!
                self.suggestionWearClothesRemind = dataDetailsArray[1]!
            case "flu" :
                self.suggestionHaveColdAdvice = dataDetailsArray[0]!
                self.suggestionHaveColdRemind = dataDetailsArray[1]!
            case "sport" :
                self.suggestionSportsAdvice = dataDetailsArray[0]!
                self.suggestionSportsRemind = dataDetailsArray[1]!
            case "trav" :
                self.suggestionTourismAdvice = dataDetailsArray[0]!
                self.suggestionTourismRemind = dataDetailsArray[1]!
            case "uv" :
                self.suggestionUltravioletRaysAdvice = dataDetailsArray[0]!
                self.suggestionUltravioletRaysRemind = dataDetailsArray[1]!
            default :
                return
            }
        }
    }
    
    private func dataOfDailyForecast(daily_forecastData:AnyObject?){

        //循环得出dayNum数量天的天气数据
        for index in 0...dayNum {
            var df:AnyObject? = daily_forecastData?.objectAtIndex(index)
            everyday(index, df: df)
        }
    }
    
    private func everyday(index:Int,df:AnyObject?){
        //天气预报日期
        let df_date:AnyObject? = df?.objectForKey("date")
        var date = df_date as? String
        self.dailyForecastDateArray[index] = date!
        self.dailyForecastWeekArray[index] = dateConvertedIntoWeek(date!)
        //预报天气状况
        let df_cond:AnyObject? = df?.objectForKey("cond")
        //天气状况图
        let df_cond_code_d:AnyObject? = df_cond?.objectForKey("code_d")
        var code_d = df_cond_code_d as? String
        self.dailyForecastWeatherCodeArray[index] = code_d!
        //天气状况描述
        let df_cond_txt_d:AnyObject? = df_cond?.objectForKey("txt_d")
        var txt_d = df_cond_txt_d as? String
        self.dailyForecastWeatherDesArray[index] = txt_d!
        //预报温度
        let df_tmp:AnyObject? = df?.objectForKey("tmp")
        //最高气温
        let df_tmp_max:AnyObject? = df_tmp?.objectForKey("max")
        var maxTmp = df_tmp_max as? String
        self.dailyForecastTmpMaxArray[index] = maxTmp!
        //最低气温
        let df_tmp_min:AnyObject? = df_tmp?.objectForKey("min")
        var minTmp = df_tmp_min as? String
        self.dailyForecastTmpMinArray[index] = minTmp!
    }
    
    private func dateConvertedIntoWeek(date:String) -> String{
        let datterFormat = NSDateFormatter()
        datterFormat.dateFormat = "yyyy-MM-dd"
        let dateToWeek = datterFormat.dateFromString(date)!
        let week = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitWeekday, fromDate: dateToWeek)
        if let weekNum = knowWeeks[week]{
            return weekNum
        }else{
            return "N/A"
        }
    }
    
    //MARK: - Test Data
    
    private func myPrint(){
        println(self.basicWeatherUpdateCity)
        println(self.basicWeatherUpdateCnty)
        println(self.basicWeatherUpdateTime)
        println(self.basicWeatherUpdateDate)
        println(self.basicWeatherUpdateWeek)
        println(self.aqiNumNow)
        println(self.aqiPM25Now)
        println(self.aqiQltyNow)
        println(self.nowCityFl)
        println(self.nowCityHum)
        println(self.nowCityPcpn)
        println(self.nowCityPres)
        println(self.nowCityTmp)
        println(self.nowCityVis)
        println(self.nowWeatherDes)
        println(self.nowWeatherImg)
        println(self.nowWindDir)
        println(self.nowWindSc)
        println(self.suggestionFeelAdvice)
        println(self.suggestionFeelRemind)
        println(self.suggestionHaveColdAdvice)
        println(self.suggestionHaveColdRemind)
        println(self.suggestionSportsAdvice)
        println(self.suggestionSportsRemind)
        println(self.suggestionTourismAdvice)
        println(self.suggestionTourismRemind)
        println(self.suggestionUltravioletRaysAdvice)
        println(self.suggestionUltravioletRaysRemind)
        println(self.suggestionWashCarAdvice)
        println(self.suggestionWashCarRemind)
        println(self.suggestionWearClothesAdvice)
        println(self.suggestionWearClothesRemind)
        for index in 0...dayNum{
            println(self.dailyForecastDateArray[index])
            println(self.dailyForecastTmpMaxArray[index])
            println(self.dailyForecastTmpMinArray[index])
            println(self.dailyForecastWeatherCodeArray[index])
            println(self.dailyForecastWeatherDesArray[index])
            println(self.dailyForecastWeekArray[index])
        }
    }
    
}
