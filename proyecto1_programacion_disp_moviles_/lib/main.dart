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

// RECETAS
class Recetas 
{
  String nombre; 
  String descripcion; 
  String ingredientes; 
  String preparacion; 

  Recetas(
  {
    required this.nombre,
    required this.descripcion,
    required this.ingredientes,
    required this.preparacion,
  });
}

// LISTA RECETAS
final List<Recetas> recetas = [
  Recetas(
    nombre: 'Café Espresso',
    descripcion: 'Un café fuerte y puro.',
    ingredientes: '3 Tazas de café.\n1 Taza de agua.',
    preparacion: '1.- Preparar el café.\n2.- Servir en taza.',
  ),
  Recetas(
    nombre: 'Café Americano',
    descripcion: 'Un café suave con más agua.',
    ingredientes: '1.-120 ml de agua caliente.\n2.-60 ml de café espresso.',
    preparacion: '1.-Agregar agua caliente en una taza de 120 ml.\n2.-Posteriormente agregar el café espresso en otros 60 ml.',
  ),
  Recetas(
    nombre: 'Café con leche',
    descripcion: 'Un café suave con leche.',
    ingredientes: '1.-20 gramos café.\n2.-1 Litro Leche Semidescremada.\n3.-25gramos Azúcar.',
    preparacion: '1.-Prepara todos los ingredientes, una olla mediana, cucharas y las tazas para servir.\n2.-Coloca la Leche Semidescremada en una olla mediana y llévala a calentar por 3 minutos. Una vez caliente, añade el café y luego el azúcar. Remueve bien hasta disolver. Retira del fuego.\n3.-3.Coloca el café en tazas individuales y acompáñalo con tus opciones de desayuno preferidas.',
  ),
  Recetas(
    nombre: 'Capuccino',
    descripcion: 'Un café cremoso con leche espumosa.',
    ingredientes: '1 taza de café expreso negro azucarado a tu gusto (o café descafeinado si lo prefieres).\nCacao en polvo para decorar.\n1 taza de leche entera.',
    preparacion: '1.-Para empezar ponemos la leche en un bote con tapa o en un recipiente hermético. Tapamos bien y agitamos con fuerza durante 30 seg a un minuto hasta que la leche espume bastante y aumente mucho su tamaño.\n2.-Ese es el recurso rápido pero este proceso lo puedes hacer en una batidora durante 2 min y el resultado será aún más espumoso.\n3.-Inmediatamente ponemos la leche ya batida en el microondas unos 30 seg y así la espuma se compacta. Si has usado un hermético o un bote, úsalo para el microondas también.\n4.-Ponemos primero esta espuma espesa de leche en la taza de servicio y vamos vertiendo el café azucarado por un lateral con cuidado. De esta forma el café se va abajo y la espuma queda arriba. Decoramos espolvoreando con el cacao en polvo y servimos al momento, muy caliente.',
  ),
  Recetas(
    nombre:'Café Helado', 
    descripcion: 'Un café especial para los días calurosos.', 
    ingredientes: '3 Tazas de leche semidescremada bien fría.\n1 a 2 Cdas de café NESCAFÉ a elección.\n2 Cdtas de azúcar.\n2 Cdas de agua caliente para disolver el café.\n2 Bolas de helado sabor vainilla.\n1 Paquete de galletas a elección.\n Crema chantilly para decorar.', 
    preparacion: '1.- Café NESCAFÉ previamente diluido en el agua caliente junto a el azúcar\n1.- Juntar leche y café NESCAFÉ.\n3.- Procesa hasta tener una mezcla homogénea.\n4.- Deja reposar en el refrigerador por 1 hora aprox.\n5.- En un vaso largo, agregar 1 a 2 bolas de helado de   vainilla y vierte la leche con café.\n6.- Decorar con un copón generoso de crema chantilly y galletas ',
),
 
  
];

// Pantalla que muestra la lista de recetas
class RecetasListScreen extends StatelessWidget 
{
  final List<Recetas> recetas;
  final String searchQuery;

