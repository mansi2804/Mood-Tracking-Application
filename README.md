**Mood Tracker App**
<br>
A Flutter-based Mood Tracker application that allows users to record, track, and visualize their emotional patterns over time. The app features mood recording, local data persistence, and motivational quotes, offering a seamless and interactive user experience. <br>
   
**Features**
<br>  
- Mood Recording<br> Users can record their mood with notes and view their entries over time.<br>

- Data Visualization<br> View mood trends with dynamic pie charts using the fl_chart package.<br>

- Motivational Quotes<br> Displays a new motivational quote from an external Quotes API every time the app is opened.<br>

- Data Persistence<br> Uses SQfLite for local data storage, ensuring mood entries are saved and persist across app launches.<br>

- State Management<br> Built with a stateful widget backed by a custom model class, ensuring dynamic updates throughout the app.<br>

- Platform Compatibility<br> The app supports iOS simulators and Android emulators.<br>

**Comprehensive Testing**<br> Includes:<br>

- 5+ Unit Tests: To validate model functionality.
- 5+ Widget Tests: To verify UI elements and their behavior.
- 1 Integration Test: To test workflows and interactions across the app.

**Screens** <br>

- Home Screen<br> Displays a pie chart summarizing mood data and a list of all recorded moods.

- Add Mood Screen<br> Allows users to add new mood entries, including a dropdown for mood selection and a text field for notes.

- Motivational Screen<br> Displays a rotating motivational quote fetched from the external Quotes API.

**Technologies Used** <br>
- Flutter: Cross-platform app development.<br>
- SQfLite: Local data persistence using the sqflite package.<br>
- State Management: Provider-based state management for dynamic UI updates.<br>
- fl_chart: For creating visually engaging pie charts.<br>
- Quotes API: Integration for fetching motivational quotes dynamically.

**Setup and Installation** <br>

**Prerequisites**<br>
Ensure you have the following installed on your system:
<br>
Flutter SDK: Install Flutter<br>
Dart SDK (comes with Flutter)<br>
iOS Simulator or Android Emulator

*Steps*
Clone the repository:<br>
git clone https://github.com/mansi2804/mood-tracker-app.git
cd mood-tracker-app
Install dependencies:<br>
flutter pub get
Run the app on your preferred device:<br>
flutter run


**Testing**
Run the following commands to execute tests:

- Unit Tests:<br>

flutter test test/unit

- Widget Tests:<br>

flutter test test/widget

- Integration Tests:<br>

flutter drive --target=test_driver/app.dart

**Testing Coverage**

- Unit Tests: Cover key functionalities of model classes like MoodEntry.<br>
- Widget Tests: Validate UI elements such as pie charts, mood lists, and empty state messages.<br>
- Integration Test: Ensures seamless interaction between the provider, database, and UI components. <br>

**API Used**

- Random Quotes API<br> Provides dynamic motivational quotes on the Motivational Screen.<br> Example endpoint:<br> https://api.example.com/random-quote<br>
  
**Reflection**

- Building the Mood Tracker App was a rewarding experience that improved my skills in Flutter development, state management, and testing. While debugging and testing proved challenging, the satisfaction of delivering a functional and user-friendly app made it worthwhile.

**Thank You!**<br>
Thank you for checking out the Mood Tracker App! 🎉 Your interest and support mean a lot. If you have any feedback, feature suggestions, or would like to contribute, feel free to open an issue or submit a pull request.
<br>

Happy coding! 💻✨
