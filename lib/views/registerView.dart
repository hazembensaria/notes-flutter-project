import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:mynotes/Constance/routes.dart';
import 'package:mynotes/Utilities/ErrorAlert.dart';

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
     return  Scaffold(
      appBar: AppBar(title: const Text('register')),
       body: Column(
                      
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
                      try{
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                        final user = FirebaseAuth.instance.currentUser ; 
                        await user?.sendEmailVerification();
                        Navigator.of(context).pushNamed(VerifyEmailRoute);
                      }
                 on FirebaseAuthException catch (e){
                      await showErrorDialog(context, e.code);
                  }catch(e){
                    await showErrorDialog(context, e.toString());
                  }
                    },
                    child: const Text('registre'),
                    ),
                    TextButton(onPressed: (() {
                      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute,
                       (route) => false);
                    }), child: const Text('I have an account')
                    ),
                  ],
                ),
     );

  }
}
