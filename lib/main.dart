import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationApp());
}

// =====================================================
// MAIN APP
// =====================================================

class AnimationApp extends StatelessWidget {
  const AnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Animation Demo',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}

// =====================================================
// HOME SCREEN
// =====================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Animations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // Header
              const Icon(
                Icons.animation,
                size: 90,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 15),

              const Text(
                'Animation Demo App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Explore three different Flutter animations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 30),

              // =========================================
              // SCREEN 1
              // =========================================

              animationMenuCard(
                context: context,

                icon: Icons.crop_square,

                title: 'AnimatedContainer',

                description:
                'Change size, color and border with animation.',

                color: Colors.blue,

                screen: const AnimatedContainerScreen(),
              ),

              const SizedBox(height: 15),

              // =========================================
              // SCREEN 2
              // =========================================

              animationMenuCard(
                context: context,

                icon: Icons.opacity,

                title: 'AnimatedOpacity',

                description:
                'Create smooth fade in and fade out effects.',

                color: Colors.green,

                screen: const AnimatedOpacityScreen(),
              ),

              const SizedBox(height: 15),

              // =========================================
              // SCREEN 3
              // =========================================

              animationMenuCard(
                context: context,

                icon: Icons.rotate_right,

                title: 'AnimationController',

                description:
                'Rotate a widget using AnimationController.',

                color: Colors.orange,

                screen: const AnimationControllerScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================================================
  // MENU CARD
  // ===================================================

  Widget animationMenuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required Widget screen,
  }) {
    return Card(
      elevation: 3,

      child: ListTile(
        contentPadding: const EdgeInsets.all(15),

        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(description),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
      ),
    );
  }
}

// =====================================================
// SCREEN 1
// ANIMATED CONTAINER
// =====================================================

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});

  @override
  State<AnimatedContainerScreen> createState() =>
      _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState
    extends State<AnimatedContainerScreen> {

  bool isChanged = false;

  void changeContainer() {
    setState(() {
      isChanged = !isChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                const Text(
                  'AnimatedContainer Demo',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Tap the button to change the '
                      'size, color and shape.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // =====================================
                // ANIMATED CONTAINER
                // =====================================

                AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 700),

                  curve: Curves.easeInOut,

                  width: isChanged ? 250 : 150,

                  height: isChanged ? 250 : 150,

                  decoration: BoxDecoration(
                    color: isChanged
                        ? Colors.deepPurple
                        : Colors.blue,

                    borderRadius: BorderRadius.circular(
                      isChanged ? 50 : 10,
                    ),

                    boxShadow: [
                      BoxShadow(
                        blurRadius: isChanged ? 20 : 5,

                        spreadRadius:
                        isChanged ? 5 : 1,

                        color: Colors.black26,
                      ),
                    ],
                  ),

                  child: const Center(
                    child: Icon(
                      Icons.animation,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: changeContainer,

                  icon: const Icon(
                    Icons.play_arrow,
                  ),

                  label: const Text(
                    'Animate',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// SCREEN 2
// ANIMATED OPACITY
// =====================================================

class AnimatedOpacityScreen extends StatefulWidget {
  const AnimatedOpacityScreen({super.key});

  @override
  State<AnimatedOpacityScreen> createState() =>
      _AnimatedOpacityScreenState();
}

class _AnimatedOpacityScreenState
    extends State<AnimatedOpacityScreen> {

  bool isVisible = true;

  void changeOpacity() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('AnimatedOpacity'),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                const Text(
                  'AnimatedOpacity Demo',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Tap the button to fade the widget '
                      'in and out.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // =====================================
                // ANIMATED OPACITY
                // =====================================

                AnimatedOpacity(
                  duration:
                  const Duration(milliseconds: 700),

                  curve: Curves.easeInOut,

                  opacity: isVisible ? 1.0 : 0.0,

                  child: Container(
                    width: 220,
                    height: 220,

                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                      BorderRadius.circular(25),
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.favorite,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: changeOpacity,

                  icon: const Icon(
                    Icons.visibility,
                  ),

                  label: Text(
                    isVisible
                        ? 'Hide'
                        : 'Show',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// SCREEN 3
// ANIMATION CONTROLLER
// =====================================================

class AnimationControllerScreen
    extends StatefulWidget {

  const AnimationControllerScreen({
    super.key,
  });

  @override
  State<AnimationControllerScreen> createState() =>
      _AnimationControllerScreenState();
}

class _AnimationControllerScreenState
    extends State<AnimationControllerScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> rotation;

  @override
  void initState() {
    super.initState();

    // ================================================
    // ANIMATION CONTROLLER
    // ================================================

    controller = AnimationController(
      vsync: this,

      duration:
      const Duration(seconds: 2),
    );

    rotation = Tween<double>(
      begin: 0,

      end: 2 * 3.14159265359,
    ).animate(controller);
  }

  // ================================================
  // START ANIMATION
  // ================================================

  void startAnimation() {
    controller.forward(from: 0);
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'AnimationController',
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                const Text(
                  'AnimationController Demo',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Tap the button to rotate the widget.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50),

                // =====================================
                // ROTATING WIDGET
                // =====================================

                AnimatedBuilder(
                  animation: controller,

                  builder: (
                      context,
                      child,
                      ) {

                    return Transform.rotate(
                      angle: rotation.value,

                      child: child,
                    );
                  },

                  child: Container(
                    width: 200,
                    height: 200,

                    decoration: BoxDecoration(
                      color: Colors.orange,

                      borderRadius:
                      BorderRadius.circular(25),
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.star,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                ElevatedButton.icon(
                  onPressed: startAnimation,

                  icon: const Icon(
                    Icons.rotate_right,
                  ),

                  label: const Text(
                    'Rotate',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}