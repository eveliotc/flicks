//
//  MovieCell.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteView: VoteView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? Colors.main : Colors.background
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.af_cancelImageRequest()
        posterImageView.layer.removeAllAnimations()
        posterImageView.image = nil
    }
    
    public func bind(_ movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        voteView.voteAverage = movie.voteAverage ?? 0
        posterImageView.af_setImage(withURL: movie.poster.mediumResolutionURL, placeholderImage: Placeholders.poster, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false)
    }
}
