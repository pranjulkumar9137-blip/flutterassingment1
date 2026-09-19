import 'package:flutter/material.dart';

void main() {
  runApp(const HelpApp());
}

class HelpApp extends StatelessWidget {
  const HelpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Help & Instructions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ----------------------------------------------------
// HOME SCREEN
// ----------------------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Instructions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.help_outline,
                  size: 60,
                  color: Colors.blue,
                ),

                SizedBox(height: 10),

                Text(
                  'How can we help you?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Select a topic to view detailed instructions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Help Topics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // ------------------------------------------------
          // TOPIC 1
          // ------------------------------------------------

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.phone_android),
              ),

              title: const Text(
                'How to use the App?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: const Text(
                'Basic instructions for using the application.',
              ),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppUsageScreen(),
                  ),
                );
              },
            ),
          ),

          // ------------------------------------------------
          // TOPIC 2
          // ------------------------------------------------

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.account_circle),
              ),

              title: const Text(
                'Account Help',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: const Text(
                'Instructions related to your account.',
              ),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountHelpScreen(),
                  ),
                );
              },
            ),
          ),

          // ------------------------------------------------
          // TOPIC 3
          // ------------------------------------------------

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.settings),
              ),

              title: const Text(
                'Settings Help',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: const Text(
                'Learn how to change application settings.',
              ),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsHelpScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // ------------------------------------------------
          // EXPANSION TILE
          // ------------------------------------------------

          const Text(
            'Quick Instructions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: ExpansionTile(
              leading: const Icon(
                Icons.login,
                color: Colors.blue,
              ),

              title: const Text(
                'How to Login?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        'Follow these steps:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        '1. Open the application.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '2. Enter your registered email address.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '3. Enter your password.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '4. Press the Login button.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '5. You will be redirected to the home screen.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              leading: const Icon(
                Icons.lock_reset,
                color: Colors.orange,
              ),

              title: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        'To reset your password:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        '1. Go to the Login page.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '2. Click on "Forgot Password".',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '3. Enter your registered email.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '4. Check your email for the reset link.',
                      ),

                      SizedBox(height: 5),

                      Text(
                        '5. Create a new password.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              leading: const Icon(
                Icons.contact_support,
                color: Colors.green,
              ),

              title: const Text(
                'Need More Help?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Text(
                    'If you still need help, please contact '
                        'the support team for further assistance.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// APP USAGE SCREEN
// ----------------------------------------------------

class AppUsageScreen extends StatelessWidget {
  const AppUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Use App'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: const [

          Icon(
            Icons.phone_android,
            size: 70,
            color: Colors.blue,
          ),

          SizedBox(height: 20),

          Text(
            'Basic App Instructions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 25),

          Text(
            'Step 1',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Open the application from your mobile device.',
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 20),

          Text(
            'Step 2',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Choose the required option from the home screen.',
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 20),

          Text(
            'Step 3',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Read the instructions carefully and follow each step.',
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 20),

          Text(
            'Step 4',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Use the back button to return to the previous screen.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// ACCOUNT HELP SCREEN
// ----------------------------------------------------

class AccountHelpScreen extends StatelessWidget {
  const AccountHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Help'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Icon(
            Icons.account_circle,
            size: 80,
            color: Colors.blue,
          ),

          const SizedBox(height: 20),

          const Text(
            'Account Instructions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ExpansionTile(
              title: const Text(
                'Create an Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Text(
                    '1. Open the registration page.\n\n'
                        '2. Enter your name.\n\n'
                        '3. Enter your email address.\n\n'
                        '4. Create a secure password.\n\n'
                        '5. Click the Register button.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              title: const Text(
                'Update Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Text(
                    '1. Open your profile.\n\n'
                        '2. Select Edit Profile.\n\n'
                        '3. Change the required information.\n\n'
                        '4. Press Save.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// SETTINGS HELP SCREEN
// ----------------------------------------------------

class SettingsHelpScreen extends StatelessWidget {
  const SettingsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Help'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Icon(
            Icons.settings,
            size: 80,
            color: Colors.blue,
          ),

          const SizedBox(height: 20),

          const Text(
            'Settings Instructions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ExpansionTile(
              leading: const Icon(Icons.notifications),

              title: const Text(
                'Notification Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Text(
                    'You can enable or disable notifications '
                        'from the notification settings.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              leading: const Icon(Icons.language),

              title: const Text(
                'Language Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Text(
                    'Select your preferred language from '
                        'the available language options.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              leading: const Icon(Icons.dark_mode),

              title: const Text(
                'Theme Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              children: const [

                Padding(
                  padding: EdgeInsets.all(16),

                  child: Text(
                    'Choose between light mode and dark mode '
                        'according to your preference.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}