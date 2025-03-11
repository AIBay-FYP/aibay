import 'package:aibay/providers/country_code.dart';
import 'package:aibay/providers/phoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberField extends ConsumerWidget {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String countryCode = ref.watch(countryCodeProvider);
    final phoneNumber = ref.watch(phoneNumberProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight*0.01),
      child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            ref.read(phoneNumberProvider.notifier).state = number.phoneNumber ?? "";
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
            setSelectorButtonAsPrefixIcon: true,
            showFlags: true,
            useBottomSheetSafeArea: true,  
            leadingPadding: screenWidth * 0.03        
          ),
          ignoreBlank: false,
          initialValue: PhoneNumber(isoCode: countryCode), // Use the country code from the provider
          textFieldController: TextEditingController(),
          inputDecoration: InputDecoration(
            hintText: 'Enter your phone number',
            hintStyle: textTheme.bodyMedium,
            filled: true,
            fillColor: colorScheme.onSecondary, // Set the background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.onSecondary, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.onSecondary, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.onSecondary.withValues(alpha:0.5), width: 1),
            ),
          ),
          onInputValidated: (bool isValid) {
            // Handle validation if necessary
          },
          selectorTextStyle: textTheme.bodyLarge,
          formatInput: true,
      ),
    );
  }
}
