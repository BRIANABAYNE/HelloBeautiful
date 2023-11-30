//
//  HomePageViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/24/23.
//

import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    
    // MARK: - Functions
    
    func setUpCollectionView() {
        let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionalLayout())
        searchCollectionView.frame = self.view.frame
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.backgroundColor = .white
        searchCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"CollectionViewCell")
        self.view.addSubview(searchCollectionView)
    }
    
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupOneItemOne = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/1),
                                               heightDimension:.fractionalHeight(1)))
        groupOneItemOne.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupOne = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/3)),
            subitems:[groupOneItemOne])
        let group2item2 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/1),
                                               heightDimension: .fractionalHeight(1)))
        let groupTwo = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/3)),
            subitems: [group2item2])
        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(700)),
            subitems: [item,groupOne,groupTwo])
        let section = NSCollectionLayoutSection(group: containerGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Extensions

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for: indexPath)
        let imageView = UIImageView(frame: cell.frame)
        imageView.contentMode = .scaleAspectFill
        if (indexPath.item == 0) {
            imageView.image = UIImage(named: "Period Positivity")
        }
        
        else if (indexPath.item == 1) {
            imageView.image = UIImage(named: "Moon")
        }
        
        else if (indexPath.item == 2 ) {
            imageView.image = UIImage(named: "Feelings")
        }
        
        imageView.contentMode = .scaleToFill
        cell.add(view: imageView, left: 0, right: 0, top: 0, bottom: 0)
        return cell
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in:0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1 )
    }
}

extension UIView {
    func add(
        view: UIView,
        left: CGFloat,
        right: CGFloat,
        top: CGFloat,
        bottom: CGFloat
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: right).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: right).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: right).isActive = true
    }
}
