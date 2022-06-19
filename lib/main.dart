import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/views/LoginView.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
       MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    )
  );
}




class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar( title:const Text('Home')) ,
      body: FutureBuilder(
        future: Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
                   ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if(user?.emailVerified ?? false){
              print('email verified ') ; 

            }else{
              print('you have to verified your email') ;
            }
                return Text('done') ;
                
              default :
              return  const Text('loading');

          }

        },
      ),
    );
    
  }
}








