import 'package:flutter/material.dart';
import 'recommendation_service.dart'; // Import the new Dart file

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> _recommendations = [];

  @override
  void initState() {
    super.initState();
    _fetchRecommendations('gofor.jpeg'); // Replace with actual item ID
  }

  Future<void> _fetchRecommendations(String itemId) async {
    try {
      List<String> recommendations = await fetchRecommendations(itemId);
      setState(() {
        _recommendations = recommendations;
      });
    } catch (e) {
      print('Failed to load recommendations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: _buildDropdownButton(context),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            _buildSearchBar(),
            SizedBox(height: 20.0),
            _buildButtonRow(),
            SizedBox(height: 20.0),
            _buildImageCarousel(),
            SizedBox(height: 20.0),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 238, 230, 219),
        border:
            Border.all(color: Color.fromARGB(255, 235, 204, 171), width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Myntra',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          SizedBox(width: 8.0),
          Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Icon(Icons.camera_alt),
          SizedBox(width: 10.0),
          Icon(Icons.mic),
        ],
      ),
    );
  }

  Widget _buildButtonRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSquareButton('Men', 'assets/images/men.webp'),
          SizedBox(width: 10.0),
          _buildSquareButton('Women', 'assets/images/women.jpg'),
          SizedBox(width: 10.0),
          _buildSquareButton('Kids', 'assets/images/both.webp'),
          SizedBox(width: 10.0),
          _buildSquareButton('Footwear', 'assets/images/heels.jpg'),
          SizedBox(width: 10.0),
          _buildSquareButton('Accessories', 'assets/images/purse.webp'),
          SizedBox(width: 10.0),
          _buildSquareButton('Watches', 'assets/images/watch.jpg'),
          SizedBox(width: 10.0),
          _buildSquareButton('Luggage', 'assets/images/trolly.jpg'),
          SizedBox(width: 10.0),
          _buildSquareButton('Jewellery', 'assets/images/jewel.webp'),
        ],
      ),
    );
  }

  Widget _buildSquareButton(String text, String imagePath) {
    return Column(
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        Text(text, style: TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildImageCarousel() {
    return Container(
      height: 200.0,
      child: PageView.builder(
        itemCount: _recommendations.length,
        itemBuilder: (context, index) {
          return Image.asset(
            _recommendations[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildRecommendations() {
    return Expanded(
      child: ListView.builder(
        itemCount: _recommendations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_recommendations[index]),
          );
        },
      ),
    );
  }
}
