# Project Overview

This project is built with SwiftUI, incorporating some UIKit components wrapped in representable views. Below are the key details:

- **Dependencies**: No third-party libraries used.
- **Local Persistence**:
  - **Core Data** for saved WatchLists.
  - **UserDefaults** for certain flags.
- **Reactive Programming**: Extensive use of Combine.
- **Minimum iOS Version**: iOS 16.

## Setup Instructions

1. Navigate to `AppKeysTemplate`.
2. Uncomment line 12.
3. Remove line 11.
4. Enter your MOVIE_DB API key. (I will provide mine in the email sent to Leticia Giraudo.)

## Application Flow

The application follows this architecture:
View -> ViewModel -> UseCase -> Repository -> Service (CoreData/Network/Mocks)

## Questions

1. **What does the Single Responsibility Principle consist of? What’s its purpose?**
   - The Single Responsibility Principle (SRP) states that a class or module should have one reason to change, meaning it should only have one responsibility. The purpose of SRP is to enhance maintainability and reduce complexity. By ensuring each part of the code focuses on a single task, it becomes easier to understand, test, and modify without impacting external components (promoting low coupling).

2. **What characteristics does, in your opinion, good code or clean code have?**
   - Good code is readable and easy to understand, ideally to the point where comments are unnecessary, as excessive comments can clutter the codebase. It follows consistent naming and spacing conventions and has a clear structure. Good code should be modular, allowing for easy testing and reusability. Additionally, it minimizes dependencies and avoids unnecessary complexity. Crafting simple and elegant code is often more challenging than writing complex and extensive code.

3. **Detail how you would address unfinished tasks.**
   - **Local Caching**: I didn’t have time to implement local caching to enable the app to function offline. My approach would involve creating a lightweight data component that maintains a list of Movies and an associated category. After retrieving new Movies from the API, I would aggregate this data into UserDefaults, ensuring no duplicate categories exist. In the event of an image retrieval error, the app would fall back to the local cache, showing an error if the cache for that category is empty.

   - **Image Caching**: I did not implement image caching due to the time constraint and my decision to avoid third-party libraries. A straightforward solution would be to utilize Kingfisher or Nuke, both of which are compatible with SwiftUI. Alternatively, I could create a custom solution using NSCache to associate a URL path with a UIImage. Each time an image is rendered, the cache would store it, allowing for quicker local lookups rather than remote requests. I would assign priorities to images to manage different cache timeout durations, flushing the cache for the Search tab more frequently than the Home tab to conserve memory. Additionally, saving images to disk could significantly improve user experience, particularly for the Home tab, which is the most frequently accessed.

## Pending Tasks
- [ ] Implement Image Caching
- [ ] Implement Movies Caching
- [x] Add Unit Tests
- [ ] Alert User of Service Errors

~ Leo
