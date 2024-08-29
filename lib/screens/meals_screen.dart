import 'package:flutter/material.dart';
import '../models/meal.dart'; 
import '../services/api_service.dart'; 
import 'meal_details_screen.dart'; 


class MealsScreen extends StatelessWidget {
  
  final String area;
  final ApiService apiService = ApiService();

  
  MealsScreen({required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('$area Meals'),
        backgroundColor: Colors.deepOrange, 
      ),
     
      body: FutureBuilder<List<Meal>>(
      
        future: apiService.fetchMealsByArea(area),
        builder: (context, snapshot) {
         
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
       
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found for $area'));
          }
          
          else {
           
            return ListView.builder(
              itemCount: snapshot.data!.length, 
              itemBuilder: (context, index) {
                final meal = snapshot.data![index]; 
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      meal.strMealThumb, 
                      width: 50,
                      height: 50, 
                      fit: BoxFit.cover, 
                    ),
                  ),
                  title: Text(
                    meal.strMeal, 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios), 
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailsScreen(mealId: meal.idMeal),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
