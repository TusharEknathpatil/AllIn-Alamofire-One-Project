//
//  ViewController.swift
//  Alamofire-In-FirstTimes
//
//  Created by Mac on 27/05/23.
//

import UIKit
import Alamofire
import SDWebImage
class ViewController: UIViewController {
    var results:[Result] = []

    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.productCollectionView.dataSource = self
        self.productCollectionView.delegate = self
        fetchData()
       
    }

    func fetchData() {
        guard let url = URL(string: "https://rentomed-api.avertastrategy.com/v1/product/public?page=0&size=10") else {return}
        AF.request(url).response(completionHandler: {
            (response) in
            switch response.result {
            case .success(let data):
                guard let data else {return}
                do{
                    let jsonData = try JSONDecoder().decode(Product.self, from: data)
                    self.results = jsonData.result
                    
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
           
            case .failure(_):
                print("Error Found")
            }
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        })
    }

}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return results.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellResult", for: indexPath) as! CollectionViewCellResult
        
        
        let imageUrl =  results[indexPath.row].defaultImage
        let imageBindOne = "https://rentomed-api.avertastrategy.com/v1/file/image/"
        let imageBindTwo = imageUrl
        let imageBindThree = "/"
        let allImage = imageBindOne + imageBindTwo + imageBindThree
        let bindImage = URL(string: allImage)
        cell.imageOfProduct.sd_setImage(with: bindImage)
        
        cell.lblOne.text = results[indexPath.row].genericName
        cell.lblTwo.text = results[indexPath.row].description.description
        cell.lblThree.text = results[indexPath.row].sellPrice.description
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blue.cgColor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (productCollectionView.frame.size.width-20)/2
        return CGSize(width: cellSize, height: cellSize)

    }
}

