//
//  GraficaCell.swift
//  Monitor de Temperatura
//
//  Created by Andres E Sedano on 2/12/16.
//  Copyright © 2016 Andres E Sedano. All rights reserved.
//

import UIKit
import Charts

class GraficaCell: UITableViewCell {

    @IBOutlet weak var grafica: LineChartView!
    @IBOutlet weak var idSensor: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func actualizarGrafica(index: Int){
        if DataManager.sharedInstance.hayDatos(){
            setChart(DataManager.sharedInstance.fechas[index], values: DataManager.sharedInstance.temperaturas[index])
        } else {
            grafica.hidden = true;
            idSensor.text = ""
            tempLabel.text = "No hay datos"
        }
    }

    func setChart(dataPoints : [Int], values : [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        var max = -20.0, min = 30.0
        
        if values.count > 0 {
            
            for i in 0...dataPoints.count-1 {
                let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
                dataEntries.append(dataEntry)
                if (values[i] > max + 2) {
                    max = values[i]
                } else {
                    if (values[i] < min) {
                        min = values[i] - 2
                    }
                }
                
            }
            
            tempLabel.text = "Actual " + String(format:"%.1f", values.last!)
            
        }
        
        var str : [String] = [];
        
        for s in dataPoints {
            str.append(unixTimeToString(Double(s)))
        }
        
        let LCDS = LineChartDataSet(yVals: dataEntries, label: "Temperatura")
        LCDS.circleRadius = 2.5
        LCDS.drawCircleHoleEnabled = false
        LCDS.drawValuesEnabled = false
        let LCD = LineChartData(xVals: str, dataSet: LCDS)
        grafica.data = LCD
        grafica.descriptionText = ""
        
        grafica.xAxis.labelPosition = .BottomInside
        
        grafica.rightAxis.enabled = false
        grafica.leftAxis.axisMaxValue = max + 5
        grafica.leftAxis.axisMinValue = min - 5
        
        grafica.legend.enabled = false
        
        grafica.setVisibleXRange(minXRange: 2, maxXRange: 12)
        
        grafica.moveViewToX(CGFloat((dataPoints.count/2)-6))
        
       // grafica.moveViewToAnimated(xIndex: CGFloat(dataEntries.count), yValue: 0, axis: grafica.rightAxis.axisDependency, duration: 5)
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func unixTimeToString(unixTime: Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: unixTime)
        
        dateFormatter.dateFormat = " dd/MM hh:mm:ss a"
        return dateFormatter.stringFromDate(date)
    }

}
