import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var alert = "";
  Future<void> sendingemail() async {
    try {
      var message = Message();
      var userEmail = 'testingapp10101@gmail.com';
      message.subject = 'Sending subject from flutter';
      message.text = 'get my email....';

      message.from = userEmail;
      message.recipients.add(userEmail);

      var smtpServer = gmail(userEmail, 'app_password');   //use app password from gmail
      
      
      send(message, smtpServer);
      print('sent');
    } catch (e) {
      print('${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mail  from  flutter'),
          centerTitle: true,
        ),
        body: Container(
          child: OutlinedButton(onPressed: sendingemail, child: Text('send')),
        ),
      ),
    );
  }
}
