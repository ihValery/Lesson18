import UIKit
import Alamofire
import SwiftyJSON

class UsersVC: UITableViewController
{
    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"
    private var users: [User] = []

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let desination = segue.destination as? DetailViewController,
           //Достучался до ясейки и прокинули юзера
            let user = sender as? User {
            desination.user = user
        }
    }

    // MARK: - TableSiewSataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = users[indexPath.row].name?.uppercased()
        cell.detailTextLabel?.text = users[indexPath.row].username
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: user)
    }

    func fetchData()
    {
        guard let url = URL(string: jsonUrl) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
