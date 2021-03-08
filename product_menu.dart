import 'package:flutter/material.dart';

class ProductMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi List Menu"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => EntryItem(
            data[index],
          ),
        ),
      ),
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data = <Entry>[
  Entry(
    'Fashion',
    <Entry>[
      Entry(
        'Mens Top Wear',
        <Entry>[
          Entry('Casual Shirts'),
          Entry('Formal Shirts'),
          Entry('Mens Kurta'),
        ],
      ),
      Entry('Kids'),
      Entry('Winters'),
    ],
  ),
  // Second Row
  Entry('Mens Bottom Wear', <Entry>[
    Entry('Mens Jeans'),
    Entry('Mens Trausors'),
  ]),
  Entry(
    'Electronics',
    <Entry>[
      Entry('Mobile Accessory'),
      Entry('Powerbank'),
      Entry(
        'Audio',
        <Entry>[
          Entry('Bluetooth HeadPhones'),
          Entry('Wired Headphones'),
          Entry('Bluetooth Speakers'),
          Entry('Soundbars'),
        ],
      )
    ],
  ),
];

// Create the Widget for the row
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  // This function recursively creates the multi-level list rows.
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
