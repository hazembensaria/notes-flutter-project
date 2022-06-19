
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/views/LoginView.dart';
import 'package:mynotes/views/VerifyEmail.dart';
import 'package:mynotes/views/registerView.dart';
import 'firebase_options.dart';
import 'dart:developer' as dev show log;
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
            return  const NotesView();
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
enum MenuAction{logout}
class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('your notes'),
      actions: [
        PopupMenuButton<MenuAction>(onSelected: (value) async{
         switch (value){

           case MenuAction.logout:
             final shouldLogOut = await showLogOutDialog(context);
             if(shouldLogOut){
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/login/',
               (route) => false);
             }
             break;
         }
        },itemBuilder: (context){
          return const [
            PopupMenuItem<MenuAction>(value: MenuAction.logout,
             child:  Text('logout')
          ),
          ];
        },
        )
      ],
      ),
      body: const Text('welcome no motes yet !'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(context: context,
   builder: (context){
      return AlertDialog(
        title: const Text('Signe out'),
        content: const Text('Are you sure you want to signe out '),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: const Text('cancel'),
          ),
           TextButton(onPressed: (){
            Navigator.of(context).pop(true);
           }, child: const Text('sign out'),
           ),
        ],
      );

   },
   ).then((value) => value ?? false);

}








