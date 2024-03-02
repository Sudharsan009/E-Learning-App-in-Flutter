import 'package:flutter/material.dart';

class Aboutpython extends StatefulWidget {
  const Aboutpython({super.key});

  @override
  State<Aboutpython> createState() => _AboutpythonState();
}

class _AboutpythonState extends State<Aboutpython> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.purple,
            title: Text(
              'About This Course',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    'Full-stack development refers to the design, implementation and testing of both the client, and server sides of a web application. A Python full-stack developer is proficient in handling the front- and back-end of a website or an application.',
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
                    'Database systems',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Continue learning back-end development by strengthening your knowledge of database systems. Start by learning relational database systems and get an overview of basic operations, such as read, join, merge, update and delete. Also, consider learning NoSQL databases to help you make your web application or website more scalable, flexible and available. In-depth knowledge of different database systems can be a valuable skill for you to possess.',
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
