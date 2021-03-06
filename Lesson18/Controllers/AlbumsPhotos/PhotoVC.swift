import UIKit

class PhotoVC: UIViewController
{
    @IBOutlet weak var photoBig: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designImage(image: photoBig)
    }
    
    func configurePhotoAbout(with photoUrl: String)
    {
        DispatchQueue.global().async {
            //guard let image = photoUrl else { return }
            guard let imageUrl = URL(string: photoUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }

            DispatchQueue.main.async {
                self.photoBig.image = UIImage(data: imageData)
            }
        }
    }
}
