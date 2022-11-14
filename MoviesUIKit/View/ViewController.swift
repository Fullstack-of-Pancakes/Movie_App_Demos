//
//  ViewController.swift
//  MoviesWithCombine
//
//  Created by Marcus Washington on 8/16/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    lazy var movieTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.prefetchDataSource = self
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseId)
        return table
    }()
    
    let movieListViewModel: MovieListViewModel
    var subs = Set<AnyCancellable>()
    
    init(viewModel: MovieListViewModel = MovieListViewModel()) {
        self.movieListViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        self.movieListViewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.movieTable.reloadData()
            }.store(in: &self.subs)
        self.movieListViewModel.loadMovies()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.movieTable)
        self.movieTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.movieTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.movieTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.movieTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseId, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.movieTitleLabel.text = self.movieListViewModel.movies[indexPath.row].title
        if let data = self.movieListViewModel.requestImageData(for: indexPath.row) {
            cell.movieImageView.image = UIImage(data: data)
        } else {
            self.cellImageBinding(with: indexPath.row)
        }
        
        return cell
    }
    
    private func cellImageBinding(with row: Int) {
        self.movieListViewModel.$rowRequested
            .receive(on: DispatchQueue.main)
            .sink { row in
                self.movieTable.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            }.store(in: &self.subs)
    }
    
}

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.movieListViewModel.movies.count - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
//        self.movieListViewModel.loadMovies()
    }
    
}

