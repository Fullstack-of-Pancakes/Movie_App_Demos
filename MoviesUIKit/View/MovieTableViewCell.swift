//
//  MovieTableViewCell.swift
//  MoviesWithCombine
//
//  Created by Marcus Washington on 8/16/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let reuseId = "\(MovieTableViewCell.self)"
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.image = UIImage(named: "Stock")
        return imageView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.contentView.addSubview(self.movieImageView)
        self.contentView.addSubview(self.movieTitleLabel)
        
        self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        self.movieImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        self.movieTitleLabel.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: 8).isActive = true
        self.movieTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        self.movieTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieTitleLabel.text = nil
        self.movieImageView.image = UIImage(named: "Stock")
    }

}
