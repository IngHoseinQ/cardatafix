import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'data.dart';

class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  late final List<Tab> _tabs;
  late final List<Widget> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabs = [
      Tab(text: 'Vehicles'),
      Tab(text: 'Workers'),
      Tab(text: 'Store'),
    ];
    _tabViews = [
      _buildVehicleTabView(),
      _buildWorkerTabView(),
      _buildStoreTabView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab View'),
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabViews,
        ),
      ),
    );
  }

  Widget _buildVehicleTabView() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getVehicles(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Type: ${data[index]['type']}'),
                subtitle: Text('Model: ${data[index]['model']}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildWorkerTabView() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getWorkers(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Name: ${data[index]['name']}'),
                subtitle: Text('Profession: ${data[index]['profession']}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildStoreTabView() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getStore(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Store Name: ${data[index]['storeName']}'),
                subtitle: Text('Part Name: ${data[index]['partName']}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
