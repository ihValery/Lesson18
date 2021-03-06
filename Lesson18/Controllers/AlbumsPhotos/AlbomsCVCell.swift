import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AlbomsCVCell: UICollectionViewCell
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    func getPreview(with thumbnailUrl: String)
    {
        AF.request(thumbnailUrl).responseImage { [weak self] response in
            if case .success(let image) = response.result {
                self?.activityIndicator.stopAnimating()
                self?.photoImage.image = image
            }
        }
    }
}
