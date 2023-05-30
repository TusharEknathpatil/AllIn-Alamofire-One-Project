//
//  LoginViewController.swift
//  Alamofire-In-FirstTimes
//
//  Created by Mac on 29/05/23.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {

    @IBOutlet weak var numberTxt: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func postBtn(_ sender: Any) {
        fetchData()
    }
    
}

extension LoginViewController {
    func fetchData() {
        guard let number = numberTxt.text
        else {
            print("Enter No ")
            return}
       
        
        guard let url = URL(string: "https://rentomed-api.avertastrategy.com/v1/buyer/validate-mobile") else {return}
        
        let parameters:[String:Any] = [
            "mobile":number
            
        ]
        
        AF.request(url,method: .post,parameters:parameters ,encoding: JSONEncoding.default) .validate()
            .response {
            response in
               print(response)
                if (response.response!.statusCode == 200) {
                    let otpViewController = self.storyboard?.instantiateViewController(withIdentifier: "OtpConfirmViewController") as! OtpConfirmViewController
                    otpViewController.number = number.description
                    self.navigationController?.pushViewController(otpViewController, animated: true)
                    
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Number is Invalid", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print("error Occurs")
                }
        }
    }
}


/*
if (Int(otp) == 111111) {
    let showMainVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    self.navigationController?.pushViewController(showMainVC, animated: true)
} else {
    let alert = UIAlertController(title: "Alert", message: "Otp Is Wrong", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
}
*/
