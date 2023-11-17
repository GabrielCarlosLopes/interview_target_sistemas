import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/presenter/presenter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  final SplashPresenterStore presenter = GetIt.I<SplashPresenterStore>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
    _controller?.forward();
    presenter.loggedIn();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        if (presenter.redirect != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pushReplacement(presenter.redirect!);
          });
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation!,
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator.adaptive(),
          ],
        );
      }),
    );
  }
}
