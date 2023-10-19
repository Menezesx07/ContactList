import 'package:contactlist/components/cards.dart';
import 'package:contactlist/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

/*  //função que vai ser chamada ao carregar a tela
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<HomeController>(context, listen: false).getData();
  }*/


  @override
  void initState() {
    super.initState();
  }

  bool isDark = true;

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Consumer<HomeController>(builder: (context, value, child) => Scaffold(

        appBar: AppBar(title: const Text("Home")),

       body: Column(
         children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                 builder: (BuildContext context, SearchController controller) {
                   return SearchBar(
                     controller: controller,
                     padding: const MaterialStatePropertyAll<EdgeInsets>(
                         EdgeInsets.symmetric(horizontal: 16.0)),
                     onTap: () {
                       controller.openView();
                     },
                     onChanged: (_) {
                       controller.openView();
                     },
                     leading: const Icon(Icons.search),
                     trailing: <Widget>[
                       Tooltip(
                         message: 'Change brightness mode',
                         child: IconButton(
                           isSelected: isDark,
                           onPressed: () {
                             setState(() {
                               isDark = !isDark;
                             });
                           },
                           icon: const Icon(Icons.wb_sunny_outlined),
                           selectedIcon: const Icon(Icons.brightness_2_outlined),
                         ),
                       )
                     ],
                   );
                 }, suggestionsBuilder:
                 (BuildContext context, SearchController controller) {
               return List<ListTile>.generate(5, (int index) {
                 final String item = 'item $index';
                 return ListTile(
                   title: Text(item),
                   onTap: () {
                     setState(() {
                       controller.closeView(item);
                     });
                   },
                 );
               });
           }),
            ),

           Padding(
                padding: const EdgeInsets.only(top: 30),
                child: value.contactList.results.isEmpty
                    ?  const Center(child: Text("Comece Adicionando \nitens a Lista", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, ),))
                    :  ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.contactList.results.length,
                    itemBuilder: (context, index) {

                      return cardHome(contactItem: value.contactList.results[index]);

                    }
                )
            ),
         ],
       ),

        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
        }),

        )
      ),
    );
  }
}
