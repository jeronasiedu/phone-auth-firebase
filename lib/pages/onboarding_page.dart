import 'package:auth/pages/phone_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Image.asset(
                  'assets/onboarding.gif',
                ),
              ),
              const Spacer(),
              Text(
                'Welcome to Phone Auth Tutorial',
                style: Theme.of(context).textTheme.titleLarge!.apply(
                      fontWeightDelta: 2,
                    ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  "The ultimate Firebase Phone Auth Tutorial for absolute beginners.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) {
                          return const PhonePage();
                        },
                      ));
                    },
                    label: const Text('Continue With Phone'),
                    icon: const Icon(CupertinoIcons.phone_fill),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    ;
  }
}
