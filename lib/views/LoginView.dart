import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/Constance/routes.dart';

import '../Utilities/ErrorAlert.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
  }

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: const Text('Login')),
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
                            await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushNamedAndRemoveUntil(notesRoute,
                            (route) => false);
                            }
                            on FirebaseAuthException catch (e){
                            if(e.code == 'user-not-found'){
                              await showErrorDialog(context, e.code);
                            }else{
                           await showErrorDialog(context, e.code);
                            }
    
                          }catch (e){
                       await showErrorDialog(context, e.toString());
                                    }
                    },
                    child: const Text('Login'),
                    ),
    
                    TextButton(onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(registerRoute,
                       (route) => false);
                    }, child: const Text("register now")
                    ),
                  ],
                ),
    );
    
  }
}


