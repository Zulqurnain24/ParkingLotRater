
# App Documentation for Parking Lot Rater

### Overview
Parking Lot Rater is a Flutter application designed to help users to review parking lots, categorize them into favorites and unfavorites and look into the parkinglot details. The app is built using the Flutter BLoC pattern for state management and is developed in Android Studio Koala (2024.1.1).

### Features

1-User can favorite the parking lot by swiping right / up or by pressing the heart icon

2-User can unfavorite the parking lot by swiping left or by pressing the x icon

3-User can tap onto the flash image to navigate to the "Choice Reviewer screen" which displayed the items sorted in ascending order with respect to the liveDate attribute

4-On tapping of item on the Choice Reviewer screen user will be able to open the detail screen for that item which is displaying all the relevant details available about the parking lot which includes image, name, size, status, and type

5-If the internet connection is not available the app will display the prompt saying 'Please connect to the internet and try again.'

### Screenshots
<img width="386" alt="Screenshot 2024-06-19 at 3 26 29 PM" src="https://github.com/Zulqurnain24/ParkingLotRater/assets/6280238/c532633d-0bae-4b1c-b6d9-73691d8e0a5d"><img width="390" alt="Screenshot 2024-06-18 at 2 43 28 PM" src="https://github.com/Zulqurnain24/ParkingLotRater/assets/6280238/4c3fd803-bc60-4121-a10b-4bb054663a82"><img width="390" alt="Screenshot 2024-06-18 at 2 43 20 PM" src="https://github.com/Zulqurnain24/ParkingLotRater/assets/6280238/518a59d7-3e5d-439c-b952-38ce7d3ad4be">

### Installation
To install and run the app:

### Clone the Repository:

git clone https://github.com/Zulqurnain24/ParkingLotRater

Open in Android Studio: Open Android Studio Koala and import the project.
In the terminal run the following commands:

flutter pub cache repair

flutter pub get

flutter run

### Running tests:

flutter test

