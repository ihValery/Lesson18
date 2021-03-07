import UIKit
import Alamofire
import AlamofireImage

class ImageViewController: UIViewController
{
    private let imageUrl = URLConstants.urlBigImage
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        downloadImage()
        isHiddenElements(loadingLabel, activityIndicator, bool: false)
    }
    
    private func downloadImage()
    {
        guard let url = URL(string: imageUrl) else { return }

        AF.request(url)
            .downloadProgress { progress in
                let progress = Float(progress.fractionCompleted)
                self.progressView.setProgress(progress, animated: true)
            }
            .responseImage { response in
                switch response.result {
                    case .success(let image):
                        isHiddenElements(self.loadingLabel, self.activityIndicator, bool: true)
                        self.progressView.isHidden = true
                        self.imageView.image = image
                    case .failure(let error):
                        print(error)
                }
            }
    }
}

