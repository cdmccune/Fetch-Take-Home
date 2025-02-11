### Summary: Include screen shots or a video of your app highlighting its features

https://github.com/user-attachments/assets/5aa58ebb-31c6-42c8-8086-cdba14fa8ef3

The app has a very simple UI and flow. When the view is shown, an api request is made to fetch the recipes. From there, depending on the result it will update the UI. You can switch the url to see empty or malformed data requests in the Fetch_Take_HomeApp.swift file. The view model and RecipeImageCache are both unit tested.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

My main focuses were on getting the structure of the app with view and view model working with the image cache. Then I connected the api service to populate the data. Lastly I focused on unit testing the view model and image cache. These were the most important areas to get flushed out to complete the task and display my knowledge of the language. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent appriximately 5 hours on this project. I spent the first 2 hours working on getting the structure simply fetching and displaying the recipes and image cache. The next hour I was working on a little bit of design and getting edge cases worked out. The last hour I focused on unit testing.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I opted for a singleton for the image cache for simplicity, but this has a trade off making it more difficult to test. The cache image view accesses the image cache directly, so this interaction is also more difficult to test, though simple. If I were to refactor, I would look into dependecy injection for injecting the image cache into the view model and having the views interact with the view model. This would separate out the concerns and make the code more testable.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part of the project is the image caching and the design. The image caching is simple, but not very robust. The design is very basic and could be improved.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
