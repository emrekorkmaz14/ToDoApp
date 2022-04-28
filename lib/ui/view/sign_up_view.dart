import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/ui/shared/styles/text_style.dart';
import 'package:todoapp/ui/shared/widgets/password_text_field.dart';
import 'package:todoapp/ui/shared/widgets/user_name_text_field.dart';
import 'package:todoapp/ui/view/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _mail = TextEditingController();
  final _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserNameTextField(controller: _mail),
              const Divider(),
              PasswordTextField(controller: _pass),
              const Divider(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05)),
                onPressed: () async {
                  try {
                    UserCredential _user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _mail.text.trim(),
                      password: _pass.text.trim(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Başarılı"),
                      ),
                    );
                    debugPrint(_user.toString());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignInView()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                label: const Text('Sign Up'),
                icon: const Icon(Icons.mail),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("or"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignInView()));
                      },
                      child: Text(
                        "Login",
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
