import UIKit
import Alamofire
//import AlamofireImage

class PhotoVC: UIViewController
{
    @IBOutlet weak var photoBig: UIImageView!
    @IBOutlet weak var labelPhoto: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadindLabel: UILabel!
    
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designImage(image: photoBig)
        labelPhoto.text = text.firstCapitalized
    }
    
    func configurePhotoAbout(with photoUrl: String)
    {
        AF.request(photoUrl).responseImage { [weak self] response in
            if case .success(let image) = response.result {
                isHiddenElements(self!.loadindLabel, self!.activityIndicator, bool: true)
                self?.photoBig.image = image
            }
        }
    }
}
