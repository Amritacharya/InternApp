import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'package:intern_app/login/cubit/login_cubit.dart';
import 'package:intern_app/login/cubit/login_state.dart';

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
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red[200],
              content: Text(
                state.error,
                style: const TextStyle(fontSize: 16),
              ),
            ));
          }
        },
        child: Center(
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loging")
                  ],
                ),
                orElse: () => loginButton(context),
              );
            },
          ),
        ),
      ),
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<LoginCubit>().logInWithGoogle();
      },
      child: const Text("Sign in with Google"),
    );
  }
}
