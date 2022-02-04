import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_app/app/bloc/authentication_bloc.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'package:intern_app/login/cubit/login_cubit.dart';
import 'package:intern_app/login/views/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_app/profile/profile.dart';

class AppPage extends StatelessWidget {
  AppPage({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((AuthenticationBloc bloc) => bloc.state.status);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<AuthenticationBloc>()),
        BlocProvider.value(value: LoginCubit(_authenticationRepository))
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: status == AppStatus.authenticated
            ? const ProfilePage()
            : LoginPage(
                authenticationRepository: _authenticationRepository,
              ),
      ),
    );
  }
}
