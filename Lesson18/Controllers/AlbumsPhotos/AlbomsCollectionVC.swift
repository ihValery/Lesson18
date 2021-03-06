import UIKit
import Alamofire
import SwiftyJSON

class AlbomsCollectionVC: UICollectionViewController
{
//    var user: User!
    var album: JSON!
//    var albomId: Int!
    var photos: [JSON] = []
//    var photos: [Photos] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
        setSizeCellCollection(collectionView: collectionView)
    
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let photoVC = segue.destination as? PhotoVC else { return }
        guard let photoUrl = sender as? String else { return }
        photoVC.configurePhotoAbout(with: photoUrl)
    }
    
    func getData()
    {
        guard let albumId = album["id"].int else { return }
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)") else { return }
        
        AF.request(url).responseJSON { response in
            print(response)
            switch response.result{
                case .success(let data):
                    self.photos = JSON(data).arrayValue
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
        
        
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            guard let data = data else { return }
//            do {
//                self.photos = try JSONDecoder().decode([Photos].self, from: data)
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            } catch let error {
//                print("Error: ", error)
//            }
//        }.resume()
    }
    //MARK:  - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAlboms", for: indexPath) as! AlbomsCVCell
        cell.thumbnailUrl = photos[indexPath.item]["thumbnailUrl"].string
        cell.activityIndicator.startAnimating()
        cell.getPreview()
//        cell.getPreview(with: photo)
        designCell(with: cell)
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let photo = photos[indexPath.item].url
        performSegue(withIdentifier: "goToPhoto", sender: photo)
    }
}
