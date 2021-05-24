import 'package:fengshuinumber/src/core/navigation/route_information_parser.dart';
import 'package:fengshuinumber/src/core/navigation/router_delegate.dart';
import 'package:fengshuinumber/src/core/util/asset_path.dart';
import 'package:fengshuinumber/src/core/util/validators.dart';
import 'package:fengshuinumber/src/features/home/presentation/notifiers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AssetPath.blob1,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Column(children: [
                  Text(
                    'Feng Shui number Verification',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
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
                  Text(
                    'Please enter the phone number',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefix: Text('  '),
                        prefixIcon: PhoneLogoPrefixWidget(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: phoneValidator,
                      onChanged: (value) =>
                          context.read(phoneNumberInputProvider).state = value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'\d*')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                        width: double.infinity,
                        child: Consumer(builder: (context, watch, child) {
                          final isValidPhoneNumber =
                              watch(phoneValidationProvider);
                          return ProviderListener(
                            onChange: (BuildContext context, value) {
                              context
                                  .read(seedRouterDelegateProvider)
                                  .addPage(PageConfiguration.result());
                            },
                            provider: verifyFengShuiNumberProvider,
                            child: ElevatedButton(
                                onPressed: isValidPhoneNumber
                                    ? () {
                                        context
                                            .read(verifyFengShuiNumberProvider
                                                .notifier)
                                            .check();
                                      }
                                    : null,
                                child: Text('Check')),
                          );
                        })),
                  ),
                  Spacer(),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneLogoPrefixWidget extends StatelessWidget {
  const PhoneLogoPrefixWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          )),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer(builder: (context, watch, child) {
            final carrierLogo = watch(carrierLogoProvider);
            if (carrierLogo.isEmpty) {
              return SizedBox(
                width: 48,
                child: Icon(
                  Icons.phone,
                  size: 24,
                ),
              );
            }
            return Image.asset(
              carrierLogo,
              width: 48,
              fit: BoxFit.contain,
            );
          }),
        ),
      ),
    );
  }
}
