import 'package:flutter/material.dart';
import 'package:scrumit/core/presentaion/splash_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: true,
        done: const Text("Done"),
        skip: const Text("Skip"),
        next: const Text("Next"),
        globalBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        pages: [
          PageViewModel(
            title: 'Welcome to Scrumit!',
            body:
                'Scrumit has everything you need for effective project management, including Agile Scrum support, task management, sprint planning, team management, reports and analytics, and a user-friendly interface. And best of all, it\'s completely free!',
            image: Image.asset('assets/a1.jpg'),
          ),
          PageViewModel(
            title: 'Features',
            body:
                'Welcome to Scrumit! Our free app helps you manage projects, teams, and tasks with ease. Scrumit is perfect for organizations looking to implement Agile Scrum methodology for improved productivity.',
            image: Image.asset(
              'assets/b2.png',
            ),
          ),
          PageViewModel(
            title: 'Get Started',
            body:
                'Ready to improve your project management with Scrumit? Sign up now for our free app! Our support team is available 24/7 to assist you. With Scrumit\'s intuitive features and interface, you can start using it right away to streamline your workflow and increase productivity.',
            image: Image.asset(
              'assets/a3.jpg',
            ),
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SplashPage()));
        },
      ),
    );
  }
}






// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IntroSlider(
//       listContentConfig: [
//         ContentConfig(
//           foregroundImageFit: BoxFit.fill,
//           widthImage: MediaQuery.of(context).size.width,
//           heightImage: MediaQuery.of(context).size.width,
//           backgroundColor: const Color.fromARGB(255, 168, 176, 223),
//           title: 'Welcome to Scrumit!',
//           description:
//               'Welcome to Scrumit! Our free app helps you manage projects, teams, and tasks with ease. Scrumit is perfect for organizations looking to implement Agile Scrum methodology for improved productivity.',
//           pathImage: 'assets/a1.jpg',
//         ),
//         ContentConfig(
//           foregroundImageFit: BoxFit.fill,
//           widthImage: MediaQuery.of(context).size.width,
//           heightImage: MediaQuery.of(context).size.width,
//           backgroundColor: const Color.fromARGB(255, 168, 176, 223),
//           title: 'Features',
//           description:
//               'Scrumit has everything you need for effective project management, including Agile Scrum support, task management, sprint planning, team management, reports and analytics, and a user-friendly interface. And best of all, it\'s completely free!',
//           pathImage: 'assets/a2.jpg',
//         ),
//         ContentConfig(
//           foregroundImageFit: BoxFit.fill,
//           widthImage: MediaQuery.of(context).size.width,
//           heightImage: MediaQuery.of(context).size.width,
//           backgroundColor: const Color.fromARGB(255, 168, 176, 223),
//           title: 'Get Started',
//           description:
//               'Ready to improve your project management with Scrumit? Sign up now for our free app! Our support team is available 24/7 to assist you. With Scrumit\'s intuitive features and interface, you can start using it right away to streamline your workflow and increase productivity.',
//           pathImage: 'assets/a3.jpg',
//         ),
//       ],
//       onDonePress: () {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => SplashPage()));
//       },
//     );
//   }
// }
