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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let session = NSURLSession.sharedSession()
    
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
        
        activityIndicator.startAnimating()
        
        //Si el textbox esta vacio
        guard URL.text?.characters.count > 0 else {
            activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "Error", message:
                "URL Vacia", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        let urlString = "http://192.168.52.50/render?target=system.raspberrypi." + URL.text! + "&format=json&from=-5s"
//        let urlString = URL.text!
        
        if let url = NSURL(string: urlString){
            testUrl(url){ (success) -> Void in
                if success {
                    self.activityIndicator.stopAnimating()
                    DataManager.sharedInstance.sensores.append(self.URL.text!)
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    dispatch_async(dispatch_get_main_queue()){
                        self.activityIndicator.stopAnimating()
                        self.URL.resignFirstResponder()
                        let alCont = UIAlertController(title: "Error", message:
                            "No se encontro el sensor", preferredStyle: UIAlertControllerStyle.Alert)
                        alCont.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alCont, animated: true, completion: nil)
                    }
                }
            }
        }
        activityIndicator.stopAnimating()
        
    }
    
    typealias CompletionHandler = (success:Bool) -> Void
    
    func testUrl(url: NSURL, completionHandler: CompletionHandler) {
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        urlRequest.timeoutInterval = 2;
        session.invalidateAndCancel()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            if let _ = data{
                print("existe")
                completionHandler(success: true)
            } else {
                print("no existe")
                completionHandler(success: false)
            }
            
//            let httpResponse = response as! NSHTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            
//            if (statusCode == 200) {
//                print("existe")
//                completionHandler(success: true)
//
//            } else {
//                print("no existe")
//                completionHandler(success: false)
//            }
        }
        
        task.resume()
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
