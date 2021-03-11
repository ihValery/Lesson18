import UIKit
import Alamofire
import SwiftyJSON

class UpdateCommentVC: UIViewController
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
    }
    
    func fillingForm()
    {
    
    }
    
}
