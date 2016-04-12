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

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
