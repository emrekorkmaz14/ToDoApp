import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/ui/shared/styles/text_style.dart';
import 'package:todoapp/ui/shared/widgets/password_text_field.dart';
import 'package:todoapp/ui/shared/widgets/user_name_text_field.dart';
import 'package:todoapp/ui/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/ui/view/sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _mail = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Welcome to "),
            Text(
              "ToDoApp",
              style: title,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserNameTextField(controller: _mail),
              const Divider(),
              PasswordTextField(controller: _pass),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05)),
                    onPressed: () async {
                      try {
                        UserCredential _user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: _mail.text.trim(),
                          password: _pass.text.trim(),
                        );
                        debugPrint(_user.toString());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeView()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    label: const Text('SignIn'),
                    icon: Icon(Icons.mail),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05)),
                    onPressed: () async {
                      try {
                        final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();
                        final GoogleSignInAuthentication? googleAuth =
                            await googleUser?.authentication;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeView()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    label: const Text('Google'),
                    icon: SvgPicture.asset("assets/google.svg"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have an acoount?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpView()));
                      },
                      child: Text(
                        "SignUp",
                        style: bgrey,
                      ))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
