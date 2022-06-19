import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/views/LoginView.dart';
import 'package:mynotes/views/VerifyEmail.dart';
import 'package:mynotes/views/registerView.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
       MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeView(),
      routes: {
        '/login/':(context) => const LoginView(),
        '/register/':(context) => const RegisterView()
      },
    )
  );
}




class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
                   ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if(user != null){
                if(!user.emailVerified){
                    return const VerifyEmail();
                }
            }else{
              return const LoginView();
            }
            return  Text('done');
          //   if(user?.emailVerified ?? false){
          //         return Text('done') ;
          //   }else{
          //  return const VerifyEmail();
              // } 
                        return const LoginView();
              default :
              return  const CircularProgressIndicator();

          }


        },
      );
    
  }
}









