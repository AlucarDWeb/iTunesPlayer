# iTunesPlayer
This app uses the iTunes Store API to fetch songs from iTunes and show them in a collection view. It is possible to search songs by artist, song name, genre and albums. Tapping on a song will open the detail page, where it's possible to listen to a preview of the selected song, share the song, and move forward and backward in the playlist.

## Features
- Show songs in a collection view with dynamic height cells
- Extensive search by artist, song, genre and album.
- Sorting by song length, genre and price via segmented control
- Preview of the song in the detail page
- Share the song
- Move forward and backward in the playlist

## Technical implementation
iTunesPlayer is written using Swift 5.0 and MVVM + Coordinators, and it uses Swift Package Manager to import the SDWebImage dependency. AVAudioPlayer is used for media reproduction. The app flow is started in the SceneDelegate by the AppCoordinator, which creates and starts the corresponding subflow. All the navigation flow and presentation of view controllers is handled by coordinators. All the classes and structs are created using Dependency Injection. The Network Client uses Network Tasks, defined by the NetworkTask protocol.
The reproduction of the media file is handled as follows:
- The file is downloaded as temporary file in the documents directory
- Once the download is completed, the corresponding URL is sent to the AVAudioPlayer for reproduction.
- While moving forward and backward a new media file is downloaded in the same temporary file location.
- Pausing and playing will always use the same temporary file.

The view controllers use stand alone Xibs to be modular, reusable, and injectable. The communication between the view models and the view controllers is defined with the Delegation pattern.
