import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AlbumsCVCell: UICollectionViewCell
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    func getPreview(with thumbnailUrl: String)
    {
        AF.request(thumbnailUrl).responseImage { [weak self] response in
            if case .success(let image) = response.result {
                isHiddenElements(self!.loadingLabel, self!.activityIndicator, bool: true)
                self?.photoImage.image = image
            }
        }
    }
}
