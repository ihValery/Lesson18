import UIKit

//Подпишем перечисление к стрингу, дабы задать красивое отображение на кнопках ))
//CaseIterable позволяет из перечисления сделать массив, для дальнейшей работы
enum UserActions: String, CaseIterable
{
    case downloadImage = "Download Image"
    case seeAllUser = "See all user"
}

class MainViewController: UICollectionViewController
{
    //Массив наших Actions из всех case
    private let userActions = UserActions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSizeCell()
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActionCell", for: indexPath) as! UserActionCell
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        designCell(with: cell)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .seeAllUser:
            performSegue(withIdentifier: "Users", sender: self)
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "Users" {
            let usersVC = segue.destination as! UsersVC
            usersVC.fetchData()
        }
    }
    
    //MARK: - Design
    
    func designCell(with cell: UserActionCell)
    {
        cell.contentView.layer.cornerRadius = 13
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    func setSizeCell()
    {
        let layout = UICollectionViewFlowLayout()
        let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
       
        layout.minimumLineSpacing = sectionInserts.top
        layout.itemSize = CGSize(width: collectionView.frame.width - 60, height: sectionInserts.top * 4)
        layout.sectionInset = sectionInserts
        collectionView.collectionViewLayout = layout
    }
}
