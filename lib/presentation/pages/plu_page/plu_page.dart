import 'package:flutter/material.dart';

// The PLU entry screen for Amazon DashCart
class DashCartPLUScreen extends StatefulWidget {
  const DashCartPLUScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashCartPLUScreenState createState() => _DashCartPLUScreenState();
}

class _DashCartPLUScreenState extends State<DashCartPLUScreen> {
  // Variables to track input and display
  String _currentPLU = '';
  String _lastEnteredPLU = 'No PLU entered';
  // Removed _recentPLUs list since the feature is no longer needed

  // Method to show an enhanced SnackBar at the top of the screen
  void _showTopSnackBar(String message) {
    // Hide any existing SnackBars first
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Show the new SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Stack(children: [
                Image.network(
                    "https://cdn1.iconfinder.com/data/icons/fruit-cartoon-flat-cute-fruity/512/apple-1024.png",
                    width: 30,
                    height: 30),
                Container(
                    width: 35,
                    height: 35,
                    //color: Colors.red,
                    alignment: Alignment.bottomRight,
                    child:
                        Icon(Icons.check_circle, color: Colors.white, size: 18))
              ]),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Success',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      message,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF4CAF50), // Pleasant green color
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 120,
          right: 20,
          left: 20,
          top: 10,
        ), // Position at top with margins
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Smoother rounded corners
          side: BorderSide(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1), // Subtle border
        ),
        elevation: 10, // More pronounced shadow
        duration: Duration(seconds: 4), // Extended display time
        // Removed the invalid animation property: SnackBarAnimation.slideFromTop
      ),
    );
  }

  // Method to handle button presses
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear button functionality
        _currentPLU = '';
      } else if (buttonText == '⌫') {
        // Backspace button functionality
        if (_currentPLU.isNotEmpty) {
          _currentPLU = _currentPLU.substring(0, _currentPLU.length - 1);
        }
      } else if (buttonText == 'Enter') {
        // Enter button functionality
        if (_currentPLU.isNotEmpty) {
          _lastEnteredPLU = _currentPLU;

          // Removed the code that added to recent PLUs list

          // Show the enhanced top SnackBar
          _showTopSnackBar(
              'PLU Code $_currentPLU has been entered successfully');

          // Clear current input after submitting
          _currentPLU = '';
        }
      } else {
        // Number button functionality - limit to reasonable PLU length
        if (_currentPLU.length < 10) {
          _currentPLU += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Container(
      margin: EdgeInsets.all(8.0),
      // This outer decoration container handles the shadow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
                alpha: 0.2), // Fixed: withOpacity instead of withValues
            blurRadius: 8.0, // Increased blur for softer effect
            spreadRadius: 1.0, // Slightly increased spread
            offset: Offset(0, 3.0), // Mostly downward shadow
          ),
          // Adding a second, lighter shadow creates a more refined effect
          BoxShadow(
            color: Colors.black.withValues(
                alpha: 0.1), // Fixed: withOpacity instead of withValues
            blurRadius: 4.0,
            spreadRadius: 0.5,
            offset: Offset(0, 1.0),
          )
        ],
      ),
      child: Material(
        color: buttonColor, // Material takes the button color
        borderRadius: BorderRadius.circular(50), // Same radius as the container
        // Material is needed as a parent for InkWell to show its effect properly
        child: InkWell(
          borderRadius: BorderRadius.circular(50), // Match InkWell radius too
          onTap: () => _onButtonPressed(buttonText),
          // Adding this splashColor makes the tap effect more visible
          splashColor: textColor
              .withOpacity(0.3), // Fixed: withOpacity instead of withValues
          // Adding a highlight color enhances the pressed state
          highlightColor: textColor
              .withOpacity(0.1), // Fixed: withOpacity instead of withValues
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            // No decoration here to let the InkWell effect be visible
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashCart PLU Entry'),
        backgroundColor: Color.fromARGB(255, 255, 204, 196),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // PLU display
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            alignment: Alignment.center,
            color: Color.fromARGB(255, 248, 230, 226),
            child: Column(
              children: [
                Text(
                  'Enter Product PLU Code',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2),
                  ),
                  child: Text(
                    _currentPLU.isEmpty ? 'Ready for PLU entry' : _currentPLU,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color:
                          _currentPLU.isEmpty ? Colors.grey : Color(0xFF232F3E),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Last entered: $_lastEnteredPLU',
                  style: TextStyle(fontSize: 16, color: Color(0xFF232F3E)),
                ),
              ],
            ),
          ),

          // Removed the Recent PLUs section entirely

          // Keypad with improved button visibility
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[50],
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('7', Colors.white, Colors.black),
                        _buildButton('8', Colors.white, Colors.black),
                        _buildButton('9', Colors.white, Colors.black),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('4', Colors.white, Colors.black),
                        _buildButton('5', Colors.white, Colors.black),
                        _buildButton('6', Colors.white, Colors.black),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('1', Colors.white, Colors.black),
                        _buildButton('2', Colors.white, Colors.black),
                        _buildButton('3', Colors.white, Colors.black),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('C', Colors.red[400]!, Colors.white),
                        _buildButton('0', Colors.white, Colors.black),
                        _buildButton('⌫', Colors.orange[400]!, Colors.white),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF00A8E1).withOpacity(0.3),
                                  blurRadius: 8.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(0, 3.0),
                                )
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed('Enter'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF00A8E1),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation:
                                    0, // Remove default elevation since we're using custom shadow
                              ),
                              child: Text(
                                'Enter',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
