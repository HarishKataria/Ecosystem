## Install Guide

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build Ecosystem 1.0+.

To integrate Ecosystem into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Ecosystem', '~> 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Ecosystem into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "harishkataria/Ecosystem" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `Ecosystem.framework` into your Xcode project.

## Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Ecosystem does support its use on supported platforms.

Once you have your Swift package set up, adding Ecosystem as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

#### Swift 4+

```swift
dependencies: [
    .package(url: "https://github.com/harishkataria/Ecosystem.git", from: "1.0.0")
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate Ecosystem into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add Ecosystem as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/harishkataria/Ecosystem.git
  ```

- Open the new `Ecosystem` folder, and drag the `Ecosystem.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Ecosystem.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Select the relevant `Ecosystem.framework` for the platform.
- And that's it!
