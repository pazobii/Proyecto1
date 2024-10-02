import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() 
{
  runApp(const MeSPRESSOApp());
}

class MeSPRESSOApp extends StatelessWidget 
{
  const MeSPRESSOApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'MeSPRESSO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget 
{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin 
{
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() 
  {
    super.initState();

    // Controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animación de opacidad
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Iniciar la animación
    _controller.forward().then((_) 
    {
      FlutterNativeSplash.remove(); // Remueve la pantalla de splash
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(title: 'MeSPRESSO - Tus Recetas de Café'),
        ),
      );
    });
  }

  @override
  void dispose() 
  {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 243),
      body: FadeTransition(
        opacity: _opacity,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 800,
            width: 800,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget 
{
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
{
  int _selectedIndex = 0;

  // Navegación de las pantallas del BottomNavigationBar
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Lista de Recetas'),
    Text('Favoritos'),
    Text('Perfil'),
  ];

  void _onItemTapped(int index) 
  {
    setState(() 
    {
      _selectedIndex = index;
    });
  }

  void _onSearchPressed() {
    // Tengo que ver como hacer una lógica para la búsqueda
    print("Buscar recetas de café");
    // Por ejemplo, puedes navegar a una nueva pantalla de búsqueda:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search), // Icono de lupa
            onPressed: _onSearchPressed, // Función al presionar el botón
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // IMAGEN
            Image.asset(
              'assets/images/logo.png',
              height: 150, //altura
              width: 150, //ancho
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y el texto
            const Text(
              'Bienvenido a MeSPRESSO',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Recetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 79, 51, 39),
        onTap: _onItemTapped,
      ),
    );
  }
}