  const RecetasListScreen({
    super.key,
    required this.recetas,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) 
  {
    final filteredRecetas = recetas
        .where((receta) =>
            receta.nombre.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Recetas'),
      ),
      body: ListView.builder(
        itemCount: filteredRecetas.length,
        itemBuilder: (context, index) 
        {
          return ListTile(
            title: Text(filteredRecetas[index].nombre),
            subtitle: Text(filteredRecetas[index].descripcion),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () 
                  {
                    _editReceta(context, filteredRecetas[index]);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () 
                  {
                    _confirmDelete(context, index);
                  },
                ),
              ],
            ),
            onTap: () 
            {
              // Navega a la pantalla de detalles de la receta
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleRecetaScreen(receta: filteredRecetas[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _editReceta(BuildContext context, Recetas receta) 
  {
    final _nombreController = TextEditingController(text: receta.nombre);
    final _descripcionController = TextEditingController(text: receta.descripcion);
    final _ingredientesController = TextEditingController(text: receta.ingredientes);
    final _preparacionController = TextEditingController(text: receta.preparacion);

    showDialog(
      context: context,
      builder: (context) 
      {
        return AlertDialog(
          title: const Text('Editar Receta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre de la receta'),
              ),
              TextField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción de la receta'),
              ),
              TextField(
                controller: _ingredientesController,
                decoration: const InputDecoration(labelText: 'Ingredientes'),
              ),
              TextField(
                controller: _preparacionController,
                decoration: const InputDecoration(labelText: 'Preparación'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () 
              {
                // Se actualiza la receta
                receta.nombre = _nombreController.text;
                receta.descripcion = _descripcionController.text;
                receta.ingredientes = _ingredientesController.text;
                receta.preparacion = _preparacionController.text;

                Navigator.of(context).pop(); 
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () 
              {
                Navigator.of(context).pop(); // Se cierra el mensaje y no hace nada
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, int index) 
  {
    showDialog(
      context: context,
      builder: (context) 
      {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar esta receta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () 
              {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () 
              {
                recetas.removeAt(index); // Elimina la receta
                Navigator.of(context).pop(); 
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}

// Pantalla detalles de la receta
class DetalleRecetaScreen extends StatelessWidget 
{
  final Recetas receta;

  const DetalleRecetaScreen({super.key, required this.receta});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(receta.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Ingredientes:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),Text(receta.ingredientes),const SizedBox(height: 16),
            Text('Preparación:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),Text(receta.preparacion),
          ],
        ),
      ),
    );
  }
}

// SPLASHSCREEN
class SplashScreen extends StatefulWidget 
{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin 
    {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() 
  {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4), // Desaparece después de 4 segundos
      vsync: this,
    );

    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    _controller.forward().then((_) 
    {
      FlutterNativeSplash.remove(); // Saca la pantalla de splash
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const HomeScreen(title: 'MeSPRESSO - Tus Recetas de Café'),
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
  List<Recetas> _recetas = recetas; //Aqui se inicializa con las recetas que puse

  void _onItemTapped(int index) 
  {
    setState(() 
    {
      _selectedIndex = index;
    });

    if (index == 0) 
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecetasListScreen(recetas: _recetas, searchQuery: ''),
        ),
      );
    } else if (index == 1) 
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CrearRecetaScreen(
            onRecetaCreada: (nuevaReceta) 
            {
              setState(() 
              {
                _recetas.add(nuevaReceta); // Se agrega la receta creada a la lista
              });
            },
          ),
        ),
      );
    }
  }

  void _openSearch() 
  {
    showSearch(
      context: context,
      delegate: RecetaSearchDelegate(recetas: _recetas),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _openSearch,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png',height: 150,width: 150,),
            const SizedBox(height: 20), const Text('Bienvenido a MeSPRESSO',style: TextStyle(fontSize: 24),),
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
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 79, 51, 39),
        onTap: _onItemTapped,
      ),
    );
  }
}

class RecetaSearchDelegate extends SearchDelegate<Recetas> 
{
  final List<Recetas> recetas;

  RecetaSearchDelegate({required this.recetas});

  @override
  List<Widget> buildActions(BuildContext context) 
  {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () 
        {
          query = ''; // Limpia la búsqueda
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) 
  {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () 
      {
        close(context, Recetas(nombre: '', descripcion: '', ingredientes: '', preparacion: '')); // Cierra la búsqueda
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) 
  {
    final List<Recetas> resultados = recetas
        .where((receta) =>
            receta.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) 
      {
        return ListTile(
          title: Text(resultados[index].nombre),
          subtitle: Text(resultados[index].descripcion),
          onTap: () 
          {
            // va a la pantalla detalles de la receta
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetalleRecetaScreen(receta: resultados[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) 
  {
    final List<Recetas> sugerencias = recetas
        .where((receta) =>
            receta.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: sugerencias.length,
      itemBuilder: (context, index) 
      {
        return ListTile(
          title: Text(sugerencias[index].nombre),
          subtitle: Text(sugerencias[index].descripcion),
          onTap: () 
          {
            // va a la de detalles receta
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>DetalleRecetaScreen(receta: sugerencias[index]),),
            );
          },
        );
      },
    );
  }
}

// Pantalla crear nuevas recetas
class CrearRecetaScreen extends StatefulWidget 
{
  final Function(Recetas) onRecetaCreada;

  const CrearRecetaScreen({super.key, required this.onRecetaCreada});

  @override
  State<CrearRecetaScreen> createState() => _CrearRecetaScreenState();
}

class _CrearRecetaScreenState extends State<CrearRecetaScreen> 
{
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _preparacionController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre de la receta'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción de la receta'),
            ),
            TextField(
              controller: _ingredientesController,
              decoration: const InputDecoration(labelText: 'Ingredientes'),
            ),
            TextField(
              controller: _preparacionController,
              decoration: const InputDecoration(labelText: 'Preparación'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () 
              {
                // Crear nueva receta
                final nuevaReceta = Recetas(
                  nombre: _nombreController.text,
                  descripcion: _descripcionController.text,
                  ingredientes: _ingredientesController.text,
                  preparacion: _preparacionController.text,
                );

                // Aqui llama a la función que de la nueva receta
                widget.onRecetaCreada(nuevaReceta);

                // Regresar a la pantalla anterior
                Navigator.of(context).pop();
              },
              child: const Text('Guardar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
