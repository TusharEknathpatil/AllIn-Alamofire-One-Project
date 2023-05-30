//
//  ViewControllerMobile.swift
//  Alamofire-In-FirstTimes
//
//  Created by Mac on 28/05/23.
//

import UIKit
import Alamofire

class ViewControllerMobile: UIViewController {

    @IBOutlet weak var numberTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func postBtn(_ sender: Any) {
        FetchPostApi()
        view.backgroundColor = .blue
    }
    
    
    
    }
    
extension ViewControllerMobile {
    func FetchPostApi() {
        
        guard let number = numberTxt.text else {return}
        guard let url = URL(string: "https://rentomed-api.avertastrategy.com/v1/buyer/validate-mobile") else {return}
        let paramerts:[String:Any] = [
            "mobile": number,
            "deviceId": "null",
            "deviceInfo": "null"
        ]
        
        
        AF.request(url, method: .post,parameters: paramerts,encoding: JSONEncoding.default) .validate()
            .response {
                response in
                print(response.result)
                switch response.result {
               
                case .success(let data):
                    guard let okdata = data else {return}
                    do {
                        let jsonData = try JSONDecoder().decode(Mobile.self, from: okdata)
                        print(jsonData)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(_):
                    print("error ss")
                }
            }
        
    }
}
