import 'package:annapurna_chef/constants/colors.dart';
import 'package:annapurna_chef/providers/auth_provider.dart';
import 'package:annapurna_chef/ui/custom_widgets/rounded_input.dart';
import 'package:annapurna_chef/utils/progress_dialog.dart';
import 'package:annapurna_chef/utils/save_data.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  _checkLoggedIn() async {
    var token = await SaveData.getToken();
    if (token != "") {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      });
    }
  }

  _login() {
    ref
        .watch(authNotifierProvider)
        .login(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInset = MediaQuery.of(context)
        .viewInsets
        .bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    return Scaffold(
      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final provider = ref.watch(authNotifierProvider);

        if (provider.apiResponse.isLoading) {
          return const ProgressDialog();
        }
        if (provider.apiResponse.model == "success") {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            // Navigator.pushNamed(context, Routes.dashboard);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          });
        }
        if (provider.apiResponse.model == "You are not authorized") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: provider.apiResponse.model,
            btnOkOnPress: () {
              Navigator.of(context).pop();
            },
          ).show();
        }

        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                  child: Container(
                width: size.width,
                height: defaultLoginSize,
                child: Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Chef Login ",
                          style: TextStyle(fontSize: 50),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        RoundedInput(
                          icon: Icons.email,
                          hint: "Email",
                          controller: emailController,
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundedInput(
                            icon: Icons.lock_outline,
                            hint: "Password",
                            controller: passwordController,
                            isPassword: true),
                        const SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                          onPressed: _login,
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: colorVacant),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: colorVacant),
                          ),
                        )
                      ]),
                ),
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.1,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.blueGrey),
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(color: colorVacant, fontSize: 18),
                    )),
              ),
            )
          ],
        );
      }),
    );
  }
}
