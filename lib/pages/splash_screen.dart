import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:contactlist/controller/home_controller.dart';
import 'package:contactlist/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getData() async {
    //delay só pra fazer a animação da splash
    Future.delayed(const Duration(milliseconds: 7000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomePage()));
    });
  }

  //função que vai carregar o controller ao iniciar o app, semelhante ao iniState
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<HomeController>(context, listen: false).getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('Contact List'),
              FadeAnimatedText('with Back4App!!'),
            ],
          ),
        ),
      ),
    );
  }
}
