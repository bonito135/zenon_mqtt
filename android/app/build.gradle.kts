plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.zenon_mqtt"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion
    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.zenon_mqtt"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // minSdk = flutter.minSdkVersion
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("debug") {
            applicationIdSuffix = ".debug"
            isDebuggable = true
        }
        getByName("release") {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }

         /**
         * The `initWith` property lets you copy configurations from other build types,
         * then configure only the settings you want to change. This one copies the debug build
         * type, and then changes the manifest placeholder and application ID.
         */
        // create("staging") {
        //     initWith(getByName("debug"))
        //     manifestPlaceholders["hostName"] = "internal.example.com"
        //     applicationIdSuffix = ".debugStaging"
        // }
    }
    // Specifies one flavor dimension.
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

flutter {
    source = "../.."
}
