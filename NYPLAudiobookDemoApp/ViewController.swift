//
//  ViewController.swift
//  NYPLAudiobookToolkitDemoApp
//
//  Created by Dean Silfen on 1/16/18.
//  Copyright © 2018 Dean Silfen. All rights reserved.
//

import UIKit
import NYPLAudiobookToolkit

class ViewController: UIViewController{
    var audiobookController: AudiobookController?
    var detailVC: AudiobookPlayerViewController?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "My Books"
        guard let manager = self.audiobookController?.manager else {
            return
        }

        if (self.detailVC == nil) {
            self.detailVC = AudiobookPlayerViewController(
                audiobookManager: manager
            )
        }

        guard let vc = self.detailVC else {
            return
        }
        self.audiobookController?.configurePlayhead()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
