import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intern_app/app/bloc/authentication_bloc.dart';
import 'package:intern_app/app/repository/auth_repository.dart';
import 'package:intern_app/app/views/app.dart';
import 'package:intern_app/simpleAnimation.dart';
import 'logoanimator.dart';
import 'logoanimatorlandscape.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _authenticationRepository = AuthenticationRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text("Animation", style: TextStyle()),
        ),
        actions: [profileButton(context)],
      ),
      body: _layoutDetails(context),
      floatingActionButton: FloatingActionButton(
        key: const Key('change'),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RiveAnimationPage())),
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  IconButton profileButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepositoryProvider.value(
                value: _authenticationRepository,
                child: BlocProvider(
                  create: (context) => AuthenticationBloc(
                    authenticationRepository: _authenticationRepository,
                  ),
                  child: AppPage(
                    authenticationRepository: _authenticationRepository,
                  ),
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.account_box_outlined));
  }

  Widget _layoutDetails(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return const LogoAnimator();
    } else {
      return const LogoAnimatorLandscape();
    }
  }
}
