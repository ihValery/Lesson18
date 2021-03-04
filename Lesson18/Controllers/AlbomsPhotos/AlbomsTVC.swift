import UIKit
import Alamofire
import SwiftyJSON

class AlbomsTVC: UITableViewController
{
    var user: User!
    var albums: [JSON] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
    }
    
    private func getData()
    {
        guard let userId = user.id else { return }
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums?userId=\(userId)") else { return }

        AF.request(url).responseJSON { response in
            switch response.result {
                case .success(let data):
                    self.albums = JSON(data).arrayValue
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellAlboms")
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let albomId = albums[indexPath.row]["id"].int
        performSegue(withIdentifier: "collAlboms", sender: albomId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "collAlboms",
           let photosCollectionVC = segue.destination as? AlbomsCollectionVC,
           let albumId = sender as? Int {
           photosCollectionVC.user = user
           photosCollectionVC.albomId = albumId
        }
    }
}
