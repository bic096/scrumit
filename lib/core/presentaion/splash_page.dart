import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/constant.dart';
import 'package:scrumit/core/presentaion/redirecting_screen.dart';

import '../../injection_container.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('enter only the subdomain'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    kAppWriteServerEndPoint =
                        'https://${controller.text}.eu.ngrok.io/v1';
                    showDialog(
                        context: context,
                        builder: (c) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });

                    await init();
                    // if (context.mounted) {
                    //   Navigator.pop(
                    //     context,
                    //   );
                    // }

                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RedirectingScreen()));
                    }
                  },
                  child: const Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}
