import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final txtemail = TextEditingController();
  final txtsubject = TextEditingController();
  final txtmsg = TextEditingController();
  var lbl_text = "";

  Future<void> sendingemail() async {
    try {
      var message = Message();
      var userEmail = 'testingapp10101@gmail.com';
      var password = ''; // Replace with your app password

      message.subject = txtsubject.text;
      message.text = txtmsg.text;
      message.from = userEmail;
      message.recipients.add(txtemail.text);

      var smtpServer = gmail(userEmail, password);

      await send(message, smtpServer);
      setState(() {
        lbl_text = 'Email Sent Successfully!';
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        lbl_text = 'Failed to send email: ${e.toString()}';
      });
    } finally {
      txtemail.clear();
      txtsubject.clear();
      txtmsg.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('Mail  from  flutter'),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              TextField(
                controller: txtemail,
                decoration: const InputDecoration(hintText: 'Enter email...'),
              ),
              TextField(
                controller: txtsubject,
                decoration: const InputDecoration(hintText: 'Enter Subject...'),
              ),
              TextField(
                controller: txtmsg,
                decoration: const InputDecoration(hintText: 'Enter Message...'),
              ),
              OutlinedButton(
                onPressed: sendingemail,
                child: const Text('Send'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(lbl_text),
              )
            ],
          ),
        ),
      ),
    );
  }
}
