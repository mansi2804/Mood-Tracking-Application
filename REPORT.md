# MP Report

## Team

- Name: Mansi Patil

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [ ] I tested the app in at least one of the following platforms (check all that apply):
  - [X] iOS simulator / MacOS
  - [ ] Android emulator
- [X] There are at least 3 separate screens/pages in the app
- [X] There is at least one stateful widget in the app, backed by a custom model class using a form of state management
- [X] Some user-updateable data is persisted across application launches
- [X] Some application data is accessed from an external source and displayed in the app
- [X] There are at least 5 distinct unit tests, 5 widget tests, and 1 integration test group included in the project

## Questionnaire

Answer the following questions, briefly, so that we can better evaluate your work on this machine problem.

1. What does your app do?

   My app is a mood tracking application that allows users to record their mood along with notes. Users can select their mood from a dropdown list and enter text describing how they are feeling. This data is saved locally and persists across app launches. Users can also delete existing mood entries to maintain an updated record. Additionally, the app features a motivational screen that displays rotating motivational quotes to inspire users, showing a new quote every time.


2. What external data source(s) did you use? What form do they take (e.g., RESTful API, cloud-based database, etc.)?

   I used a random quotes generator API to provide motivational quotes to the user. The API returns a random quote each time the user opens the app, offering a source of daily inspiration. This external data is accessed via HTTP requests, allowing the app to dynamically display a new quote each time the user interacts with it.

3. What additional third-party packages or libraries did you use, if any? Why?

   I used the fl_chart package (version ^0.69.2) to implement pie charts in the app. This package is important because it allows the visualization of mood data in an easy-to-understand format. By representing different moods as colored segments in a pie chart, users can quickly see trends in their emotional well-being. This feature enhances the user experience by providing clear visual feedback, making it easier for users to track and reflect on their mood over time. and also I have used sqflite_common_ffi: ^2.2.1 for integration testing. This package allows the app to interact with SQLite databases in a Flutter environment, enabling persistent storage and data retrieval across app launches, while also providing a way to test the database interactions in a local, in-memory setup.

4. What form of local data persistence did you use?

   I used SQLite through the sqflite package for local data persistence. This allows the app to store user data, such as mood entries, in a local database on the device. The data is retained across app launches, ensuring that the user's information is accessible even after closing and reopening the app.

5. What workflow is tested by your integration test?

   The integration test focuses on validating the critical workflow of the application, starting with the initial state rendering of the HomeScreen widget. It ensures that existing moods provided by the MoodProvider are correctly displayed in the UI, particularly in the PieChart and the mood list. This establishes that the app can accurately present data from the provider when it first loads.
   The test then simulates the addition of a new mood entry through the MockMoodProvider. It verifies that the provider's state updates correctly after the new mood is added and that the app dynamically responds to this change. The HomeScreen widget rebuilds to display the updated mood chart and list, reflecting the new entry's mood and notes.
   This workflow replicates realistic interactions between the provider and the widget tree, ensuring that changes in the provider trigger UI updates via the notifyListeners mechanism. By validating this end-to-end functionality, the test confirms that the app's core features—displaying moods, adding new entries, and dynamically updating the UI—work seamlessly, providing a smooth and functional user experience.


Testing : 

**Distinct unit tests that focus on testing the functionality of model classes.**
1. toMap should correctly convert MoodEntry to Map
Validates that the toMap method accurately converts a MoodEntry object into a map with the correct data format and values.
2. fromMap should correctly convert Map to MoodEntry
Ensures the fromMap method accurately converts a map into a MoodEntry object with the expected attribute values.
3. Equality operator should return true for equal MoodEntries
Tests the equality operator (==) to confirm that two MoodEntry objects with identical attributes are considered equal.
4. toString should return the correct string representation of MoodEntry
Verifies that the toString method outputs the expected string representation of a MoodEntry object.
5. User model should correctly store and retrieve data
Confirms that the User model stores name and age correctly and that the getDetails method returns the expected formatted string.
6. MoodEntry should handle null and default values correctly
Checks the behavior of the MoodEntry constructor with missing optional attributes or default values to ensure no errors occur.

**distinct widget tests that focus on testing the functionality of custom widgets.**
1. shows message when there are no moods
Verifies that the widget displays a message "No moods to display" when the mood list is empty.
2. renders chart with moods correctly
Confirms that the pie chart is rendered correctly when provided with multiple mood entries.
3. renders pie chart with one or two mood entries
Ensures that the pie chart displays the correct number of sections when given one or two mood entries.
4. renders moods with different colors
Checks that the pie chart uses different colors for each unique mood in the provided mood entries.
5. renders no undefined mood sections
Validates that the pie chart does not display sections for undefined or unrecognized moods.


## Summary and Reflection

This project focused on creating a mood tracking application that allows users to record and visualize their emotions over time. A key implementation decision was to use a structured approach for managing state and storing data, ensuring a smooth user experience. The application features dynamic charts for mood visualization, offering an engaging way for users to reflect on their emotional patterns. Comprehensive testing was another critical aspect, covering individual components, user interface interactions, and the overall workflow. While most features were implemented successfully, one challenge was ensuring seamless interaction between the different parts of the application, such as the database, state management, and UI updates.

What I enjoyed most about this project was building a tool that combines functionality with a clean, intuitive design. It was rewarding to see the app come together as a cohesive and user-friendly experience. However, debugging state management and testing asynchronous interactions were challenging at times, especially in integration tests. I wish I had spent more time upfront understanding testing strategies and tools, as they proved to be essential throughout the project. Overall, this was a valuable learning experience that improved my skills in app development and problem-solving.
