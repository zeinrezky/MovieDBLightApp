//
//  DetailViewController.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let durationLabel = UILabel()
    private let genreLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let castLabel = UILabel()
    private let castScrollView = UIScrollView()
    private let castStackView = UIStackView()
    
    var movie: Movie?
    var cast: [Cast]?
    
    private let viewModel = MovieViewModel(movieService: MovieService())
    private var cancellables = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMovieCredits(movieId: movie?.id ?? 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.$casts
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] _ in
                        self?.setupData()
                    }
                    .store(in: &cancellables)
    }

    
    private func setupView() {
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        durationLabel.font = UIFont.systemFont(ofSize: 16)
        durationLabel.textColor = .gray
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(durationLabel)
        
        genreLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.textColor = .gray
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(genreLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        castLabel.text = "Cast"
        castLabel.font = UIFont.boldSystemFont(ofSize: 18)
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(castLabel)
        
        castScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(castScrollView)
        
        castStackView.axis = .horizontal
        castStackView.spacing = 16
        castStackView.translatesAutoresizingMaskIntoConstraints = false
        castScrollView.addSubview(castStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            genreLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            castLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            castScrollView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 8),
            castScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            castScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            castScrollView.heightAnchor.constraint(equalToConstant: 100),
            castScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            castStackView.topAnchor.constraint(equalTo: castScrollView.topAnchor),
            castStackView.leadingAnchor.constraint(equalTo: castScrollView.leadingAnchor),
            castStackView.trailingAnchor.constraint(equalTo: castScrollView.trailingAnchor),
            castStackView.bottomAnchor.constraint(equalTo: castScrollView.bottomAnchor),
            castStackView.heightAnchor.constraint(equalTo: castScrollView.heightAnchor)
        ])
    }
    
    private func setupData() {
        guard let movie = movie, let cast = cast else { return }
        
        titleLabel.text = movie.title
        durationLabel.text = "1 h 29 m" // Replace with actual duration if available
        genreLabel.text = movie.genres.joined(separator: ", ")
        descriptionLabel.text = movie.overview
        
        // Load image from URL (using a library like SDWebImage or Kingfisher is recommended)
        if let posterPath = movie.posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
            imageView.load(url: imageURL)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
        for castMember in viewModel.casts {
            let castView = createCastView(name: castMember.name, profilePath: castMember.profilePath)
            castStackView.addArrangedSubview(castView)
        }
    }
    
    private func createCastView(name: String, profilePath: String?) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let profilePath = profilePath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")!
            imageView.load(url: imageURL)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        return view
    }
}

// Extension to load images from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
