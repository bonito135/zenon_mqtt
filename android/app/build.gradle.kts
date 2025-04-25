import java.util.Properties

plugins {
    id("com.android.application")
    // id("kotlin-android") version "1.8.0"
    kotlin("android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = File(project.rootDir.parentFile, "key.properties")
println("🔍 Checking for keystore file at: ${keystorePropertiesFile.absolutePath}")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
} else {
    throw GradleException("Missing key.properties file for signing config")
}

android {
    namespace = "com.example.zenon_mqtt"
    compileSdk = 35
    ndkVersion = "29.0.13113456"

    kotlinOptions {
        jvmTarget = "1.8" // Change this to a valid version like '1.8' or '11'
    }

    defaultConfig {
        applicationId = "com.example.zenon_mqtt"
        minSdk = 21
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"]?.toString() ?: throw GradleException("Missing keyAlias in key.properties")
            keyPassword = keystoreProperties["keyPassword"]?.toString() ?: throw GradleException("Missing keyPassword in key.properties")
            val storeFilePath = keystoreProperties["storeFile"]?.toString()
            if (!storeFilePath.isNullOrEmpty()) {
                storeFile = file(storeFilePath)
            } else {
                throw GradleException("Missing storeFile in key.properties")
            }
            storePassword = keystoreProperties["storePassword"]?.toString() ?: throw GradleException("Missing storePassword in key.properties")

            println("Signing config: alias=$keyAlias, store=${storeFile?.path}")
        }
    }

    buildTypes {
        getByName("debug") {
            applicationIdSuffix = ".debug"
            isDebuggable = true
        }
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            signingConfig = signingConfigs.getByName("release")
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }

    flavorDimensions += "version"
    productFlavors {
        create("staging") {
            dimension = "version"
            applicationIdSuffix = ".staging"
        }
        create("production") {
            dimension = "version"
            applicationIdSuffix = ".production"
        }
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.8.0")
}

// val flutterRoot = System.getenv("FLUTTER_ROOT")
// apply(from = File(flutterRoot, "packages/flutter_tools/gradle/flutter.gradle"))







// import java.util.Properties

// val keystoreProperties = Properties()
// val keystorePropertiesFile = rootProject.file("key.properties")
// if (keystorePropertiesFile.exists()) {
//     keystoreProperties.load(keystorePropertiesFile.inputStream())
// }

// android {
//     namespace = "com.example.zenon_mqtt"
//     compileSdk = flutter.compileSdkVersion
//     // ndkVersion = flutter.ndkVersion
//     ndkVersion = "29.0.13113456"

//     compileOptions {
//         sourceCompatibility = JavaVersion.VERSION_11
//         targetCompatibility = JavaVersion.VERSION_11
//     }

//     kotlinOptions {
//         jvmTarget = JavaVersion.VERSION_11.toString()
//     }

//     defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId = "com.example.zenon_mqtt"
//         // You can update the following values to match your application needs.
//         // For more information, see: https://flutter.dev/to/review-gradle-config.
//         // minSdk = flutter.minSdkVersion
//         //  ndk {
//         //     abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86_64")
//         // }
//         minSdk = 21
//         targetSdk = flutter.targetSdkVersion
//         versionCode = flutter.versionCode
//         versionName = flutter.versionName
//     }

//     signingConfigs {
//         create("release") {
//             keyAlias = keystoreProperties["keyAlias"]?.toString() ?: ""
//             keyPassword = keystoreProperties["keyPassword"]?.toString() ?: ""
//             val storeFilePath = keystoreProperties["storeFile"]?.toString()
//             if (!storeFilePath.isNullOrEmpty()) {
//                 storeFile = file(storeFilePath)
//             }
//             storePassword = keystoreProperties["storePassword"]?.toString() ?: ""
//         }
//     }

//     buildTypes {
//         getByName("debug") {
//             applicationIdSuffix = ".debug"
//             isDebuggable = true
//         }
//         getByName("release") {
//             isMinifyEnabled = true
//             proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
//         }

//          /**
//          * The `initWith` property lets you copy configurations from other build types,
//          * then configure only the settings you want to change. This one copies the debug build
//          * type, and then changes the manifest placeholder and application ID.
//          */
//         // create("staging") {
//         //     initWith(getByName("debug"))
//         //     manifestPlaceholders["hostName"] = "internal.example.com"
//         //     applicationIdSuffix = ".debugStaging"
//         // }
//     }
//     // Specifies one flavor dimension.
//     flavorDimensions += "version"
//     productFlavors {
//         create("staging") {
//             dimension = "version"
//             applicationIdSuffix = ".staging"
//         }
//         create("production") {
//             dimension = "version"
//             applicationIdSuffix = ".production"
//         }
//     }
// }

// flutter {
//     source = "../.."
// }