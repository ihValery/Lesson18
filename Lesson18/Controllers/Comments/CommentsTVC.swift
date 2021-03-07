import UIKit
import Alamofire
import SwiftyJSON

class CommentsTVC: UITableViewController
{
    var comments: [JSON] = []
    
    func getComments(with url: String)
    {
        guard let url = URL(string: url) else { return }

        AF.request(url).responseJSON { [weak self] response in
            switch response.result {
                case .success(let data):
                    self?.comments = JSON(data).arrayValue
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

    // MARK: - TableSiewSataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = comments[indexPath.row]["name"].string?.firstCapitalized
        cell.detailTextLabel?.text = comments[indexPath.row]["body"].string?.firstCapitalized
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }
}
