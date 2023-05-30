//
//  OtpConfirmViewController.swift
//  Alamofire-In-FirstTimes
//
//  Created by Mac on 29/05/23.
//

import UIKit
import Alamofire

class OtpConfirmViewController: UIViewController {
    @IBOutlet weak var otpTxt: UITextField!
    var dataOfNo:Results?
    var number:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        fetchGetApi()
    }
    
    func fetchGetApi() {
        
        guard let otpp = otpTxt.text else {return}
        guard let url = URL(string: "https://rentomed-api.avertastrategy.com/v1/buyer/validate-otp") else {return}
        let parameters:[String:Any] = [
            "mobile": number,
            "otp": 111111
            
        ]
        
        AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default).validate()
            .response { response in
                
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                    let data = utf8Text

                        do {
                            let jsondata = try JSONDecoder().decode(Otp.self, from: response.data!)
                            self.dataOfNo = jsondata.result
                        } catch {
                            print("Error Found ")
                        }
                    
    
                    
                    
                    switch response.result {

                    case .success(let data):
                        guard let data else {return}
                        print(data)
                        do {
                            let json = try JSONDecoder().decode(Otp.self, from: data)


                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        print("error.localizedDescription")
                    }
                    
                    
                    
                    
                    
                    
                    if response.response?.statusCode == 200 {

                        if otpp == self.dataOfNo?.otp   {
                            let showMainVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            self.navigationController?.pushViewController(showMainVC, animated: true)
                        } else {
                            let alert = UIAlertController(title: "Alert", message: "Otp Is Wrong", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        print("error Occurs")
                    }
                }
            }
        
    }
}
