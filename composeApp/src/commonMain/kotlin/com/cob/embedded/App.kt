package com.cob.embedded

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import org.jetbrains.compose.ui.tooling.preview.Preview
import com.cob.foo.FooScreen

@Composable
@Preview
fun App(modifier: Modifier = Modifier) {
    MaterialTheme {
        Content(modifier)
    }
}

@Composable
private fun Content(
    modifier: Modifier,
    navController: NavHostController = rememberNavController()
) {
    NavHost(
        navController = navController,
        startDestination = "home"
    ) {
        composable("home") {
            Column(
                Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Button(onClick = {
                    navController.navigate("foo")
                }) {
                    Text("Go to Foo")
                }
            }
        }
        composable("foo") {
            FooScreen()
        }
    }
}