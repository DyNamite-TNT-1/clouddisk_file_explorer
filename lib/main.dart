import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController domainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.lightBlue),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 86, 32, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'HANBIRO',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Cloud Disk',
                  style: TextStyle(
                    fontSize: 48,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    border: Border(
                      bottom: BorderSide(width: 1.6),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.language,
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: TextFormField(
                            controller: domainController,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              labelText: "Domain",

                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: const EdgeInsets.only(top: -14),
                              // prefixIcon: const Icon(
                              //   Icons.language,
                              //   size: 16,
                              //   color: Colors.black45,
                              // ),
                              // enabledBorder: UnderlineInputBorder(
                              //   borderRadius: BorderRadius.circular(4),
                              //   borderSide: const BorderSide(
                              //     // color: inputBackgroundColor,
                              //     width: 1.6,
                              //   ),
                              // ),
                              // focusedBorder: UnderlineInputBorder(
                              //   borderRadius: BorderRadius.circular(4),
                              //   borderSide: const BorderSide(
                              //     // color: themeColor,
                              //     width: 1.6,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
