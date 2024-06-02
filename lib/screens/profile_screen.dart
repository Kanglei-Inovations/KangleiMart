import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final user = authData.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user?.photoURL ?? 'https://example.com/default-avatar.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Name: ${user?.displayName}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${user?.email ?? 'Unknown'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/edit-profile');
              },
              child: Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                authData.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
