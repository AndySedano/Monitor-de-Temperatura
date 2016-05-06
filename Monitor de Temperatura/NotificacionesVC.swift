//
//  NotificacionesVC.swift
//  Monitor de Temperatura
//
//  Created by Andres E Sedano on 4/8/16.
//  Copyright © 2016 Andres E Sedano. All rights reserved.
//

import UIKit

class NotificacionesVC: UIViewController {
    
    @IBOutlet weak var tiempo: UITextField!
    @IBOutlet weak var maxTemp: UITextField!
    @IBOutlet weak var minTemp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.sharedInstance.loadUserData()
    }
    
    override func viewWillAppear(animated: Bool) {
        DataManager.sharedInstance.loadUserData()
        tiempo.text = String(DataManager.sharedInstance.tiempoAlert)
        maxTemp.text = String(DataManager.sharedInstance.maxAlert)
        minTemp.text = String(DataManager.sharedInstance.minAlert)
    }
    
    override func viewWillDisappear(animated: Bool) {
        DataManager.sharedInstance.tiempoAlert = Double(tiempo.text!)!
        DataManager.sharedInstance.maxAlert = Double(maxTemp.text!)!
        DataManager.sharedInstance.minAlert = Double(minTemp.text!)!
        DataManager.sharedInstance.saveUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func QuitarTeclado(sender: AnyObject) {
        tiempo.resignFirstResponder()
        maxTemp.resignFirstResponder()
        minTemp.resignFirstResponder()
    }
    
    @IBAction func guardar(sender: AnyObject) {
        DataManager.sharedInstance.tiempoAlert = Double(tiempo.text!)!
        DataManager.sharedInstance.maxAlert = Double(maxTemp.text!)!
        DataManager.sharedInstance.minAlert = Double(minTemp.text!)!
        DataManager.sharedInstance.saveUserData()
        QuitarTeclado(self)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
