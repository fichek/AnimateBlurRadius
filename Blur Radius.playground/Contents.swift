import UIKit

// a view controller subclass that contains an image view, a visual effect view above it and a slider with an action which controls blur radius of effect view's blur
class BlurDemoViewController: UIViewController {
    let imageView = UIImageView()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    var animator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make imageView same size as view and tell it to stretch together with view both horizontally and verticaly (autoresizing masks are cool again)
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // I don't want my bunny stretched so:
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        // same thing as with imageView
        effectView.frame = view.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(effectView)
        
        // animator does all the hard work and just lets us tell it what fraction of its animation we want to see. note that duration is not important here as we will just drive the animation manually
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            // this is the main trick, animating between a blur effect and nil is how you can manipulate blur radius
            self.effectView.effect = nil
        }
        
        // make a slider always at the bottom of view
        let slider = UISlider()
        slider.frame.origin.x = 20
        slider.frame.origin.y = view.frame.size.height - slider.frame.size.height - 20
        slider.frame.size.width = view.frame.size.width - 40
        slider.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.addSubview(slider)
    }
    
    // this function will be called by UISlider when its value changes. It needs @objc so that it has a #selector (which UISlider uses to send target-action events)
    @objc private func sliderValueChanged(sender: UISlider) {
        animator?.fractionComplete = CGFloat(sender.value)
    }
}

// now just instantiate a blur demo vc and give it an image to show
let vc = BlurDemoViewController()
vc.imageView.image = #imageLiteral(resourceName: "IMG_0044.JPG")

// you can also try out different blur styles if you like
//vc.effectView.effect = UIBlurEffect(style: .dark)
//vc.effectView.effect = UIBlurEffect(style: .extraLight)

// PlaygroundSupport allows us to show a live view (controller)
import PlaygroundSupport
PlaygroundPage.current.liveView = vc

