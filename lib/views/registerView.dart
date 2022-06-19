import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {


late final TextEditingController _email ;
late final TextEditingController _password ;

@override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
@override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar( title:const Text('register')) ,
      body: FutureBuilder(
        future: Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
                   ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
                  return  Column(
                    
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration( hintText: 'enter your email'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration( hintText: 'enter your password'),
                  ),
                  TextButton(onPressed: () async {
              
                    final email = _email.text ;
                    final password = _password.text;
                final user =    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                print(user);
                  },
                  child: const Text('registre'),
                  ),
                ],
              );

              default :
              return  const Text('loading');

          }
     
          
        
        },
      ),
    );
    
  }
}