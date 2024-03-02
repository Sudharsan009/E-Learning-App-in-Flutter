import 'package:flutter/material.dart';

class AboutMERN extends StatefulWidget {
  const AboutMERN({super.key});

  @override
  State<AboutMERN> createState() => _AboutMERNState();
}

class _AboutMERNState extends State<AboutMERN> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.purple,
            title: Text(
              'About This Course',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Introduction',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "MERN stack developers are IT professionals who work on JavaScript technologies like MongoDB, Express, React.js and Node.js to develop web applications.",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Front-end technologies',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "HTML: HTML allows you to manage the structure and content of web pages."
                    "CSS: CSS enables you to customise the colours, fonts, positioning and responsiveness of web pages."
                    "JavaScript: JavaScript allows you to add interactivity and dynamic behaviour on web pages.",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Back-end development',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "PHP: PHP is a popular language for back-end systems and has frameworks that provide pre-built components, libraries and architectural patterns to facilitate rapid development."
                    "Ruby: Ruby is a programming language that allows for rapid development and scalability and provides features including database abstraction, scaffolding, security and session management."
                    "Django: Django is a Python framework that provides various features to develop the back end for web applications, including database interaction, built-in user authentication, URL routing and form handling."
                    "Flask: Flask is a Python web framework that focuses on ease of use, scalability and flexibility, and you use it primarily for small-scale projects.",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Databases and storage',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "Websites and applications require databases to manage data storage and access it. Understanding data storage and how to connect a database with programming languages is important in a full stack developer role.",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
