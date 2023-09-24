import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  late Size size;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  String errorLogin = "";
  bool isShowPassword = false;

  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 50, child: _buildTop(context)),
            Positioned(bottom: 0, child: _buildButtom(context))
          ],
        ),
      ),
    );
  }

  SizedBox _buildButtom(context) {
    return SizedBox(
      width: size.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
            padding: const EdgeInsets.all(30), child: _buildForm(context)),
      ),
    );
  }

  SizedBox _buildTop(context) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_sharp,
            size: 150,
            color: Colors.white,
          ),
          Text(appLocalizations.trans(context, appStrings.APP_NAME_KEY),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                appLocalizations.trans(
                    context, appStrings.WELECOME_MESSAGE_KEY),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            Text(
                appLocalizations.trans(
                    context, appStrings.LOGIN_INFO_MESSAGE_KEY),
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.trans(
                      context, appStrings.USER_NAME_REQUIRED_MESSAGE_KEY);
                }
                return null;
              },
              controller: userNameController,
              decoration: InputDecoration(
                label: Text(
                    appLocalizations.trans(context, appStrings.USER_NAME_KEY),
                    style: const TextStyle(color: Colors.grey, fontSize: 18)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.trans(
                      context, appStrings.PASSWORD_REQUIRED_MESSAGE_KEY);
                }
                return null;
              },
              controller: passwordController,
              obscureText: !isShowPassword,
              decoration: InputDecoration(
                  label: Text(
                      appLocalizations.trans(context, appStrings.PASSWORD_KEY),
                      style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye))),
            ),
            const SizedBox(
              height: 10,
            ),
            (errorLogin.isEmpty
                ? const SizedBox()
                : Center(
                    child: Text(errorLogin,
                        style: const TextStyle(color: Colors.red)))),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () async {
                    onLoginClick(context);
                  },
                  child: Text(
                    appLocalizations.trans(context, appStrings.LOGIN_KEY),
                    style: const TextStyle(fontSize: 18),
                  )),
            )
          ],
        ));
  }

  void onLoginClick(context) async {
    var userName = userNameController.text;
    var password = passwordController.text;
    if (_formKey.currentState!.validate() &&
        userName == "admin" &&
        password == "admin") {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginEvent(userName: userName, password: password));
    } else if (userNameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      setState(() {
        errorLogin = "";
      });
    } else {
      setState(() {
        errorLogin =
            appLocalizations.trans(context, appStrings.LOGIN_ERROR_MESSAGE_KEY);
      });
    }
  }
}
