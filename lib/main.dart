import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(ParkingApp());
}

class ParkingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStartedPage(),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Parking App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Get Started',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: () {
                // Navigate to GPS page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GPSPickerPage()),
                );
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class GPSPickerPage extends StatelessWidget {
  Future<void> _getLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // استخدم position للوصول إلى معلومات الموقع
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Nearest Parking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'GPS Picker Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                _getLocation(context);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add payment method selection functionality here
            const Text(
              'Payment Method Page',
              style: TextStyle(fontSize: 24),
            ),
            // Add payment method options here
            ElevatedButton(
              onPressed: () {
                // Navigate to home page after payment
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Parking App',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement parking reservation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReserveParkingPage()),
                );
              },
              child: Text('Reserve Parking'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement service request logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestServicePage()),
                );
              },
              child: Text('Request Service'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReserveParkingPage extends StatelessWidget {
  final List<int> reservedSlots = [2, 4, 6]; // Mocking reserved slots

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Parking'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10, // Assuming there are 10 slots
          itemBuilder: (BuildContext context, int index) {
            final slotNumber = index + 1;
            final isReserved = reservedSlots.contains(slotNumber);

            return ListTile(
              title: Text('Slot $slotNumber'),
              subtitle: isReserved ? Text('Reserved') : Text('Available'),
              trailing: isReserved
                  ? null
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmReservationPage()),
                        );
                        // Implement reservation logic here
                        // You can navigate to a confirmation page or perform any necessary actions
                      },
                      child: Text('Reserve'),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class ConfirmReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Parking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select a timeslot:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement reservation logic here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Reservation'),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selected Timeslot:'),
                          Text('Date: ...'), // Display selected date
                          Text('Time: ...'), // Display selected time
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Implement reservation confirmation logic here
                            Navigator.of(context).pop();
                            // Add further actions after reservation confirmation
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Reserve'),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Implement service request logic for charging here
                _showServiceRequestConfirmation(context);
              },
              child: Text('Charge Car'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement service request logic for car wash here
                _showServiceRequestConfirmation(context);
              },
              child: Text('Car Wash'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement service request logic for maintenance here
                _showServiceRequestConfirmation(context);
              },
              child: Text('Car Maintenance'),
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceRequestConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Service Requested"),
          content:
              Text("Your service request has been submitted successfully."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
