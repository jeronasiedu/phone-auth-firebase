import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../controllers/phone_auth_controller.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key, required this.phone, required this.verificationId, this.forceResendingToken});

  final String phone;
  final String verificationId;

  final int? forceResendingToken;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  // create a function for the didn't receive code and let it activate a timer

  int timeUntilNextResend = Duration.secondsPerMinute;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (timeUntilNextResend < 1) {
        timer.cancel();
      } else {
        setState(() {
          timeUntilNextResend--;
        });
      }
    });
  }

  Future<void> resendOtp() async {
    PhoneAuthController.sendOtp(
      context,
      widget.phone,
      forceResendingToken: widget.forceResendingToken,
    );
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).colorScheme.primary),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phone),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              const Text(
                "To complete your phone number verification, please enter the 6 digit code sent to your phone number.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                onCompleted: (value) {
                  PhoneAuthController.verifyOtp(
                    context: context,
                    otp: value,
                    verificationId: widget.verificationId,
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: timeUntilNextResend == 0 ? resendOtp : null,
                child: Text(timeUntilNextResend == 0
                    ? "Resend code again"
                    : "Resend code in 00:${timeUntilNextResend.toString().padLeft(2, '0')}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
