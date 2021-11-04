import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map myData = {};

  @override
  Widget build(BuildContext context) {
    myData = myData.isNotEmpty
        ? myData
        : ModalRoute.of(context)!.settings.arguments as Map;
    String bgImage = myData['isDayTime'] ? 'day.png' : 'night.png';
    // Color bgColor;
    // if (myData['isDayTime'])
    //   bgColor = Colors.blue;
    // else
    //   bgColor = Colors.indigo[700];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    myData = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'time': result['time'],
                      'isDayTime': result['isDayTime'],
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.white,
                ),
                label: Text(
                  'edit the location',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myData['location'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myData['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
