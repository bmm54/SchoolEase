import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:se2/ui/theme.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class Document {
  final String name;
  final String url;

  Document({required this.name, required this.url});
}

class Cour extends StatefulWidget {
  const Cour({Key? key}) : super(key: key);

  @override
  State<Cour> createState() => _CourState();
}

class _CourState extends State<Cour> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  List<Document> documents = [];
  // Add a function to fetch the documents' URLs from Firebase Storage
  Future<void> fetchDocuments() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('documents/cour/').listAll();
    final urls = await Future.wait(
        result.items.map((ref) => ref.getDownloadURL()).toList());
    final names = result.items.map((ref) => ref.name).toList();
    final docs = List.generate(result.items.length,
        (index) => Document(name: names[index], url: urls[index]));
    setState(() {
      documents = docs;
    });
  }

  Future<void> deleteFile(String fileName) async {
    final filePath = 'documents/cour/$fileName';
    final ref = FirebaseStorage.instance.ref().child(filePath);
    try {
      await ref.delete();
      print('File deleted successfully');
    } on FirebaseException catch (e) {
      print('Failed to delete file: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDocuments();
    Timer.periodic(Duration(seconds: 5), (timer) {
      _refreshDocuments();
    });
  }

  void _refreshDocuments() {
    // TODO: fetch updated documents from Firebase and update the documents list
    setState(() {});
  }

  Future selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    await uploadFile();
  }

  Future uploadFile() async {
    final path = 'documents/cour/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref(path);
    uploadTask = ref.putFile(file);
    await uploadTask!.whenComplete(() => {});
    final url = await ref.getDownloadURL();
    setState(() {
      documents.add(Document(name: pickedFile!.name, url: url));
    });
  }

  Future<void> downloadDocument(Document document) async {
    // write  the download from firebase code here
    final url = document.url;
    print(url);
    //final Uri uri = Uri(scheme: "https", host: url);
    //if (!await launchUrl(
    //  uri,
    //  mode: LaunchMode.externalApplication,
    //)) ;
  }

  final _isTeacher = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.85;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // add some top spacing
            _isTeacher
                ? DottedBorder(
                    dashPattern: const [4, 4], // Set dash pattern
                    strokeWidth: 5, // Set border width
                    color: Colors.black12, // Set border color
                    borderType: BorderType.RRect, // Set border type
                    radius: const Radius.circular(10),
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      width: screenWidth, // set the desired width
                      height: 90, // set the desired height
                      child: ElevatedButton(
                        onPressed: () {
                          selectFile();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black12,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // change the radius here
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_box_outlined,
                              size: 40,
                            ),
                            Text(
                              'Upload new document',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(height: 20), // add some spacing between the elements
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // handle document tap
                      await downloadDocument(documents[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.description,
                            color: mainColor,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              documents[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteFile(documents[index].name);
                              setState(() {
                                documents.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
