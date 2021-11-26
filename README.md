# The Milky Way
A simple client app that allows users to scroll through the catalog of NASA’s images. This app uses the Nasa Search API.



**Home Page:**

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-26 at 10 04 17](https://user-images.githubusercontent.com/41815081/143547454-b1bd28b7-6b36-4320-9575-ec82d4ac5b10.png)



**Detail Page:**

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-26 at 09 47 53](https://user-images.githubusercontent.com/41815081/143546295-3c5b60da-1f1b-4458-a6a2-ebf4da39f77e.png)



**App icon as it appears on the iOS Home screen:**

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-11-26 at 10 10 50](https://user-images.githubusercontent.com/41815081/143548137-0a5fc9bd-9088-4812-92ba-a126acb16d80.png)



**User Interface Implementation**

For the user interface implementation I used the storyboard and UIKit. It would be interesting to see whether or not implementing the same UI using SwiftUI would be easier. I'll consider implementing the same UI using SwiftUI in the future just to compare the two.



**Things to improve**

Currently there are a 100 items returned from the Nasa Search API endpoint `https://images-api.nasa.gov/search?q=%22%22`. As the number of items grows, the wait time for all the items to be fetched increases as well. This will become a huge issue the day that API endpoint starts to return 500 or 1000 items. We don't want to keep the user waiting and staring at blank screen with a loading activity indicator for too long. I need to find out if this API endpoint supports pagination. If it does, then I'll have to implement some sort of "Load More" mechanism, whereby I initially fetch 20 items from the server then as the user scrolls down through the list I fetch the next 20 when they are near the bottom. Then when they scroll again to the new bottom I fetch the next 20 again and so on.
