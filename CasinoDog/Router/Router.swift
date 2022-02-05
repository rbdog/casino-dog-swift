//
//
//

import SwiftUI

struct Router {
    func setBasePages(stack: [PageId], animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.baseNaviState.stack = stack
                }
            } else {
                appState.routing.baseNaviState.stack = stack
            }
        }
    }
    
    func pushBasePage(pageId: PageId, animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.baseNaviState.stack.append(pageId)
                }
            } else {
                appState.routing.baseNaviState.stack.append(pageId)
            }
        }
    }
    
    func popBasePage(animated: Bool = false) {
        Task {
            await MainActor.run {
                if animated {
                    withAnimation {
                        _ = appState.routing.baseNaviState.stack.removeLast()
                    }
                } else {
                    _ = appState.routing.baseNaviState.stack.removeLast()
                }
            }
        }
    }
    
    func setBaseModals(queue: [ModalId], animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.baseModalState.queue = queue
                }
            } else {
                appState.routing.baseModalState.queue = queue
            }
        }
    }
    
    func enqBaseModal(pageId: ModalId, animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.baseModalState.queue.insert(pageId, at: 0)
                }
            } else {
                appState.routing.baseModalState.queue.insert(pageId, at: 0)
            }
        }
    }
    
    func deqBaseModal(animated: Bool = true) {
        Task {
            await MainActor.run {
                if animated {
                    withAnimation {
                        _ = appState.routing.baseModalState.queue.removeLast()
                    }
                } else {
                    _ = appState.routing.baseModalState.queue.removeLast()
                }
            }
        }
    }
    
    func selectHomeTab(pageId: PageId, animated: Bool = false) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.homeTabState.selectedId = pageId
                }
            } else {
                appState.routing.homeTabState.selectedId = pageId
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
    
    func onTapMenuItem(itemID: MenuItemId) {
        var nextPageID: PageId?
        switch itemID {
        case .developerMessage:
            nextPageID = .developerMessage
        case .lisense:
            nextPageID = .license
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
                    appState.routing.onboadingNaviState.stack = stack
                }
            } else {
                appState.routing.onboadingNaviState.stack = stack
            }
        }
    }
    
    func pushOnboadingPage(_ id: PageId, animated: Bool = true) {
        DispatchQueue.main.async {
            if animated {
                withAnimation {
                    appState.routing.onboadingNaviState.stack.append(id)
                }
            } else {
                appState.routing.onboadingNaviState.stack.append(id)
            }
        }
    }
}
