import UIKit
import Alamofire
import SwiftyJSON

class AddPostVC: UIViewController
{
    @IBOutlet weak var titlePost: UITextField!
    @IBOutlet weak var bodyPost: UITextView!
    @IBOutlet weak var lineDesign: UIView!
    @IBOutlet weak var addPostBttn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        designButton(button: addPostBttn)
        designView(view: lineDesign)
        bodyPost.delegate = self
        buttonOnOff(with: addPostBttn, bool: false)
    }
    
    @IBAction func titlePostAction(_ sender: Any)
    {
        buttonOnOff(with: addPostBttn, bool: titlePost.text != "")
    }
    
    @IBAction func addPostAction(_ sender: Any)
    {
        
    }
}
