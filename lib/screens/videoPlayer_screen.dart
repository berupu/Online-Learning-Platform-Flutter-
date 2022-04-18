import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayer extends StatelessWidget {
  Widget cardsBuilder(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.all(20.0),
            child: WebView(
                initialUrl: 'https://www.youtube.com/watch?v=fv0KngNVyEU',
                javascriptMode: JavascriptMode.unrestricted),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course content',
      theme: ThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primarySwatch: Colors.lime),
      home: Scaffold(
        appBar: AppBar(title: Text('Course content')),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
                child:
                    ListView.builder(itemBuilder: cardsBuilder, itemCount: 1))
          ],
        ),
      ),
    );
  }
}
