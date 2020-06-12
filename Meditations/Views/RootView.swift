import Combine
import Foundation
import SwiftUI

struct RootView: View {
    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    var body: some View {
        VStack {
            if !self.appUserDefaults.hasLetsGetToKnowYou {
                OnBoardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
