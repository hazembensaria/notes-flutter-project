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
          const Text('please verify your email ')  ,
                TextButton(onPressed: (() async{
                  final user = FirebaseAuth.instance.currentUser ; 
                  await user?.sendEmailVerification();
                  print('mail sended');
                }), child: const Text('Verify email'))
        ]),
    );
    
  }
}
