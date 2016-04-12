//
//  NuevoSensorVC.swift
//  Monitor de Temperatura
//
//  Created by Andres E Sedano on 2/12/16.
//  Copyright © 2016 Andres E Sedano. All rights reserved.
//

import UIKit

class NuevoSensorVC: UIViewController {

    @IBOutlet weak var URL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cerrar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func QuitarTeclado(sender: AnyObject) {
        URL.resignFirstResponder()
    }
    
    @IBAction func aceptar(sender: AnyObject) {
        if URL.text != "" {
            DataManager.sharedInstance.sensores.append(URL.text!)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message:
                "URL Vacia", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
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
