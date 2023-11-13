import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_login.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getGradient(),
        ),
        child: Center(
          child: Hero(
            tag: 'logoHero',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return TelaLogin();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = 0.0;
                      const end = 1.0;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var opacityAnimation = tween.animate(animation);

                      return FadeTransition(
                        opacity: opacityAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Image.asset("assets/images/logo1.png"),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient getGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 2, 159, 212),
        Color.fromARGB(255, 168, 227, 247),
      ],
    );
  }
}