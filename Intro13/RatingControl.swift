//
//  RatingControl.swift
//  Intro13
//
//  Created by SwiftiCode on 1/8/16.
//  Copyright © 2016 SwiftiCode. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    var ratings = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var starCollection = [UIButton]()
    let totalStars = 5
    let spacing = 5
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Create UIImage and load the image we prepared in Assets
        let emptyStarPic = UIImage(named: "emptyStar")
        let filledStarPic = UIImage(named: "filledStar")
 
        
        // Create 5 star button, set their initial image, add IBAction and add to star collection
        for _ in 0..<totalStars {
            
            // Create a UIButton known as starButton
            let starButton = UIButton()
            
            // Set the image for each starButton state
            starButton.setImage(emptyStarPic, forState: .Normal)
            starButton.setImage(filledStarPic, forState: .Selected)
            starButton.setImage(filledStarPic, forState: [.Highlighted, .Selected])
            
            // Set adjust image when highlighted to false. Apple Note: If true, the image is drawn lighter when the button is highlighted. The default value is true.
            starButton.adjustsImageWhenHighlighted = false
 
            // Link IBAction to each starbutton
            starButton.addTarget(self, action: #selector(RatingControl.starTapped(_:)), forControlEvents: .TouchDown)
            
            // Add starbutton to the UIbutton array
            starCollection += [starButton]
            
            // Add subview for starbutton to the view area
            addSubview(starButton)
            
        }
    }
 
    // We need to override this function so that we can set the size of 5 buttons
    override func intrinsicContentSize() -> CGSize {
        
        let starSize = Int(frame.size.height)
        let totalWidth = totalStars * (starSize + spacing)
        
        return CGSize(width: totalWidth, height: starSize)
    }
    
    // MARK: Layout
    
    // We need to override this function so that we can arrange all the star button side by side
    override func layoutSubviews() {
        
        let starSize = Int(frame.size.height)
        var starFrame = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        
        // For each star in starCollection, we calculate the original x position of ech star. First star should be 0 and second star should be the size of the star plus spacing and multiple by 1 and so on...
        for (index, star) in starCollection.enumerate() {

            // Calculate original x position for each star
            starFrame.origin.x = CGFloat(index * (starSize + spacing))
            
            // Set the frame of each star to our calculated starFrame
            star.frame = starFrame
        }
        
        updateStarState()
        
    }
    
    
    // MARK: Action
    @IBAction func starTapped(star:UIButton) {
        
        ratings = starCollection.indexOf(star)! + 1
        
        //print(ratings)
        
        updateStarState()
        
    }
    
    func updateStarState()  {
        
        for (index, star) in starCollection.enumerate() {
            
            star.selected = index < ratings
        }
    }
}
