import 'package:flutter/material.dart';

import '/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/Filters-screen';

  //This function is stored in a property of my widget, not the state,
  //but we can use the special "widget." property inside of your state objects
  //in your state classes
  //to use it in the state below
  final Function saveFilters;
  Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  // Widget _buildSwitchListTile(String title, String description,
  //     bool currentValue, Function(bool) updateValue) {
  //   return SwitchListTile(
  //     title: Text(title),
  //     subtitle: Text(description),
  //     value: _glutenFree,
  //     onChanged: updateValue,
  //     //The argument type 'dynamic Function()' can't be assigned to the parameter type 'void Function(bool)?'.
  //     //This was fixed by doing Function(bool) updateValue
  //   );
  // }
  //For some reason, this function does not work,
  //all 4 created switches were controlling by flicking a single switch for some reason

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };

                widget.saveFilters(selectedFilters);

                Navigator.of(context).pushNamed('/');
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Adjust your meal selection",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              SwitchListTile(
                title: Text("Gluten-Free"),
                subtitle: Text("Only include gluten-free meals"),
                value: _glutenFree,
                onChanged: (newvalue) {
                  setState(() {
                    _glutenFree = newvalue;
                  });
                },
              ),
              SwitchListTile(
                title: Text("Vegetarian"),
                subtitle: Text("Only include vegetarian meals"),
                value: _vegetarian,
                onChanged: (newvalue) {
                  setState(() {
                    _vegetarian = newvalue;
                  });
                },
              ),
              SwitchListTile(
                title: Text("Vegan"),
                subtitle: Text("Only include Vegan meals"),
                value: _vegan,
                onChanged: (newvalue) {
                  setState(() {
                    _vegan = newvalue;
                  });
                },
              ),
              SwitchListTile(
                title: Text("Lactose-Free"),
                subtitle: Text("Only include Lactose-free meals"),
                value: _lactoseFree,
                onChanged: (newvalue) {
                  setState(() {
                    _lactoseFree = newvalue;
                  });
                },
              )
            ],
          ),
        )
      ]),
    );
  }
}
