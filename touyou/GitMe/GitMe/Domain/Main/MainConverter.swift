//
//  MainUseCase.swift
//  GitMe
//
//  Created by 藤井陽介 on 2018/01/27.
//  Copyright © 2018 touyou. All rights reserved.
//

import UIKit
import RxSwift

protocol MainConverterProtocol {

    var isLoggedIn: Bool { get }
    func fetchEvent(at page: Int, every perPage: Int) -> Observable<[EventCellViewModel]>
}

class MainConverter {

    // MARK: Private

    private let api = GitHubAPI.shared

    private func convertEventTitle(of event: Event) -> NSMutableAttributedString {

        let boldStyle: [NSAttributedStringKey: Any] = [
            .font: UIFont(name: "URWDIN-Demi", size: 12.0) ?? UIFont.boldSystemFont(ofSize: 12.0)
        ]

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(NSAttributedString(
            string: event.actor.displayLogin,
            attributes: boldStyle)
        )

        switch event.type {
        case .create:

            mutableAttributedString.append(NSAttributedString(string: " created "))
            mutableAttributedString.append(NSAttributedString(
                string: event.repo!.name,
                attributes: boldStyle)
            )
        case .issueComment:

            mutableAttributedString.append(NSAttributedString(string: " \(event.payload.action!) comment on issue "))
            mutableAttributedString.append(NSAttributedString(
                string: "#\(event.payload.issue!.number)",
                attributes: boldStyle)
            )
            mutableAttributedString.append(NSAttributedString(string: " in "))
            mutableAttributedString.append(NSAttributedString(
                string: event.repo!.name,
                attributes: boldStyle)
            )
        case .issues:

            mutableAttributedString.append(NSAttributedString(string: " \(event.payload.action!)  issue "))
            mutableAttributedString.append(NSAttributedString(
                string: "#\(event.payload.issue!.number)",
                attributes: boldStyle)
            )
            mutableAttributedString.append(NSAttributedString(string: " in "))
            mutableAttributedString.append(NSAttributedString(
                string: event.repo!.name,
                attributes: boldStyle)
            )
        case .push:

            mutableAttributedString.append(NSAttributedString(string: " pushed to "))
            mutableAttributedString.append(NSAttributedString(
                string: String(event.payload.ref!.split(separator: "/").last!),
                attributes: boldStyle)
            )
            mutableAttributedString.append(NSAttributedString(string: " at "))
            mutableAttributedString.append(NSAttributedString(
                string: event.repo!.name,
                attributes: boldStyle)
            )
        case .watch:

            mutableAttributedString.append(NSAttributedString(string: " starred "))
            mutableAttributedString.append(NSAttributedString(
                string: event.repo!.name,
                attributes: boldStyle)
            )
        default:

            mutableAttributedString.append(NSAttributedString(string: " Unknown Event"))
        }

        return mutableAttributedString
    }
}

// MARK: - Protocol Interface

extension MainConverter: MainConverterProtocol {

    var isLoggedIn: Bool {

        return api.isLoggedIn
    }

    func fetchEvent(at page: Int, every perPage: Int) -> Observable<[EventCellViewModel]> {

        return api.fetchEvents(at: page, every: perPage).map { events in

            events.map { event in

                let eventCellViewModel = EventCellViewModel()
                eventCellViewModel.iconUrl = event.actor.avatarUrl
                eventCellViewModel.eventTitle = self.convertEventTitle(of: event)
                eventCellViewModel.createAt = event.createdAt
                eventCellViewModel.repositoryName = event.repo?.name

                return eventCellViewModel
            }
        }
    }
}