//
//  AjustesVC.swift
//  Monitor de Temperatura
//
//  Created by Andres E Sedano on 2/26/16.
//  Copyright © 2016 Andres E Sedano. All rights reserved.
//

import UIKit

class AjustesVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableSensores: UITableView!
    @IBOutlet weak var seleccionTiempo: UIPickerView!
    var tiempos:[String] = [String]()
    
    
    override func viewWillAppear(animated: Bool) {
        tableSensores.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seleccionTiempo.delegate = self
        self.seleccionTiempo.dataSource = self
        self.tableSensores.delegate = self
        self.tableSensores.dataSource = self

        tiempos = ["5 minutos", "15 minutos", "30 minutos", "1 hora", "5 horas", "12 horas", "24 horas", "48 horas"]
        
        seleccionTiempo.selectRow(0, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiempos.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiempos [row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        DataManager.sharedInstance.tiempoSeleccionado = row
        
    }
    
    // MARK: - Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.sensores.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AjustesCell") as! AjustesCell
        cell.idLabel.text = DataManager.sharedInstance.sensores[indexPath.row]
        return cell
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
