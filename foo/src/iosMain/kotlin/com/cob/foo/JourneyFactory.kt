package com.cob.foo

import androidx.compose.ui.window.ComposeUIViewController
import platform.UIKit.UIViewController

object JourneyFactory {
    fun createJourneyViewController(): UIViewController {
        return ComposeUIViewController { FooScreen() }
    }
}