import 'package:flutter/material.dart';

class PaginatedList extends StatefulWidget {
  @override
  _PaginatedListState createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  int currentPage = 0;
  final int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    int totalPages = (items.length / itemsPerPage).ceil();

    List<String> getCurrentPageItems() {
      int start = currentPage * itemsPerPage;
      int end = start + itemsPerPage;
      return items.sublist(start, end > items.length ? items.length : end);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: getCurrentPageItems().length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(getCurrentPageItems()[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Page ${currentPage + 1} of $totalPages'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: currentPage > 0
                          ? () {
                              setState(() {
                                currentPage--;
                              });
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: currentPage < totalPages - 1
                          ? () {
                              setState(() {
                                currentPage++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
