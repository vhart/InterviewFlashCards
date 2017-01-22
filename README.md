# Interview Flash Cards
An open-source project in the form of iOS technical, data structures, and algorithm questions in flashcard form.

## Pods
 - Firebase(soon to be migrated to a Realm database)
 - Quick
 - Nimble
 - Nocilla

 ## Minimum Requirements
 - Xcode 8
 - iOS 10.0

 ## Installation
 - Install [Cocoapods](http://guides.cocoapods.org/using/getting-started.html#installation).
 - cd to directory and use `pod init` to create a Podfile
 - Paste the below snippet into your Podfile

```
 Uncomment this line to define a global platform for your project
platform :ios, '10.0'

target ‘InterviewFlashCards’ do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
    pod 'Firebase/Core'
    pod 'Firebase/Database'

  # Pods for InterviewFlashCards
  target 'InterviewFlashCardsTests' do
    pod 'Quick'
    pod 'Nimble'
    pod 'Nocilla'
  end
end
```
 - Save and install pods
 ```
 pod install
 ```

 - Open InterviewFlashCards.xcworkspace

 ## Features
 - Choose between 3 different study topics
 - Question tracking to make sure you're understanding the topics and concepts
 - Solutions to questions within the app
 - Swipe through all questions and categories smoothly

 ## Future Improvements and Features
 - UI and UX update
