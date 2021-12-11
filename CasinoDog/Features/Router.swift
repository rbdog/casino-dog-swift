//
//
//

import SwiftUI

struct Router {
    func setBasePages(stack: [PageId], animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.basePageWindowState.stack = stack
                }
            } else {
                appState.routing.basePageWindowState.stack = stack
            }
        }
    }
    
    func pushBasePage(pageId: PageId, animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.basePageWindowState.stack.append(pageId)
                }
            } else {
                appState.routing.basePageWindowState.stack.append(pageId)
            }
        }
    }
    
    func popBasePage(animated: Bool = false) {
        Task {
            await MainActor.run {
                if animated {
                    withAnimation {
                        _ = appState.routing.basePageWindowState.stack.removeLast()
                    }
                } else {
                    _ = appState.routing.basePageWindowState.stack.removeLast()
                }
            }
        }
    }
    
    func setBaseModals(queue: [ModalId], animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.baseModalWindowState.queue = queue
                }
            } else {
                appState.routing.baseModalWindowState.queue = queue
            }
        }
    }
    
    func enqBaseModal(pageId: ModalId, animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.baseModalWindowState.queue.insert(pageId, at: 0)
                }
            } else {
                appState.routing.baseModalWindowState.queue.insert(pageId, at: 0)
            }
        }
    }
    
    func deqBaseModal(animated: Bool = true) {
        Task {
            await MainActor.run {
                if animated {
                    withAnimation {
                        _ = appState.routing.baseModalWindowState.queue.removeLast()
                    }
                } else {
                    _ = appState.routing.baseModalWindowState.queue.removeLast()
                }
            }
        }
    }
    
    func selectHomeTab(pageId: PageId, animated: Bool = false) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.homeTabWindowState.selectedId = pageId
                }
            } else {
                appState.routing.homeTabWindowState.selectedId = pageId
            }
        }
    }
    
    func onOpenMenu(animated: Bool = false) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.home.showMenu = true
                }
            } else {
                appState.home.showMenu = true
            }
        }
    }
    
    func onCloseMenu(animated: Bool = false) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.home.showMenu = false
                }
            } else {
                appState.home.showMenu = false
            }
        }
    }
    
    func onTapMenuItem(itemID: MenuItemID) {
        var nextPageID: PageId?
        switch itemID {
        case .developerMessage:
            nextPageID = .developerMessage
        case .lisense:
            nextPageID = .lisense
        case .termsOfService:
            nextPageID = .termsOfService
        case .debug:
            nextPageID = .debug
        }
        
        if let nextPageID = nextPageID {
            self.pushBasePage(pageId: nextPageID)
        }
    }
    
    func setOnboardingPage(stack: [PageId], animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.onboadingWindowState.stack = stack
                }
            } else {
                appState.routing.onboadingWindowState.stack = stack
            }
        }
    }
    
    func pushOnboadingPage(_ id: PageId, animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.onboadingWindowState.stack.append(id)
                }
            } else {
                appState.routing.onboadingWindowState.stack.append(id)
            }
        }
    }
}
