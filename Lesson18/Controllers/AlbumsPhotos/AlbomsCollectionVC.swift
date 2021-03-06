import UIKit
import Alamofire
import SwiftyJSON

class AlbomsCollectionVC: UICollectionViewController
{
    var album: JSON!
    var photos: [JSON] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
        setSizeCellCollection(collectionView: collectionView)
        title = "Album № \(album["id"])"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let photoVC = segue.destination as? PhotoVC else { return }
        let photoUrl = sender as! String
//        guard let photoUrl = sender as? String else { return }
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
    }
    
    //MARK:  - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAlboms", for: indexPath) as! AlbomsCVCell
        guard let thumbnailUrl = photos[indexPath.item]["thumbnailUrl"].string else { return cell }
        cell.activityIndicator.startAnimating()
        cell.getPreview(with: thumbnailUrl)
        designCell(with: cell)
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let photoUrl = photos[indexPath.item]["url"].string
        performSegue(withIdentifier: "goToPhoto", sender: photoUrl)
    }
}
