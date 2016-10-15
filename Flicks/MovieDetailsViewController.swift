//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteView: VoteView!
    
    public var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie?.title
        overviewLabel.text = movie?.overview
        overviewLabel.sizeToFit()
        
        if let date = movie?.releaseDate {
            releaseDateLabel.text = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        }
        
        if let voteAverage = movie?.voteAverage {
            voteView.voteAverage = voteAverage
        }
        
        if let backdropURL = movie?.backdrop.lowResolutionURL {
            backdropView.af_setImage(withURL: backdropURL,
                                     filter: AspectScaledToFillSizeFilter(size: backdropView.frame.size),
                                     runImageTransitionIfCached: true
                                     ) { response in
                if let originalURL = self.movie?.backdrop.originalURL {
                    self.backdropView.af_setImage(
                        withURL: originalURL,
                        placeholderImage: response.result.value,
                        filter: AspectScaledToFillSizeFilter(size: self.backdropView.frame.size),
                        imageTransition: .crossDissolve(0.2),
                        runImageTransitionIfCached: true
                    )
                }
            }
        }
        
        if let posterURL = movie?.poster.mediumResolutionURL {
            posterView.af_setImage(withURL: posterURL, placeholderImage: Placeholders.poster, imageTransition: .crossDissolve(0.2))
        }
        
        var contentFrame = contentView.frame
        contentFrame.size.height = posterView.frame.size.height + overviewLabel.frame.size.height
        contentView.frame = contentFrame
        scrollView.contentSize = CGSize(width: contentFrame.size.width, height: contentFrame.size.height + 500)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = contentView.bounds
        contentView.insertSubview(blurView, at: 0)
    }
    
}
