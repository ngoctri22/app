import 'package:flutter/material.dart';
import 'package:untitled/Controller.dart';
import 'package:untitled/global.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  init();
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List itemList=[
      {
        'date':'20/11/2022',
        'content':'The Flutter framework has been optimized to make rerunning build methods fast, so that you can just rebuild anything that needs updating ratherthan having to individually change instances of widgets.',
        'time':'09:00',
      },
      {
        'date':'22/11/2022',
        'content':'The Flutter framework has been optimized to make rerunning build methods fast, so that you can just rebuild anything that needs updating ratherthan having to individually change instances of widgets.',
        'time':'09:00',
      }
      ,
      {
        'date':'01/11/2022',
        'content':'The Flutter framework has been optimized to make rerunning build methods fast, so that you can just rebuild anything that needs updating ratherthan having to individually change instances of widgets.',
        'time':'09:00',
      },
      {
        'date':'02/11/2022',
        'content':'The Flutter framework has been optimized to make rerunning build methods fast, so that you can just rebuild anything that needs updating ratherthan having to individually change instances of widgets.',
        'time':'09:00',
      }
      ,
      {
        'date':'24/11/2022',
        'content':'The Flutter framework has been optimized to make rerunning build methods fast, so that you can just rebuild anything that needs updating ratherthan having to individually change instances of widgets.',
        'time':'09:00',
      }
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Obx(()=>ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              if (controller.listItem.isNotEmpty)...controller.listItem.map<Widget>((element) {
                return InkWell(
                      onTap: (){
                        element['active']=element['active']==1?0:1;
                        controller.update();
                      },
                      child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      child: Text(element['name'], style:  TextStyle(
                        color: Colors.green,
                        decoration:element['active']==0?null: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),)
                  ),
                );
              }).toList(),
              TextFormField(
                initialValue: controller.address.value??'',
                onChanged: (val){
                  controller.address.value=val;
                },
              ),
              FloatingActionButton(
                onPressed: (){
                  if(controller.address.value != ''){
                    final bool res = check(controller.listItem, controller.address.value) ?? true;
                    if(!res){
                      Get.showSnackbar(const GetSnackBar(message: 'Lỗi',));
                    }else{
                      controller.listItem.add({
                        'date':'22/11/2022',
                        'name':controller.address.value.trim(),'time':'12:12','active':0
                      });
                    }
                  }else{
                    // Get.snackbar('Thông báo','Đã xảy ra lỗi');
                    Get.snackbar('Thông báo','Đã xảy ra lỗi');
                  }
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ), //
              if(controller.listItem.isNotEmpty)...makeTreeItems(controller.listItem, 2).map<Widget>((e){
                return Row(
                  children: e.map<Widget>((item){
                    return Container(
                      width: (Get.width-40)/2,
                    margin: const EdgeInsets.all(5),
                    color: Colors.amberAccent,
                    child: Column(
                      crossAxisAlignment : CrossAxisAlignment.start,
                      children: [
                        Text( item['date']),
                        const SizedBox(height: 10),
                        Text(item['name'],maxLines: 3,overflow: TextOverflow.ellipsis,),
                        const SizedBox(height: 10),
                        Text(item['time']),
                        Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(onTap: (){
                              controller.listItem.removeWhere((element) => element['name']==item['name']);
                            },child: const Icon(Icons.delete),),
                            InkWell(onTap: (){
                              item['name']='111';
                              controller.update();
                            },child: const Icon(Icons.edit),),
                          ],
                        )
                      ],
                    ),
                    );
                  }).toList(),
                );
              }).toList()// This trailing co
            ],
          ));
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // print(object)
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  check(List item,String name){
    for (var element in item) {
      if(element['name'] != name) {
        print('----${element['name']}');
        print('----${name}');
       continue;
      }else {
        return false;
      }
    }
  }
}
