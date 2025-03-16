import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

final rentPerDayProvider = StateProvider<String>((ref) => '');
final startDateProvider = StateProvider<DateTime?>((ref) => null);
final endDateProvider = StateProvider<DateTime?>((ref) => null);
final refundableDepositProvider = StateProvider<bool>((ref) => false);
final customNeedsProvider = StateProvider<String>((ref) => '');
final carouselIndexProvider = StateProvider<int>((ref) => 0);

final errorProvider = StateProvider<Map<String, String>>((ref) => {});

class ContractDetailsScreen extends ConsumerWidget {
  bool _validateForm(WidgetRef ref) {
    final rentPerDay = ref.read(rentPerDayProvider);
    final startDate = ref.read(startDateProvider);
    final endDate = ref.read(endDateProvider);

    Map<String, String> errors = {};

    if (rentPerDay.isEmpty) errors['rentPerDay'] = "Rent per day is required.";
    if (startDate == null) errors['startDate'] = "Start date is required.";
    if (endDate == null) errors['endDate'] = "End date is required.";

    ref.read(errorProvider.notifier).state = errors;
    return errors.isEmpty;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final rentPerDay = ref.watch(rentPerDayProvider);
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);
    final isRefundable = ref.watch(refundableDepositProvider);
    final customNeeds = ref.watch(customNeedsProvider);
    final errors = ref.watch(errorProvider);

    final List<String> images = [
      'assets/product1.jpg',
      'assets/product2.jpg',
      'assets/product3.jpg'
    ];

    return Scaffold(
appBar: AppBar(
  backgroundColor: theme.colorScheme.surface,
  toolbarHeight: 90, // Increased height slightly to accommodate avatar
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
    onPressed: () => Navigator.pop(context),
  ),
  title: Column(
    mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
    children: [
      CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/user.jpg')),
      SizedBox(height: 4),
      Text("John Doe", style: TextStyle(color: theme.colorScheme.onSurface)),
    ],
  ),
  centerTitle: true,
),



      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) {
                  ref.read(carouselIndexProvider.notifier).state = index;
                },
              ),
              items: images.map((imgPath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imgPath, fit: BoxFit.cover, width: double.infinity),
                );
              }).toList(),
            ),
            
            SizedBox(height: 20),
            Align(alignment: Alignment.centerLeft, child: Text("Product Name", style: TextStyle(color: theme.colorScheme.onSurface))),
            SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: Text("Condition", style: TextStyle(color: theme.colorScheme.onSurface))),
            SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: Text("Category", style: TextStyle(color: theme.colorScheme.onSurface))),
            SizedBox(height: 30),
            
            _buildTextField(
              "Rent per day",
              "Rs",
              rentPerDay,
              ref.read(rentPerDayProvider.notifier),
              true,
              theme,
              errors['rentPerDay'],
            ),

            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                      context, ref, "Start Date", startDate, startDateProvider, theme, errors['startDate']),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDatePicker(
                      context, ref, "End Date", endDate, endDateProvider, theme, errors['endDate']),
                ),
              ],
            ),

            SizedBox(height: 30),
            SwitchListTile(
              title: Text("Refundable deposit", style: TextStyle(color: theme.colorScheme.onSurface)),
              value: isRefundable,
              onChanged: (value) => ref.read(refundableDepositProvider.notifier).state = value,
            ),

            SizedBox(height: 30),
            _buildTextField(
              "Custom Needs (Optional)",
              "",
              customNeeds,
              ref.read(customNeedsProvider.notifier),
              false,
              theme,
              null, // No error for optional field
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_validateForm(ref)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContractGeneratedScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please correct the errors before proceeding.")),
                  );
                }
              },
              child: Text("Generate Contract"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String prefix, String value, StateController<String> provider, bool isNumeric, ThemeData theme, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
        SizedBox(height: 8),
        TextField(
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: theme.colorScheme.secondary),
            prefixText: prefix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorText: error, // Displays error message if any
          ),
          onChanged: (val) {
            provider.state = val;
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, WidgetRef ref, String label, DateTime? date,
      StateProvider<DateTime?> provider, ThemeData theme, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              ref.read(provider.notifier).state = pickedDate;
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              errorText: error, // Displays error message if any
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null ? DateFormat('yyyy-MM-dd').format(date) : label,
                  style: TextStyle(color: theme.colorScheme.secondary),
                ),
                Icon(Icons.calendar_today, color: theme.colorScheme.onSurface),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContractGeneratedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contract Generated")),
      body: Center(child: Text("Your contract has been successfully generated!")),
    );
  }
}
