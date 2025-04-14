import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
    id("maven-publish")
    id("signing")
}

group = "com.cob.foo"
version = "1.0.2"

kotlin {
    androidTarget {
        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_17)
        }
        publishLibraryVariants("release")
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "Foo"
            isStatic = true
        }
    }
    
    sourceSets {
        commonMain.dependencies {
            implementation(compose.runtime)
            implementation(compose.foundation)
            implementation(compose.material)
            implementation(compose.ui)
            implementation(compose.components.resources)
            implementation(compose.components.uiToolingPreview)
            implementation(libs.androidx.lifecycle.viewmodel)
            implementation(libs.androidx.lifecycle.runtime.compose)
        }
    }
}

android {
    namespace = "com.cob.foo"
    compileSdk = libs.versions.android.compileSdk.get().toInt()

    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

publishing {
    repositories {
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/chrisob55/Embedded")
            credentials {
                username = System.getenv("GITHUB_USER_NAME")
                password = System.getenv("GITHUB_TOKEN")
            }
        }
    }

    publications {
        // Android publication
        register<MavenPublication>("release") {
            groupId = "com.cob.foo"
            artifactId = "foo-android"
            version = "1.0.2"
        }

        // iOS publication
        create<MavenPublication>("ios") {
            groupId = "com.cob.foo"
            artifactId = "foo-ios"
            version = "1.0.2"

            from(components["kotlin"])
        }
    }
}

tasks.register<Zip>("packageXCFramework") {
    dependsOn("linkFooReleaseFrameworkIosArm64", "linkFooReleaseFrameworkIosX64", "linkFooReleaseFrameworkIosSimulatorArm64")
    
    archiveFileName.set("Foo.xcframework.zip")
    destinationDirectory.set(layout.buildDirectory.dir("XCFrameworks"))
    
    from(layout.buildDirectory.dir("XCFrameworks/release"))
}