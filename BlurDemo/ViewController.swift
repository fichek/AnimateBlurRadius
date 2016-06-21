import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            self.effectView.effect = nil
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        animator?.fractionComplete = CGFloat(sender.value)
    }

}
