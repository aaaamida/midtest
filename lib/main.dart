import 'package:flutter/material.dart';

void main() {
        runApp(const MyApp());
}

// class container seluruh aplikasi
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

// class container home page 
class MyHomePage extends StatefulWidget {
        const MyHomePage({super.key, required this.title});
        final String title;

        @override
        State<MyHomePage> createState() => _MyHomePageState();
}

// class builder untuk container homepage
class _MyHomePageState extends State<MyHomePage> {
        int selectedItem = 0;

        // class div untuk memisahkan tiap item dengan garis horizontal
        static var div = const Divider(
                thickness: 0.1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFF000000)
        );

        // method untuk mengubah state item setelah dipilih
        void _onSelect(int index) {
                setState(() {
                        selectedItem = index;
                });
        }

        // method memunculkan AlertDialog yang berisi TextField
        void inputPopup(BuildContext context) {
                TextEditingController linkCtl = TextEditingController();

                showDialog(
                        context: context,
                        // arrow function yang memanggil AlertDialog
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text("Foo", style: TextStyle(color: Color(0x00000000))),
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
                                // pilihan dalam AlertDialog saat dimunculkan
                                actions: [
                                        const TextButton(onPressed: null, child: Text("Submit")),
                                        const SizedBox(width: 15),
                                        TextButton(
                                                // tutup AlertDialog saat ditekan
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: const Text("Cancel")
                                        ),
                                ],
                        )
                );
        }

        // method untuk mengubah state dari icon di navigation bar
        Widget _navIcon(IconData icon, int index) {
                bool selected = selectedItem == index;

                return GestureDetector(
                        // panggil method untuk mengubah index
                        onTap: () => _onSelect(index),
                        // container column untuk indikator icon terpilih
                        child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                        // jika terpilih munculkan indikator 
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
                                                // jika terpilih ubah warna icon menjadi putih
                                                        selected 
                                                        ? const Color(0xFFFFFFFF)
                                                        : const Color(0xFFB2B2B2),
                                                size: 25,
                                        ), 
                                ],
                        ),
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
                        // container center 
                        body: Center(
                                child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(children: [
                                                const DownloadsListItems(title: "foo.exe", path: "/home/user/Downloads/ODM/foo.exe"),
                                                div,
                                                const DownloadsListItems(title: "bar.sh", path: "/home/user/Downloads/ODM/bar.sh"),
                                                div,
                                                const DownloadsListItems(title: "baz.tar.xz", path: "/home/user/Downloads/baz.tar.xz"),
                                                div
                                                ]
                                        ),
                                ),
                        ),
                        bottomNavigationBar: BottomAppBar(
                                color: const Color(0xFF473763),
                                child: Padding(
                                        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                                        child: Row(
                                                children: [
                                                        _navIcon(Icons.add, 0),
                                                        const SizedBox(width: 30),
                                                        _navIcon(Icons.list_outlined, 1),
                                                        const SizedBox(width: 30),
                                                        _navIcon(Icons.library_add_check_outlined, 2),
                                                ],
                                        ),
                                ),
                        ),
                        floatingActionButton: FloatingActionButton(
                                // panggil method inputPopup saat tombol ditekan
                                onPressed: () => inputPopup(context),
                                backgroundColor: const Color(0xFF8B6EBF),
                                hoverColor: const Color(0xFFB993FF),
                                tooltip: "Add new...",
                                // icon didalam tombol
                                child: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
                        ),
                );
        }
}

class DownloadsListItems extends StatelessWidget {
        // class constructor dengan dua property yaitu nama file dan lokasi file
        const DownloadsListItems({super.key, required this.title, required this.path});
        final String title;
        final String path;

        @override
        Widget build(BuildContext context) {
                return Padding(
                        padding: const EdgeInsets.all(16),
                        // container row arah menyamping
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // isi dari container row
                                children: [
                                        const SizedBox(height: 10),
                                        Text(title, style: const TextStyle(fontSize: 16)),
                                        // container expanded yang ukurannya dapat berubah sesuai ukuran layar
                                        const Expanded(flex: 10, child: SizedBox(height: 10)),
                                        Text(path, style: const TextStyle(fontSize: 12)),
                                        // container expanded yang berisi tombol berisi icon
                                        Expanded(flex: 2, child: IconButton(onPressed: null, icon: _navIcon(Icons.more_vert_rounded)))
                                ],
                        ),
                );
        }

        Widget _navIcon(IconData icon) {
                return GestureDetector(
                        onTap: null,
                        child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                        Icon(
                                                icon, 
                                                color: const Color(0xFF000000),
                                                size: 25,
                                        ), 
                                ],
                        ),
                );
        }
}
