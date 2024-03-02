import 'package:flutter/material.dart';

class AboutJava extends StatefulWidget {
  const AboutJava({super.key});

  @override
  State<AboutJava> createState() => _AboutJavaState();
}

class _AboutJavaState extends State<AboutJava> {
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
                    "Full-stack is a combination of both front-end and back-end development. You can become an expert with years of experience or through learning platforms and certification courses. A full-stack developer works on both the client-side and server-side programming. Their skill levels are such that they can shift from one language to another or from one technology to another without difficulty.",
                    style: TextStyle(color: Colors.white),
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
                    "A Java full-stack developer's mastery over back-end programming languages helps them to code for the server-side."
                    "Java Server Pages is a back-end technology that helps with server-side processing. "
                    "You can create web applications with JSP using Java as the programming language."
                    " It is another indispensable technology that a Java full-stack developer may benefit from learning.",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Frameworks',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "Spring is popular among the available frameworks for Java. Clients prefer frameworks like Spring MVC, Spring Cloud and Spring Boot, as they simplify coding in Java. By using Spring, developers can create high-quality, reusable and functional code.",
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
