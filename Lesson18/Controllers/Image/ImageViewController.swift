import UIKit
import Alamofire

class ImageViewController: UIViewController
{
    private let imageUrl = URLConstants.urlBigImage

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchImage()
        isHiddenElements(loadingLabel, activityIndicator, bool: false)
    }

    private func fetchImage()
    {
        guard let url = URL(string: imageUrl) else { return }
        
        AF.request(url).responseImage { [weak self] response in
            switch response.result {
                case .success(let image):
                    isHiddenElements(self!.loadingLabel, self!.activityIndicator, bool: true)
                    self?.imageView.image = image
                case .failure(let error):
                    print(error)
            }
        }
    }
}

