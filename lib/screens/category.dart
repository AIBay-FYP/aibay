import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// Fetch Data from Backend
final listingsProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await Dio().get('http://localhost:5000/listings');
  print("Fetched items: ${response.data.length}");  // Debugging
  return response.data;
});

class CategoryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsyncValue = ref.watch(listingsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: listingsAsyncValue.when(
        data: (listings) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Prevents grid scrolling
              shrinkWrap: true, // Fits within the SingleChildScrollView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                childAspectRatio: 0.9, // Adjusted for UI
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: listings.length,
              itemBuilder: (context, index) {
                final item = listings[index];
                return _buildCategoryItem(item);
              },
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading data')),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
          width: double.infinity, // Ensures it takes full width of the card
          height: 120, // Square image with fixed height
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              item['Photos'][0],
              fit: BoxFit.cover, // Covers the entire box without distortion
            ),
          ),
        ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['Title'], 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis),
                SizedBox(height: 4),
                Text('${item['MinPrice']} - ${item['MaxPrice']} ${item['Currency']}',
                  style: TextStyle(fontSize: 12)),
                if (item['IsNegotiable'])
                  Text('Negotiable', 
                    style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
