import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Timer(const Duration(milliseconds: 5000), () => Navigator.of(context).pushReplacementNamed('/home'));
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Clique no portal para continuar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
                  child: Image.asset(
                    "assets/images/portal.gif",
                    width: MediaQuery.of(context).size.width * 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Feito por '),
                      TextButton(
                        onPressed: () => _launchUrl('https://github.com/danilojmessias'),
                        child: const Text('Danilo', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Text('e'),
                      TextButton(
                        onPressed: () => _launchUrl('https://github.com/donthegust'),
                        child: const Text('Gustavo', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
