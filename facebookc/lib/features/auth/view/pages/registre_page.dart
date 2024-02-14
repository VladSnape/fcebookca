import 'package:facebookc/features/auth/view/bloc/loginCubit/cubit/login_cubit_cubit.dart';
import 'package:facebookc/features/auth/view/widgets/login_button.dart';
import 'package:facebookc/features/auth/view/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrePage extends StatefulWidget {
  final void Function()? toggle;

  const RegistrePage({super.key, this.toggle});

  @override
  State<RegistrePage> createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 29, 53),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/images/facebook-logo-2019.png',
                        width: MediaQuery.sizeOf(context).width * 0.2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginTextField(
                        obscure: false,
                        controller: nameController,
                        text: 'Name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        obscure: false,
                        controller: userNameController,
                        text: 'userName',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        obscure: false,
                        controller: emailController,
                        text: 'email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        obscure: true,
                        controller: passwordController,
                        text: 'Password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginButton(
                        isprimary: true,
                        text: 'Sign up',
                        onTap: () async {
                          await BlocProvider.of<LoginCubitCubit>(context)
                              .registreUser(
                                  userName: userNameController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                        },
                      )
                    ]),
                LoginButton(
                  isprimary: false,
                  text: 'login account',
                  onTap: widget.toggle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
