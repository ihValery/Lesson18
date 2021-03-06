import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var suitLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zipCodeLbl: UILabel!

    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var bsLbl: UILabel!
    @IBOutlet weak var chLbl: UILabel!

    @IBOutlet weak var bttnToDolist: UIButton!
    @IBOutlet weak var bttnAlbum: UIButton!
    @IBOutlet weak var bttnPost: UIButton!
    
    var user: User?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        designButton(button: bttnPost)
        designButton(button: bttnAlbum)
        designButton(button: bttnToDolist)
        
        nameLbl.text = user?.name
        usernameLbl.text = user?.username
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        websiteLbl.text = user?.website
        streetLbl.text = user?.address?.street
        suitLbl.text = user?.address?.suite
        cityLbl.text = user?.address?.city
        zipCodeLbl.text = user?.address?.zipcode
        companyLbl.text = user?.company?.name
        bsLbl.text = user?.company?.bs
        chLbl.text = user?.company?.catchPhrase
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showPosts",
            let postsVC = segue.destination as? PostsTableViewController {
            postsVC.user = user
        } else if segue.identifier == "goToAlboms",
                  let albomsVC = segue.destination as? AlbomsTVC {
            albomsVC.user = user
        }
    }
}
