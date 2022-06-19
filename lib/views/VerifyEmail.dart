import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('verify email')),
      body: Column(
          children: [
              const Text('we sent you a mail please go and check it , it may be in spam ')  ,
          const Text('try again if you d\'ont receve an email ')  ,
                TextButton(onPressed: (() async{
                  final user = FirebaseAuth.instance.currentUser ; 
                  await user?.sendEmailVerification();
                  print('mail sended');
                }), child: const Text('send mail again'))
        ]),
    );
    
  }
}
