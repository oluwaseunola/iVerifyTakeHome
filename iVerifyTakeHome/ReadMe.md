Project summary:

SwiftUI to build UI
Security techniques used include using Keychain to store token, and certificate pinning to secure the communication with the server.
Includes pagination and loading state animation.
Can filter using people's names or device names

WHAT WOULD I IMPROVE:

If not for time constraint, more extensive steps could be taken to check if the device was compromised by using libraries that can check if the device has been jailbroken.

In terms of the UI, I would like to toggle the device list allowing the user to sort via name or date.

Pagination is a bit clunky since it reloads and goes back to the top of the list vs appending and allowing a smoother pagination user experience.

Would love to add unit tests of course. 

