import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practic/database.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthState();
  }
}

class AuthState extends State<AuthPage> {
  Database? database;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    String loginString = loginController.text.trim();
    String passwordString = passwordController.text.trim();

    database = Database(loginString, passwordString);

    database!.connection.then((value) {
      if (value.isOpen) {
        Navigator.pushReplacementNamed(context, '/home');
        return;
      }
    }).catchError((err) {
      database = null;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверные данные для входа!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Авторизация"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: loginController,
              style: const TextStyle(
                  color: Colors.black), // Устанавливаем белый цвет текста
              decoration: const InputDecoration(
                labelText: 'Логин',
                labelStyle: TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет надписи
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Устанавливаем белый цвет границы
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Colors.black), // Устанавливаем белый цвет при фокусе
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordController,
              style: const TextStyle(
                  color: Colors.black), // Устанавливаем белый цвет текста
              decoration: const InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет надписи
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Устанавливаем белый цвет границы
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Colors.black), // Устанавливаем белый цвет при фокусе
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(onPressed: login, child: const Text("Войти"))
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  int selectedMode = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.add), label: Text("Добавить")),
              // NavigationRailDestination(
              //     icon: Icon(Icons.edit), label: Text("Редактировать")),
              NavigationRailDestination(
                  icon: Icon(Icons.history), label: Text("История")),
            ],
            selectedIndex: selectedMode,
            minWidth: 100,
            useIndicator: true,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (value) => {
              setState(() {
                selectedMode = value;
              })
            },
          ),
          const VerticalDivider(
            thickness: 2,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: getBody(),
          ))
        ],
      ),
    );
  }

  Widget getBody() {
    switch (selectedMode) {
      case 0:
        return firstHomePage;
      // case 1:
      //   return secondHomePage;
      case 1:
        return thirdHomePage;
    }
    return const Center();
  }

  HomeState() {
    firstHomePage = firstHomePageBuilder();
    secondHomePage = secondHomePageBuilder();
    thirdHomePage = thirdHomePageBuilder();
  }

  late Widget firstHomePage;
  late Widget secondHomePage;
  late Widget thirdHomePage;

  Widget firstHomePageBuilder() {
    int selectedRecordType = 0;
    List<String> recordsName = ["Техника", "Арендатор", "Заказ"];

    Widget getTechnicAdd() {
      TextEditingController description_cntrl = TextEditingController();
      TextEditingController name_cntrl = TextEditingController();
      // return Text("empty");

      return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: name_cntrl,
                style: const TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет текста
                decoration: const InputDecoration(
                  labelText: 'Название',
                  labelStyle: TextStyle(
                      color: Colors.black), // Устанавливаем белый цвет надписи
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.black), // Устанавливаем белый цвет границы
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Устанавливаем белый цвет при фокусе
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: description_cntrl,
                style: const TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет текста
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  labelStyle: TextStyle(
                      color: Colors.black), // Устанавливаем белый цвет надписи
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.black), // Устанавливаем белый цвет границы
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Устанавливаем белый цвет при фокусе
                  ),
                ),
                maxLines: 15,
                minLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text("Добавить"),
                onPressed: () {},
              )
            ],
          ));
    }

    Widget getTenantAdd() {
      TextEditingController fullname_cntrl = TextEditingController();
      TextEditingController phone_number_cntrl = TextEditingController();
      TextEditingController email_cntrl = TextEditingController();
      TextEditingController adress_cntrl = TextEditingController();
      // return Text("empty");

      return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: fullname_cntrl,
                style: const TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет текста
                decoration: const InputDecoration(
                  labelText: 'ФИО',
                  labelStyle: TextStyle(
                      color: Colors.black), // Устанавливаем белый цвет надписи
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.black), // Устанавливаем белый цвет границы
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Устанавливаем белый цвет при фокусе
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: phone_number_cntrl,
                style: const TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет текста
                decoration: const InputDecoration(
                  labelText: 'Номер телефона',
                  labelStyle: TextStyle(
                      color: Colors.black), // Устанавливаем белый цвет надписи
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.black), // Устанавливаем белый цвет границы
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Устанавливаем белый цвет при фокусе
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: email_cntrl,
                style: const TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет текста
                decoration: const InputDecoration(
                  labelText: 'Почта',
                  labelStyle: TextStyle(
                      color: Colors.black), // Устанавливаем белый цвет надписи
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.black), // Устанавливаем белый цвет границы
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Устанавливаем белый цвет при фокусе
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: adress_cntrl,
                style: const TextStyle(
                    color: Colors.black), // Устанавливаем белый цвет текста
                decoration: const InputDecoration(
                  labelText: 'Адрес',
                  labelStyle: TextStyle(
                      color: Colors.black), // Устанавливаем белый цвет надписи
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.black), // Устанавливаем белый цвет границы
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Устанавливаем белый цвет при фокусе
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text("Добавить"),
                onPressed: () {},
              )
            ],
          ));
    }


    Widget getOrderAdd() {
      TextEditingController cntrl = TextEditingController();

      return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: (){ }, child: Text("Дата начала")),
                  TextButton(onPressed: (){}, child: Text("Дата окончания")),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  Text("Выберите арендатора"),
                  Text("Выберите технику")
                ],
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(items: [
                    DropdownMenuItem(child: Text("Заречный Адриан Олегович"))
                  ], onChanged: (index){}),
                  DropdownButton(items: [
                    DropdownMenuItem(child: Text("КАМАЗ 5320 + прицеп"))
                  ], onChanged: (index){})
                ],
              ),

              TextButton(
                child: Text("Добавить"),
                onPressed: () {},
              )
            ],
          ));
    }








    Widget getFieldsForData() {
      switch (selectedRecordType) {
        case 0:
          return getTechnicAdd();
        case 1:
          return getTenantAdd();
        case 2:
          return getOrderAdd();
      }
      return Text("empty");
    }

    return StatefulBuilder(builder: (context, setStateFirst) {
      return Column(children: [
        Row(
            children: List.generate(recordsName.length, (index) {
          String recordName = recordsName[index];
          return TextButton(
            onPressed: () {
              setStateFirst(() {
                selectedRecordType = index;
              });
            },
            child: Text(recordName),
            style: ButtonStyle(
              backgroundColor: (selectedRecordType == index)
                  ? WidgetStateColor.resolveWith((states) => Colors.blue)
                  : null,
            ),
          );
        })),
        getFieldsForData()
      ]);
    });
  }

  Widget secondHomePageBuilder() {
    return StatefulBuilder(builder: (context, setStateFirst) {
      return Column(children: [Text("fd")]);
    });
  }

  Widget thirdHomePageBuilder() {
    return StatefulBuilder(builder: (context, setStateFirst) {
      return Column(children: [DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Дата начала'),
          ),
          DataColumn(
            label: Text('Дата конца'),
          ),
          DataColumn(
            label: Text('Арендатор'),
          ),
          DataColumn(
            label: Text('Техника'),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2024-06-07 9.00')),
              DataCell(Text('2024-06-27 9.00')),
              DataCell(Tooltip(
                message: 'adrian_zare@mail.ru\n+375(29)2330156\nг.Брест, ул. Московская , 267/15',
                child: Text('Заречный Адриан Олегович'),
              )),
              DataCell(Tooltip(
                message: 'Грузоподъемность - 5+8т',
                child: Text('КАМАЗ 5320 + прицеп'),
              )),
            ],
          ),

          // Добавьте больше строк по необходимости
        ],
      ),]);
    });
  }
}
