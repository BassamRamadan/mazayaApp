

import UIKit
class HorizontalItemList: UIStackView {
    
    init(inView:UIView,arrangedSubviews: [bannerData], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        for i in 0 ..< arrangedSubviews.count {
            let im = UIImageView()
            im.setDefaultImage(url: arrangedSubviews[i].mediaPath ?? "")
            addArrangedSubview(im)
            im.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                im.widthAnchor.constraint(equalToConstant:
                    inView.frame.width),
                im.heightAnchor.constraint(equalToConstant: inView.frame.height)
            ])
            im.contentMode = .scaleToFill
            im.layer.cornerRadius = 10;
            im.clipsToBounds = true
        }
        self.spacing = spacing
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
   
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
