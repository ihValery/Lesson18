import UIKit
import Alamofire

class AlbomsCollectionVC: UICollectionViewController
{
    var user: User!
    var albomId: Int!
    var photos: [Photos] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
        setSizeCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
    
    func getData() -> Void
    {
        guard let albomId = albomId else { return }
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albomId)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.photos = try JSONDecoder().decode([Photos].self, from: data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    //MARK:  - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAlboms", for: indexPath) as! AlbomsCVCell
        let photo = photos[indexPath.item]
        cell.activityIndicator.startAnimating()
        cell.configure(with: photo)
        designCell(with: cell)
        return cell
    }
    //MARK: - UICollectionViewDelegate

    //MARK: - Design
    
    func setSizeCell() -> Void
    {
        let layout = UICollectionViewFlowLayout()
        let itemsPerRow: CGFloat = 3
        let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let paddigWidht = sectionInserts.top * (itemsPerRow + 1)
        let availableWigth = collectionView.frame.width - paddigWidht
        let widhtPerItem = availableWigth / itemsPerRow
        
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: widhtPerItem, height:widhtPerItem)
        layout.sectionInset = sectionInserts
        collectionView.collectionViewLayout = layout
    }
    
    func designCell(with cell: UICollectionViewCell) -> Void
    {
        cell.contentView.layer.cornerRadius = 9
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.layer.cornerRadius = 9
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}
