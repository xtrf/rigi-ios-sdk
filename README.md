# [Rigi SDK](https://rigi.io) for iOS

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://cocoapods.org/pods/RigiSDK)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/Rigi/Rigi-SDK-ios)
[![CocoaPods](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-green.svg)](https://cocoapods.org/pods/RigiSDK)
[![Commercial License](https://img.shields.io/badge/license-Commercial-green.svg)](https://github.com/Rigi/Rigi-SDK-ios/blob/master/LICENSE.md)

The Rigi SDK enables seamless integration of localization previews into your iOS project.

## Table of contents

1. [Introduction](#introduction)
1. [Requirements](#requirements)
1. [Localize the project](#Localize-the-project)
1. [Setup the Rigi SDK](#Setup-the-Rigi-SDK)
1. [Rigi command-line tools](#Rigi-command-line-tools)
1. [Prepare the Pseudo language](#Prepare-the-Pseudo-language)
1. [Make previews](#Make-previews)
1. [Translate with previews](#Translate-with-previews)
1. [Import translations](#Import-translations)
1. [Add new strings](#Add-new-strings)
1. [License](#License)

<br/>

## Introduction

**Rigi SDK** for iOS is a development kit that enables easy and fast integration of Rigi into new or existing iOS apps.

This repository houses the Rigi iOS SDK framework and sample projects:

- **RigiSDK** - Rigi command-line script and ini-file templates
- **Examples** - Example apps

Find out more about the Rigi Software Localization Tool on [https://xtm.cloud/rigi/]()


## Requirements

The minimum requirements for Rigi SDK for iOS are:

- iOS 13 or MacOS 11
- Swift 5.0+ / Objective-C
- Xcode Swift Package Manager
- Xcode Localization with String Catalogs
- Rigi Swift Package and Rigi command-line script

<br/>

## Localize the project

To make use of the Rigi SDK, you need to enable localization in your Xcode project and add a special **pseudo language**.

The Rigi SDK supports **Xcode string catalogs** and the import and export of **XLIFF localization files**.

This section describes how to set up basic localization. More information about Localization in Xcode can be found on [https://developer.apple.com/documentation/xcode/localization]()

### Enable localization in Xcode

First, enable localization in the Xcode project.

### Add languages in Xcode

Add the languages your app will support to the Xcode project. In this example, we choose ***Dutch (NL)***.

![](Docs/Screens/setup-3.png)

You should also add a ***pseudo language*** that will only be used while capturing previews.

Here we will choose Zulu (ZU) as a pseudo language.

![](Docs/Screens/setup-4.png)

<br/>

## Setup the Rigi SDK

This section describes how to add the Rigi SDK to your Xcode project using ***Swift Package Manager*** and how to configure the Rigi SDK in your project.

### Create a new Target and Scheme for Rigi builds

You can create a specific target and scheme for the Rigi builds that will only be used to capture previews. This keeps your production builds separated from the Rigi builds.

In Xcode, create (or copy) a new target that will be used to capture the previews. In the related scheme, set the App language to the ***pseudo locale***.

Here we create a new target 'RigiExample Rigi' and set its language to Zulu (ZU).

![](Docs/Screens/spm-1.png)

![](Docs/Screens/spm-2.png)

<br/>

### Add the Rigi SDK to Xcode

The Rigi SDK for iOS can be installed through [`Swift Package Manager`](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app). This is the preferred way to add the SDK. Alternatively, you can download the Rigi SDK framework and add it manually to your project.

The Rigi SDK package can be installed from this repository:

```bash
https://github.com/xtrf/rigi-ios-spm
```

Add the Rigi SDK package to your project.

![](Docs/Screens/spm-3.png)

Add the package to the target that will be used to capture Rigi previews.

<img src="Docs/Screens/spm-4.png" width="600">

<br/>

### Enable Rigi in Xcode

The Rigi SDK supports both UIKit and SwiftUI projects. First, we need to start Rigi when the app is launched.

For **UIKit projects**, add the following code to launch Rigi on startup:

```swift
import SwiftUI

#if canImport(RigiSDK)
import RigiSDK
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ....
        #if canImport(RigiSDK)
        Rigi.start()
        #endif
        return true
    }
}
```

For **SwiftUI projects**, add the following code:

```swift
import SwiftUI

#if canImport(RigiSDK)
import RigiSDK
#endif

@main
struct RigiExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    #if canImport(RigiSDK)
                    Rigi.start()
                    #endif
                }
        }
    }
}
```

<br/>

### Configure the Rigi SDK

For most projects, the Rigi SDK will work fine out of the box. For specific needs, the SDK has several options that can be customized. This section will give an overview of these options.

```swift
Rigi.start { settings in
    settings.addLabelBorders = true
    settings.labelBorderColor = "#ff0000"
}
```

The following configuration options are available:

```swift
// Show the Rigi scan button
public var isButtonVisible = true

// Enable (debug) logging
public var loggingEnabled = true
public var debugScanning = false
public var debugMatching = false

// Preview settings

// Add simulator border
public var addDeviceBezels = true

// Location of the preview (topleft, center)
public var previewPosition: DivPosition = .center

// Add borders around translatable texts in the previews
public var addLabelBorders = false
public var labelBorderColor = "#0a3679"

// Internal scanning and matching settings
public var useAccurateScanning = true
public var strokeColorTolerance = 0.1
public var strokeLineOffsets: [CGFloat] = [-0.4, -0.2, -0.1, 0, 0.1, 0.2, 0.4]

// Alignment strategy (left, center, neighbors)
public var alignmentStrategy = AlignmentStrategy.left
public var alignmentMargin = 32
public var alignmentDifferenceTreshold = 8
public var alignmentColorTolerance = 0.05
```

<br/>

## Rigi command-line tools

The Rigi SDK comes shipped with command-line tools for exporting and importing localization files and uploading these files and previews to the Rigi server.

This section describes how to set up the Rigi command-line tools for your project.

### Download the Rigi command-line tool

The Rigi Command-line Tool can be downloaded here: [https://github.com/xtrf/rigi-ios-sdk/blob/master/RigiSDK.zip]()

After downloading, extract the RigiSDK.zip in your project root folder. The zip contains the following files:

**/RigiSDK/rigi**

- This is the **Rigi command-line tool**

**/RigiSDK/rigi.ini**

- This is the **Rigi project configuration file**

**/RigiSDK/rigi.meta**

- This file is an internal file used by the RigiSDK and will be updated automatically

<br/>

### Add Rigi configuration files to Xcode

After downloading, you need to add the **rigi.ini** and **rigi.meta** files to your Xcode project. Make sure to add them to the **pseudo target**.

![](Docs/Screens/sdk-install-1.png)
![](Docs/Screens/sdk-install-2.png)
![](Docs/Screens/sdk-install-2-b.png)

<br/>

### Setup 'rigi.ini' configuration details

Next, edit the **rigi.ini** configuration details.

***PROJECT_NAME***

- The name of the project on the Rigi server

***RIGI_SERVER***

- The URL of the Rigi server

***PROJECT_ID***

- Your project ID on the Rigi server. This ID can be found in the URL when you navigate to your project on the Rigi server

***RIGI_EMAIL*** and ***RIGI_PASSWORD***

- The credentials of a **technical user** on the Rigi server that has the rights to upload and download XLIFF files and previews to your project

![](Docs/Screens/rigi-ini.png)

```bash
#------------------
# Rigi SDK settings
# -----------------

# Project name:
PROJECT_NAME = "RigiExample"

# Server settings
# - Rigi server url and project id

RIGI_SERVER = "https://xyz.rigi.io"
PROJECT_ID = 123

# Server credentials
# - Credentials for Rigi server uploads and downloads

RIGI_EMAIL = "user@acme.com"
RIGI_PASSWORD = "secret"

# Source language
# - Should also be defined in the Xcode project

SOURCE_LANGUAGE = "en"

# Pseudo language
# - Should also be defined in the Xcode project

PSEUDO_LANGUAGE = "zu"
```
<br/>

### Rigi command-line tool

The **Rigi command-line tool** can now be used to perform the following steps in the translation process. The following commands are available:

***upload-localization***

- Upload localization files to the Rigi server

***download-localization***

- Download translated localization files from the Rigi server

***upload-previews***

- Upload captured Simulator previews to the Rigi server

![](Docs/Screens/rigi-cmd.png)

<br/>

## Prepare the Pseudo language

To make Rigi previews, we first need to prepare the **pseudo language**. The following section describes how to export your localization files from Xcode, upload them to the Rigi server, and install the prepared **pseudo language**.

### Export Localization catalog from Xcode

First, **export** all the localization files from your Xcode project.

In this example, we will save the exported **Localization Catalog** on the **Desktop**.

![](Docs/Screens/setup-5.png)

![](Docs/Screens/setup-6.png)

<br/>

### Upload Localization catalog to the Rigi server

Next, use the following command to upload the exported localization catalog to the Rigi server:

```bash
cd [PROJECT_FOLDER]
./RigiSDK/rigi upload-localization ~/Desktop/RigiExample\ Localizations
```

This will upload all localization files to the Rigi server.

Additionally, all strings in the **pseudo language** will get extra surrounding pseudo markers: **[#** string **#]**. The updated pseudo language file will automatically be downloaded and saved in:

**Desktop/Rigi-pseudo/**
<br/>

### Import pseudo language in Xcode

Finally, we need to import the updated pseudo language file from the **'Desktop/Rigi-pseudo/'** folder back into the Xcode project.

![](Docs/Screens/import-localization-1.png)

![](Docs/Screens/import-zu.png)

Now you are ready to make Rigi previews!

<br/>

## Capture previews

With the Rigi SDK configured and the Localization prepared, you can start capturing previews of the screens with translatable texts in the simulator and upload these previews to the Rigi server. This section describes how to do this.

### Capture previews in the Simulator (manual)

Run the app in the Xcode Simulator using the ***pseudo language*** scheme. In this example, we use the **RigiExample Rigi** scheme which automatically selectes the pseudo language (Zulu) and activates the Rigi SDK on startup. All translatable texts in the app should now be surrounded by the special pseudo markers **[#** string **#]**.

Navigate through the app and press the **capture button** to capture previews. The Rigi SDK will add highlighted borders around all translatable texts that are found on the screen.

- A **blue border** indicates that the text is found in the localization files
- A **red border** indicates that the text is not found in the localization files
<br>

<p align="center" width="100%">
<img src="Docs/Screens/capture-1.png" width="400">
<img src="Docs/Screens/capture-2.png" width="392">
</p>

The previews will be saved into the Simulator data folder.

<br/>

### Upload the previews to the Rigi server

When you are done capturing screenshots, you can upload the previews to the Rigi server.

Use the following command to upload:

```bash
cd [PROJECT_FOLDER]
./RigiSDK/rigi upload-previews
```

This command will scan all Xcode Simulator folders and try to find the latest saved Rigi previews.

When new previews are found, the command will prompt you to **inspect the previews** before uploading. Use the **MacOS Preview** tool to check the previews before uploading.

![](Docs/Screens/previews-1.png)
![](Docs/Screens/previews-2.png)

Next, the command will prompt to **upload** the previews to the server. Press **enter** to continue.

![](Docs/Screens/upload.png)

Now the texts on the Rigi server can be translated with previews!

<br/>

## Translate with previews

With the previews uploaded to the Rigi server, the translator can start translating the texts with preview context. This section describes the process.

### Translate with preview context

1. On the Rigi server, create a translation task and add a translator to the task
2. Open the translation task
3. Select the text to translate. When a preview is available, it will be shown next to the text
4. The changes will be reflected in the preview. Make sure to save your changes!

Note:<br>
The rendered texts in the previews are just an indication. These texts might be rendered differently on your device after importing into Xcode.

![](Docs/Screens/translate-1.png)
![](Docs/Screens/translate-2.png)
![](Docs/Screens/translate-3.png)
![](Docs/Screens/translate-4.png)

<br/>

## Download translations

When the texts have been translated on the Rigi server, they can be downloaded and imported into the Xcode project. This section describes this process.

### Download the translated texts from the Rigi server

Use the Rigi command-line tool to download the translated texts as XLIFF files to your computer. By default, the XLIFF localization files will be saved to the **Desktop/Rigi-translated** folder:

```bash
cd [PROJECT_FOLDER]
./RigiSDK/rigi download-localization
```

![](Docs/Screens/download-localization.png)

<br>

### Import the translated texts in Xcode

After downloading the XLIFF localization files, you can **import** them into the Xcode project. You need to import each XLIFF file individually.

![](Docs/Screens/import-localization.png)
![](Docs/Screens/import-localization-2.png)

<br>

### Check the translations in the Simulator

After importing, you can check the translated text in Xcode.

Use the **Xcode String Catalog view** to check the imported translations for each language and their translation state.

![](Docs/Screens/translated-1.png)
<br>

Next use the **Xcode Simulator** to view the translations in the running app.

<p align="center" width="100%">
<img src="Docs/Screens/translated.png" width="400">
</p>


## Add new strings

After adding new strings to your Xcode project, also make sure to export and upload them to the Rigi server. 

Then import the updated **pseudo language** file back into the project before captuting new previews. 

Follow the steps starting at:

[Prepare the Pseudo language](#Prepare-the-Pseudo-language)


## License

Copyright (c) 2025 Rigi.io powered by XTM.	

Use of the Rigi SDK for iOS is allowed in combination with a paid Rigi Cloud subscription.

Terms and conditions 2024 apply, see [https://rigi.io/terms-and-conditions-2024/]().

