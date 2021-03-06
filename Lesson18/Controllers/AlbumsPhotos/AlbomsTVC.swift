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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToAlboms" {
            let photosCollectionVC = segue.destination as? AlbomsCollectionVC
            let album = sender as? JSON
            photosCollectionVC?.album = album
        }
        
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

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellAlboms")
        cell.textLabel?.text = albums[indexPath.row]["title"].stringValue.firstCapitalized
        cell.textLabel?.numberOfLines = 0
        let detailText = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = "Album № \(detailText)"
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "goToAlboms", sender: album)
    }
}
