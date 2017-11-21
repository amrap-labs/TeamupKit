<p align="center">
    <img src="Artwork/logo.png" width="890" alt="TeamupKit"/>
</p>

[![Build Status](https://travis-ci.org/amrap-labs/TeamupKit.svg?branch=master)](https://travis-ci.org/amrap-labs/TeamupKit)
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![CocoaPods](https://img.shields.io/cocoapods/v/TeamupKit.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/amrap-labs/TeamupKit/branch/master/graph/badge.svg)](https://codecov.io/gh/amrap-labs/TeamupKit)
[![GitHub release](https://img.shields.io/github/release/amrap-labs/TeamupKit.svg)](https://github.com/amrap-labs/TeamupKit/releases)

**This is currently a work in progress.**

A Swift framework for integrating with Teamup: all-in-one management software for top fitness businesses.

## Requirements
TeamupKit requires Swift 4.0 and works with iOS 9 and above. 

## Installation

### CocoaPods
Add `TeamupKit` to your `Podfile`:

```ruby
pod 'TeamupKit'
```

### Carthage
Add `TeamupKit` to your `Cartfile`:

```ruby
github "amrap-labs/TeamupKit"
```

### Dependencies
TeamupKit requires the following dependencies to function:

- [Alamofire](https://github.com/Alamofire/Alamofire) v4.5.x
- [KeychainSwift](https://github.com/evgenyneu/keychain-swift) v8.0.x

## Getting Started

### Basics
Initialize a Teamup session:

```swift
import TeamupKit

let teamup = Teamup(apiToken: "API_TOKEN",
                    businessId: BUSINESS_ID)
```

You are required to have an API token and business identifier to initialize a Teamup session. In order to gain an API token you will need to request one from Teamup ([Submit a request](https://support.goteamup.com/hc/en-us/requests/new)).

Once you have successfully configured a session, you can use any of the API's available in TeamupKit.

### Authentication
Most of the API's available in Teamup require customer level authentication, meaning the customer is required to be signed in to access sessions and account functionality. 

Authenticate an existing user:

```swift
teamup.auth.logIn(email: "test@test.com",
                  password: "password",
                  success: { (user) in
        // successfully authenticated                   
    }) { (error, details) in
        // handle error    
}
```

**This is still a work in progress and lots of stuff needs documenting...**
