//
//  DataManager.swift
//  Monitor de Temperatura
//
//  Created by Andres E Sedano on 2/12/16.
//  Copyright © 2016 Andres E Sedano. All rights reserved.
//

import Foundation
import UIKit

let dateFormatter = NSDateFormatter()

class DataManager {
    
    class var sharedInstance : DataManager {
        struct Static {
            static let instance : DataManager = DataManager()
        }
        return Static.instance
    }
    
    var tiempos = ["5minutes", "15minutes", "30minutes", "1hour", "5hour", "12hour", "24hour", "48hour"]
    var tiempoSeleccionado = 0
    var sensores : [String] = []
    var fechas : [[Int]] = []
    var temperaturas :  [[Double]] = []
    
    var urls : [String] = ["http://andysedano.com/json/temp.json"]
    
    internal func recargarDatos(){
        cargarDatos()
    }
    
    internal func cargarDatos(){
        buildURLS()
        var i = 0
        fechas.removeAll()
        temperaturas.removeAll()
        for url in urls {
            fechas.append([])
            temperaturas.append([])
            getDatosFromWeb(url, index: i)
            i += 1
        }
    }
    
    internal func hayDatos() -> Bool{
        return temperaturas.count > 0
    }
    
    func getDatosFromWeb(url: String, index : Int) {
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOfURL: url){
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    if let arr = json as? Array<AnyObject> {
                        if let dict = arr[0] as? Dictionary<String, AnyObject> {
                            if let datapoints = dict["datapoints"] as? Array<AnyObject> {
                                for data in datapoints {
                                    if let temp = data.objectAtIndex(0) as? Double {
                                        if let fecha = data.objectAtIndex(1) as? Int {
                                            fechas[index].append(fecha)
                                            temperaturas[index].append(temp)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
        }
    }
    
    func buildURLS(){
        urls = []
        for s in sensores {
            urls.append("http://192.168.52.50/render?target=system.raspberrypi." + s + "&format=json&from=-" + tiempos[tiempoSeleccionado])
        }
    }
    
    func scheduleLocal() {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Sensor fuera de rango establecido!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}