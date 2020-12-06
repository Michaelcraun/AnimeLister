//
//  EditAnimeModal.swift
//  AnimeLister
//
//  Created by Michael Craun on 8/4/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class EditAnimeModal: UIViewController {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let thumbnailView: RoundedImageView = {
        let view = RoundedImageView()
        view.radius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = theme.titleFont
        return label
    }()
    
    private var anime: UserAnime
    private var statusView: EditComponentView!
    private var episodeView: EditComponentView!
    private var scoreView: EditComponentView!
    private var startDateView: EditComponentView!
    private var finishDateView: EditComponentView!
    
    init(anime: UserAnime) {
        self.anime = anime
        super.init(nibName: nil, bundle: nil)
        
        setup()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addKeyboardAdjustablility()
        self.hidesKeyboardWhenTappedAround()
        
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        
        thumbnailView.setImage(UIImage(named: anime.anime.photo))
        titleLabel.text = anime.anime.name
        
        statusView = EditComponentView(ofType: .dropDown(title: "Status", currentValue: anime.status!, data: MediaStatus.Anime.list))
        statusView.delegate = self
        
        episodeView = EditComponentView(ofType: .counter(title: "Episodes Watched", currentValue: anime.progress.current, maxValue: anime.progress.total))
        episodeView.delegate = self
        
        scoreView = EditComponentView(ofType: .dropDown(title: "Your Score", currentValue: anime.rating, data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
        scoreView.delegate = self
        
        startDateView = EditComponentView(ofType: .date(title: "Start Date", currentValue: anime.meta.startDate))
        startDateView.delegate = self
        
        finishDateView = EditComponentView(ofType: .date(title: "Finish Date", currentValue: anime.meta.endDate))
        finishDateView.delegate = self
    }
    
    private func layoutView() {
        thumbnailView.anchor(
            to: container,
            top: container.topAnchor,
            leading: container.leadingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        
        titleLabel.anchor(
            to: container,
            leading: thumbnailView.trailingAnchor,
            trailing: container.trailingAnchor,
            centerY: thumbnailView.centerYAnchor,
            padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        
        statusView.anchor(
            to: container,
            top: thumbnailView.bottomAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        episodeView.anchor(
            to: container,
            top: statusView.bottomAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        scoreView.anchor(
            to: container,
            top: episodeView.bottomAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        startDateView.anchor(
            to: container,
            top: scoreView.bottomAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        finishDateView.anchor(
            to: container,
            top: startDateView.bottomAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            bottom: container.bottomAnchor,
            padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        container.anchor(
            to: scrollView,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            centerY: scrollView.centerYAnchor,
            padding: .init(top: 0, left: 25, bottom: 0, right: 25),
            size: .init(width: UIScreen.main.bounds.width - 50, height: 0))
        
        scrollView.fillTo(view)
    }
}

extension EditAnimeModal: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        scrollView.contentSize.height += 600
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.contentSize.height -= 600
    }
}

extension EditAnimeModal: EditComponentDelegate {
    
}
