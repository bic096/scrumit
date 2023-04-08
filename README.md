# Scrumit
Scrumit is a project management app designed to help teams organize and streamline their  
work using the Scrum methodology. This Flutter app is built using Clean Architecture and  
integrated with Appwrite as a backend for data storage and Dyte for video meetings.

## Installation
To use Scrumit, follow these steps:

1. Clone this repository to your local machine
2. Open the project in your preferred IDE (such as Android Studio or Visual Studio Code)
3. Install the necessary dependencies by running the flutter pub get command in your terminal
4. Run the app on an emulator or physical device using the flutter run command in your terminal
## Features
Scrumit has the following features:

* User authentication and authorization through Appwrite
* CRUD operations for projects and tasks using Appwrite
* Integration with Dyte for video meetings
* Integration with Google Maps for location-based features
* Clean Architecture for separation of concerns and testability
## Usage
To use Scrumit, you'll need to set up an Appwrite server and configure the app to connect to  
your server. Follow these steps to set up Appwrite:

1. Download and install Appwrite on your machine. You can find the installation instructions  
for your operating system in the Appwrite documentation.
2. Create a new Appwrite project and add a new database to the project. You can find the  
instructions for creating a project and database in the Appwrite documentation.
3. Create a new API key for the project. You can find the instructions for creating an API key  
in the Appwrite documentation.
4. Replace the APPWRITE_ENDPOINT, APPWRITE_PROJECT_ID, and APPWRITE_API_KEY values in the  
lib/core/constants.dart file with your own endpoint, project ID, and API key.
5. Save the changes to the constants.dart file.  

Once you've set up Appwrite, open the Scrumit app on your emulator or physical device and  
sign in using your Appwrite account credentials. Once you're signed in, you'll be able to  
create, read, update, and delete projects and tasks, as well as start video meetings using  
Dyte.

## Contributing
We welcome contributions from anyone who would like to improve Scrumit. If you'd like to   
contribute, please follow these steps:

1. Fork this repository to your own GitHub account
2. Create a new branch for your changes
3. Make your changes and commit them to your branch
4. Push your changes to your fork
5. Create a pull request to merge your changes into the main branch
## Credits
<!--Scrumit was created by [Your Name] and [Your Team], with contributions from [Other Contributors].-->

## License
<!--Scrumit is licensed under the MIT License.-->

For help getting started with Flutter development, view the  
[online documentation](https://docs.flutter.dev/), which offers tutorials,  
samples, guidance on mobile development, and a full API reference.  
