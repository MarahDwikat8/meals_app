import 'package:flutter/material.dart';
import '../models/area.dart';
import '../services/api_service.dart';
import 'meals_screen.dart';

class AreasScreen extends StatelessWidget {
  final ApiService apiService = ApiService(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Meal Areas'), 
        backgroundColor: Colors.deepOrange, 
      ),

      body: FutureBuilder<List<Area>>(
       

        future: apiService.fetchArea(), 

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          
            return Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
        
            return Center(child: Text('Error: ${snapshot.error}'));
          }
           else if (!snapshot.hasData || snapshot.data!.isEmpty) {
         
            return Center(child: Text('No areas found'));
          } 

          else {
           
            return ListView.builder(
              itemCount: snapshot.data!.length, 
              itemBuilder: (context, index) {
                final area = snapshot.data![index];
                return ListTile(
                  title: Text(area.strArea), 
                  trailing: Icon(Icons.arrow_forward_ios), 
                  onTap: () {
                 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealsScreen(area: area.strArea),
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









