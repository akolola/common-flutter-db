
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
  
void main() { 
  runApp(MyApp()); 
} 
  
class MyApp extends StatefulWidget { 
  @override 
  _MyAppState createState() => _MyAppState(); 
} 
  
class _MyAppState extends State<MyApp> { 

  void initState() { 
    super.initState(); 
    readData(); 
  } 
  
  bool isLoading = true; 
  List<String> list = []; 

  Future<void> readData() async {      
    var url = "https://common-firebase-default-rtdb.firebaseio.com/"+"data.json"; 
    try { 
      final response = await http.get(Uri.parse(url)); 
      final extractedData = json.decode(response.body) as Map<String, dynamic>; 
      if (extractedData == null) { 
        return; 
      } 
      extractedData.forEach((blogId, blogData) { 
        list.add(blogData["title"]); 
      }); 
      setState(() { 
        isLoading = false; 
      }); 
    } catch (error) { 
      throw error; 
    } 
  } 
  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List of Strings',
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of Strings'),
          backgroundColor: Colors.grey,
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  list[index],
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
