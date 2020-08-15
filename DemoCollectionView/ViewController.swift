//
//  ViewController.swift
//  DemoCollectionView
//
//  Created by Cyril Garcia on 8/15/20.
//  Copyright © 2020 ByCyril. All rights reserved.
//

import UIKit

class GenericCell: UICollectionViewCell {
    
    func initUI(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        layoutIfNeeded()
    }
}

protocol LevelViewDelegate {
    func goNextPage(_ index: Int)
    func goBackPage(_ index: Int)
}

protocol DoneDelegate {
    func done()
}

class LevelOneView: UIView {
    var firstNameField: UITextField!
    var lastNameField: UITextField!
    
    var delegate: LevelViewDelegate?
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .red
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleNext() {
//        when triggered, we go to the next page
        delegate?.goNextPage(1)
    }
    
}

class LevelTwoView: UIView {
    var dateOfBirth: UITextField!
    var delegate: LevelViewDelegate?
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .green
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        layoutIfNeeded()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleNext() {
        //        when triggered, we go to the next page
        delegate?.goNextPage(2)
    }
    
}

class LevelThreeView: UIView {
    var dateOfBirth: UITextField!
    var delegate: LevelViewDelegate?
    var doneDelegate: DoneDelegate?
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .yellow
        doneButton.addTarget(self, action: #selector(handleDOne), for: .touchUpInside)
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        layoutIfNeeded()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDOne() {
        //        when triggered, we go to the next page
        doneDelegate?.done()
    }
    
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LevelViewDelegate, DoneDelegate {
 
    var myCollectionView: UICollectionView!
    
    var levelViews = [UIView]()
    
    let levelOne = LevelOneView()
    let levelTwo = LevelTwoView()
    let levelThree = LevelThreeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelOne.delegate = self
        levelTwo.delegate = self
        levelThree.doneDelegate = self
        
        levelViews = [levelOne, levelTwo, levelThree]
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.itemSize = view.frame.size
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        myCollectionView.register(GenericCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.frame = view.frame
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.isPagingEnabled = true
        view.addSubview(myCollectionView)
        
    }
    
    func done() {
        let firstName = levelOne.firstNameField.text
        let lastName = levelOne.lastNameField.text
        let dateOfBirth = levelTwo.dateOfBirth.text
        
//        handle your data
    }
    
    func goNextPage(_ index: Int) {
        myCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func goBackPage(_ index: Int) {
        myCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return levelViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GenericCell
        
        let levelView = levelViews[indexPath.row]
        
        cell.initUI(levelView)
        
        return cell
    }
    
}
