import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/Tools/Widgets.dart';
import 'package:task_manager/bloc/task_manager_bloc.dart';

class SignIn extends StatefulWidget {
  static const Route = '/SignIn';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // late UserCredential userCredential;
  late String Email, Password;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            topImageMethod(1),
            bottomImageMethod(1, Height),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 240),
                  child: Form(
                      key: formstate,
                      child: Column(
                        children: [
                          TextFormFieldMethod(
                              "Username",
                              "Username can't to be larger than 40 letter",
                              "Username can't to be less than 2 letter",
                              Icons.lock,
                              "Username",
                              TextInputType.text,
                              40,
                              2,
                              UsernameController),
                          SizedBox(height: 15),
                          TextFormFieldMethod(
                              "Password",
                              "Password can't to be larger than 40 letter",
                              "Password can't to be less than 4 letter",
                              Icons.article,
                              "Password",
                              TextInputType.text,
                              40,
                              4,
                              PasswordController),
                          SizedBox(height: 15),
                          // GoToSignMethod(context, "Don't hava an account ? ",
                          //     SignUp.Route),
                          SizedBox(height: 15),
                          InkWell(
                            child: SignInButtonMethod("Sign in"),
                            onTap: () async {
                              LottieMethod("Loading");
                              var formdata = formstate.currentState;
                              if (formdata!.validate()) {
                                formdata.save();
                                BlocProvider.of<TaskManagerBloc>(context).add(
                                    SignInEvent(
                                        Username:
                                            UsernameController.text.toString(),
                                        Password:
                                            PasswordController.text.toString(),
                                        context: context));
                                //  await SharedPrefs().init();
                              } else {
                                print("Not Vaild");
                              }
                              // Navigator.of(context)
                              //     .pushReplacementNamed(MyFriends.Route);
                            },
                          )
                        ],
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
