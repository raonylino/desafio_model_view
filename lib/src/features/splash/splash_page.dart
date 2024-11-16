import 'package:desafio_model_view/src/core/constants/routes_assets.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;
  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 100 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 3.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 39, 65, .2),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backpass.png'),
              fit: BoxFit.cover,
              opacity: 0.3),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 5),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () => Navigator.of(context)
                .pushReplacementNamed(RoutesAssets.validatorPage),
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.linearToEaseOut,
              width: _logoAnimationWidth,
              height: _logoAnimationHeight,
              child: const Image(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
