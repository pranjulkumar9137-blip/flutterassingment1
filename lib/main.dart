import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: const ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    // ------------------------------------------------
    // 1. MEDIA QUERY
    // ------------------------------------------------

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Responsive Flutter App",
        ),
      ),

      // ------------------------------------------------
      // 2. LAYOUT BUILDER
      // ------------------------------------------------

      body: LayoutBuilder(
        builder: (context, constraints) {

          final width = constraints.maxWidth;

          // Mobile
          if (width < 600) {
            return mobileLayout(
              screenWidth,
              screenHeight,
              orientation,
            );
          }

          // Tablet
          else if (width < 1000) {
            return tabletLayout(
              screenWidth,
              screenHeight,
              orientation,
            );
          }

          // Large Screen
          else {
            return desktopLayout(
              screenWidth,
              screenHeight,
              orientation,
            );
          }
        },
      ),
    );
  }

  // ==================================================
  // MOBILE LAYOUT
  // ==================================================

  Widget mobileLayout(
      double width,
      double height,
      Orientation orientation,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const Icon(
              Icons.phone_android,
              size: 80,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 20),

            const Text(
              "Mobile Layout",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Screen Width: ${width.toStringAsFixed(0)}",
            ),

            Text(
              "Screen Height: ${height.toStringAsFixed(0)}",
            ),

            Text(
              "Orientation: ${orientation == Orientation.portrait ? "Portrait" : "Landscape"}",
            ),

            const SizedBox(height: 30),

            buildCard(
              Icons.person,
              "Profile",
            ),

            buildCard(
              Icons.settings,
              "Settings",
            ),

            buildCard(
              Icons.notifications,
              "Notifications",
            ),

            buildCard(
              Icons.logout,
              "Logout",
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // TABLET LAYOUT
  // ==================================================

  Widget tabletLayout(
      double width,
      double height,
      Orientation orientation,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          children: [

            const Icon(
              Icons.tablet_android,
              size: 100,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              "Tablet Layout",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Screen Width: ${width.toStringAsFixed(0)}",
            ),

            Text(
              "Screen Height: ${height.toStringAsFixed(0)}",
            ),

            Text(
              "Orientation: ${orientation == Orientation.portrait ? "Portrait" : "Landscape"}",
            ),

            const SizedBox(height: 30),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 20,
              mainAxisSpacing: 20,

              children: [

                buildCard(
                  Icons.person,
                  "Profile",
                ),

                buildCard(
                  Icons.settings,
                  "Settings",
                ),

                buildCard(
                  Icons.notifications,
                  "Notifications",
                ),

                buildCard(
                  Icons.logout,
                  "Logout",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // LARGE SCREEN / DESKTOP LAYOUT
  // ==================================================

  Widget desktopLayout(
      double width,
      double height,
      Orientation orientation,
      ) {
    return Padding(
      padding: const EdgeInsets.all(40),

      child: Row(
        children: [

          // --------------------------------------------
          // LEFT SIDE
          // --------------------------------------------

          Expanded(
            flex: 1,

            child: Container(
              padding: const EdgeInsets.all(30),

              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  const Icon(
                    Icons.desktop_windows,
                    size: 120,
                    color: Colors.deepPurple,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Large Screen",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Width: ${width.toStringAsFixed(0)}",
                  ),

                  Text(
                    "Height: ${height.toStringAsFixed(0)}",
                  ),

                  Text(
                    "Orientation: ${orientation == Orientation.portrait ? "Portrait" : "Landscape"}",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 30),

          // --------------------------------------------
          // RIGHT SIDE
          // --------------------------------------------

          Expanded(
            flex: 2,

            child: GridView.count(
              crossAxisCount: 2,

              crossAxisSpacing: 20,
              mainAxisSpacing: 20,

              children: [

                buildCard(
                  Icons.person,
                  "Profile",
                ),

                buildCard(
                  Icons.settings,
                  "Settings",
                ),

                buildCard(
                  Icons.notifications,
                  "Notifications",
                ),

                buildCard(
                  Icons.logout,
                  "Logout",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================
  // COMMON CARD
  // ==================================================

  Widget buildCard(
      IconData icon,
      String title,
      ) {
    return Card(
      elevation: 5,

      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 50,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}