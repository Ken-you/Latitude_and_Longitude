//
//  ViewController.swift
//  Latitude_and_Longitude
//
//  Created by yousun on 2021/5/6.
//

import UIKit
import MapKit

class NEViewController: UIViewController {

    
    @IBOutlet weak var NDTextField: UITextField!
    @IBOutlet weak var EDTextField: UITextField!
    
    @IBOutlet weak var ND1TextField: UITextField!
    @IBOutlet weak var NM1TextField: UITextField!
    @IBOutlet weak var ED1TextField: UITextField!
    @IBOutlet weak var EM1TextField: UITextField!
    
    @IBOutlet weak var ND2TextField: UITextField!
    @IBOutlet weak var NM2TextField: UITextField!
    @IBOutlet weak var NS2TextField: UITextField!
    @IBOutlet weak var ED2TextField: UITextField!
    @IBOutlet weak var EM2TextField: UITextField!
    @IBOutlet weak var ES2TextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 最上面轉換經緯度的按鈕
    @IBAction func DBtn(_ sender: Any) {
        view.endEditing(true)
        // 經緯度
        let nd = Double(String(NDTextField.text ?? ""))
        let ed = Double(String(EDTextField.text ?? ""))
    
        let nd1 = Int(nd ?? 0.0)
        let ed1 = Int(ed ?? 0.0)
        
        ND1TextField.text = "\(nd1)"
        ND2TextField.text = "\(nd1)"
        ED1TextField.text = "\(ed1)"
        ED2TextField.text = "\(ed1)"
        
        // 經緯分
        let nm1 = ((nd ?? 0.0) - Double(nd1)) * 60
        let nm1int = Int(nm1)
        let em1 = ((ed ?? 0.0) - Double(ed1)) * 60
        let em1int = Int(em1)
        
        NM1TextField.text = String(format: "%.4f", nm1)
        NM2TextField.text = "\(nm1int)"
        EM1TextField.text = String(format: "%.4f", em1)
        EM2TextField.text = "\(em1int)"
        
        // 經緯秒
        let ns2 = (nm1 - Double(nm1int)) * 60
        let es2 = (em1 - Double(em1int)) * 60
            
        NS2TextField.text = String(format: "%.2f", ns2)
        ES2TextField.text = String(format: "%.2f", es2)
        
        // 設定地圖位置
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (nd ?? 23.973875), longitude: (ed ?? 120.982025)), latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    // 中間轉換經緯度的按鈕
    @IBAction func DMBtn(_ sender: Any) {
        view.endEditing(true)
        
        // 經緯度
        let nd1 = Double(String(ND1TextField.text ?? ""))
        let nm1 = Double(String(NM1TextField.text ?? ""))
        let ed1 = Double(String(ED1TextField.text ?? ""))
        let em1 = Double(String(EM1TextField.text ?? ""))
        
        let nd = (nd1 ?? 0.0) + (nm1 ?? 0.0) / 60
        let ed = (ed1 ?? 0.0) + (em1 ?? 0.0) / 60
        
        NDTextField.text = String(format: "%.6f", nd)
        EDTextField.text = String(format: "%.6f", ed)
        ND2TextField.text = ND1TextField.text
        ED2TextField.text = ED1TextField.text
        
        // 經緯分
        let nm1int = Int(nm1 ?? 0.0)
        let em1int = Int(em1 ?? 0.0)
        
        NM2TextField.text = "\(nm1int)"
        EM2TextField.text = "\(em1int)"
        
        // 經緯秒
        let ns2 = ((nm1 ?? 0.0) - Double(nm1int)) * 60
        let es2 = ((em1 ?? 0.0) - Double(em1int)) * 60
        
        NS2TextField.text = String(format: "%.2f", ns2)
        ES2TextField.text = String(format: "%.2f", es2)
        
        // 設定地圖位置
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: nd, longitude: ed), latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    // 最底下轉換經緯度的按鈕
    @IBAction func DMSBtn(_ sender: Any) {
        view.endEditing(true)
        
        // 轉換成中間的 經緯度、經緯分
        ND1TextField.text = ND2TextField.text
        ED1TextField.text = ED2TextField.text
        
        let ns2 = Double(String(NS2TextField.text ?? ""))
        let nm2 = Double(String(NM2TextField.text ?? ""))
        let nm1 = (nm2 ?? 0.0) + (ns2 ?? 0.0) / 60
        
        let es2 = Double(String(ES2TextField.text ?? ""))
        let em2 = Double(String(EM2TextField.text ?? ""))
        let em1 = (em2 ?? 0.0) + (es2 ?? 0.0) / 60
        
        NM1TextField.text = String(format: "%.4f", nm1)
        EM1TextField.text = String(format: "%.4f", em1)
        
        // 轉換成上面的 經緯度
        let nd1 = Double(String(ND1TextField.text ?? ""))
        let ed1 = Double(String(ED1TextField.text ?? ""))
        
        let nd = (nd1 ?? 0.0) + (nm1 / 60)
        let ed = (ed1 ?? 0.0) + (em1 / 60)
        
        NDTextField.text = String(format: "%.6f", nd)
        EDTextField.text = String(format: "%.6f", ed)
        
        // 設定地圖位置
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: nd, longitude: ed), latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    // 標記地圖
    @IBAction func locationBtn(_ sender: Any) {
        view.endEditing(true)
        
        let latitude = Double(String(NDTextField.text ?? ""))
        let longitude = Double(String(EDTextField.text ?? ""))
        
        let point = MKPointAnnotation()
        
        point.title = locationTextField.text
        
        point.coordinate = CLLocationCoordinate2D(latitude: (latitude ?? 0.0), longitude: (longitude ?? 0.0))
        
        mapView.addAnnotation(point)
    }
    
    // 清除所有座標
    @IBAction func clearBtn(_ sender: Any) {
        
        NDTextField.text = ""
        EDTextField.text = ""
        
        ND1TextField.text = ""
        ED1TextField.text = ""
        NM1TextField.text = ""
        EM1TextField.text = ""
        
        ND2TextField.text = ""
        ED2TextField.text = ""
        NM2TextField.text = ""
        EM2TextField.text = ""
        NS2TextField.text = ""
        ES2TextField.text = ""
        
        locationTextField.text = ""
        
        // 回到全台灣的景象
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.973875, longitude: 120.982025), latitudinalMeters: 450000, longitudinalMeters: 450000)
    }
}
