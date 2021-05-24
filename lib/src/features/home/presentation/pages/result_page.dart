import 'package:fengshuinumber/src/core/util/asset_path.dart';
import 'package:fengshuinumber/src/features/home/presentation/notifiers/home_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AssetPath.blob2,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        AssetPath.fengshui,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Consumer(
                      builder: (context, watch, child) {
                        final result = watch(verifyFengShuiNumberProvider);
                        if (result == null) {
                          return Container();
                        } else if (result) {
                          final phoneInput =
                              context.read(phoneNumberInputProvider).state;
                          return Text.rich(
                            TextSpan(
                              text: phoneInput,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final _url = 'tel:$phoneInput';
                                  await canLaunch(_url)
                                      ? await launch(_url)
                                      : throw 'Could not launch $_url';
                                },
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              children: [
                                TextSpan(
                                    text: ' is a good feng shui number.',
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                    )),
                              ],
                            ),
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          );
                          // return Text.rich(
                          //   '$phoneInput is a good feng shui number.',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headline6!
                          //       .apply(color: Theme.of(context).primaryColor),
                          //   textAlign: TextAlign.center,
                          // );
                        }
                        return Text(
                            'Your number provider is not a good feng shui number!',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .apply(color: Colors.red),
                            textAlign: TextAlign.center);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Okay')),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
