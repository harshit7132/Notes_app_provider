import 'package:flutter/material.dart';
import 'package:notes_app_provider_new/Add%20note%20page.dart';
import 'package:notes_app_provider_new/Provider/Note%20Provider.dart';
import 'package:provider/provider.dart';
import 'Database/Note Model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => NoteProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<noteModel> arrNotes = [];

  getInitialNotes() {
    context.read<NoteProvider>().fetchInitialNotes();
  }

  deleteNotes(int note_id) {
    context
        .read<NoteProvider>()
        .deleteNotes(note_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NoteProvider>(
          builder: (_, provider, __) {
            return ListView.builder(
                itemCount: provider.getNotes().length,
                itemBuilder: (_, index) {
                  var currentData = provider.getNotes()[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: double.infinity,
                    color: Colors.green
                    //.primaries[Random().nextInt(Colors.primaries.length)]
                        ,
                    child: InkWell(
                      onTap: () {
                        //updating notes
                        titleController.text = currentData.title!;
                        descController.text = currentData.desc!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => add_Notes_page(
                                    isupDate: true,
                                    note_id: currentData.note_id,
                                    title: currentData.title,
                                    desc: currentData.desc)));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(currentData.note_id.toString()),
                        ),
                        title: Text(currentData.title.toString()),
                        subtitle: Text(currentData.desc.toString()),
                        trailing: IconButton(
                            onPressed: ()  {
                              deleteNotes(currentData.note_id as int);
                             print(currentData);
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => add_Notes_page(isupDate: false)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
