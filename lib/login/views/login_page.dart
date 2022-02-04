import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'package:intern_app/login/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(_authenticationRepository),
      child: Center(
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is Loging) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loging")
                ],
              );
            } else {
              return ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().logInWithGoogle();
                },
                child: const Text("Sign in with Google"),
              );
            }
          },
        ),
      ),
    );
  }
}
