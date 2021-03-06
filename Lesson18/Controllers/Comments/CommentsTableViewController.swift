import UIKit

class CommentsTableViewController: UITableViewController
{
    var comments: [Comment] = []
    var postId: Int!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
    }
    
    private func getData()
    {
        guard let postId = postId else { return }
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }

    // MARK: - TableSiewSataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = comments[indexPath.row].name?.firstCapitalized
        cell.detailTextLabel?.text = comments[indexPath.row].body?.firstCapitalized
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }
}
