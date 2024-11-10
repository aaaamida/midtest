import 'package:flutter/material.dart';

void main() {
        runApp(const MyApp());
}

class MyApp extends StatelessWidget {
        const MyApp({super.key});

        @override
        Widget build(BuildContext context) {
                return MaterialApp(
                        title: 'Flutter Demo',
                        theme: ThemeData(
                                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                                useMaterial3: true,
                        ),
                        home: const MyHomePage(title: 'OpenDownloadManager'),
                        debugShowCheckedModeBanner: false,
                );
        }
}

class MyHomePage extends StatefulWidget {
        const MyHomePage({super.key, required this.title});
        final String title;

        @override
        State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
        int selectedItem = 0;
        static var div = const Divider(
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFF000000)
        );

        void _onSelect(int index) {
                setState(() {
                        selectedItem = index;
                });
        }

        void inputPopup(BuildContext context) {
                TextEditingController linkCtl = TextEditingController();

                showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(

                                title: const Text("Foo", style: TextStyle(color: Color(0xFFFFFFFF))),
                                content: SizedBox(
                                        width: MediaQuery.of(context).size.width / 3,
                                        child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                        TextField(
                                                                controller: linkCtl,
                                                                decoration: const InputDecoration(hintText: "Type here"),
                                                        )
                                                ],
                                        ),
                                ),
                                actions: [
                                        const TextButton(onPressed: null, child: Text("Submit")),
                                        const SizedBox(width: 15),
                                        TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: const Text("Cancel")
                                        ),
                                ],
                        )
                );
        }

        @override
        Widget build(BuildContext context) {
                return Scaffold(
                        appBar: AppBar(
                                title: Text(widget.title),
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor: const Color(0xFF634F88),
                        ),
                        // ignore: prefer_const_constructors
                        body: Center(
                                child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                                const SizedBox(height: 20),
                                                const DownloadsListItems(title: "Foo"),
                                                div,
                                                const DownloadsListItems(title: "Bar"),
                                                div,
                                                const DownloadsListItems(title: "Baz"),
                                                div
                                        ],
                                ),
                        ),
                        bottomNavigationBar: BottomAppBar(
                                color: const Color(0xFF473763),
                                child: Padding(
                                        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                                        child: Row(
                                                children: [
                                                        _navIcon(Icons.add, 0, "Add new download(s)"),
                                                        const SizedBox(width: 30),
                                                        _navIcon(Icons.list_outlined, 1, "See list of currently ongoing downloads"),
                                                        const SizedBox(width: 30),
                                                        _navIcon(Icons.library_add_check_outlined, 2, "See all finished downloads"),
                                                ],
                                        ),
                                ),
                        ),
                        floatingActionButton: FloatingActionButton(
                                onPressed: () => inputPopup(context),
                                backgroundColor: const Color(0xFF8B6EBF),
                                hoverColor: const Color(0xFFB993FF),
                                tooltip: "Add new...",
                                child: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
                        ),
                );
        }
        
        Widget _navIcon(IconData icon, int index, String? tooltip) {
                bool selected = selectedItem == index;

                return GestureDetector(
                        onTap: () => _onSelect(index),
                        child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                        if (selected) Container(
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                        color: const Color(0xFFFFFFFF),
                                                        borderRadius: BorderRadius.circular(2)
                                                ),
                                        ),
                                        Icon(
                                                icon, 
                                                color: 
                                                        selected 
                                                        ? const Color(0xFFFFFFFF)
                                                        : const Color(0xFFB2B2B2),
                                                size: 25,
                                        ), 
                                        Tooltip(message: tooltip)
                                ],
                        ),
                );
        }
}

class DownloadsListItems extends StatelessWidget {
        const DownloadsListItems({super.key, required this.title});
        final String title;

        @override
        Widget build(BuildContext context) {
                return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                        const SizedBox(height: 10),
                                        Text(title, style: const TextStyle(fontSize: 16)),
                                        const SizedBox(height: 10),
                                ],
                        ),
                );
        }
}
