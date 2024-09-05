import 'package:flutter/material.dart';
import '../models/meal.dart'; 
import '../services/api_service.dart'; 
import 'package:url_launcher/url_launcher.dart'; 

class MealDetailsScreen extends StatelessWidget {
  final String mealId;
  final ApiService apiService = ApiService();

  
  MealDetailsScreen({required this.mealId});

 
  Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Details'), 
        backgroundColor: Colors.deepOrange, 
      ),

      body: FutureBuilder<MealDetails>(
        future: apiService.fetchMealDetails(mealId), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); 
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          else if (!snapshot.hasData) {
            return Center(child: Text('No meal details found')); 
          }
          
           else {
            final meal = snapshot.data!; 
            return ListView(
              padding: const EdgeInsets.all(16.0),

              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), 
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.network(
                          meal.strMealThumb,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250,
                        ),

                        Container(
                        //  child: Text("hi------------------"),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  meal.strMeal,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),

                SizedBox(height: 8),

                Divider(color: Colors.grey.shade300),
           
                SizedBox(height: 8),

                Text(
                  'Category: ${meal.strCategory}',
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(height: 8),
                
                Text(
                  'Area: ${meal.strArea}',
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(height: 16),

                const Text(
                  'Instructions:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  meal.strInstructions,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => _launchURL(meal.strYoutube), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange, 
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(width: 8),
                      Text('Watch on YouTube'),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

 