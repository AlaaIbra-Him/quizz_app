import 'package:flutter/material.dart';
import 'package:my_sec_app/provider/category_provider.dart';
import 'package:my_sec_app/screens/quistion_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_sec_app/models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  void _searchCategory(String query, List<CategoryModel> all) {
    final results = all
        .where((cat) => cat.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredCategories = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    final categories = provider.categories;

    final listToShow = _filteredCategories.isEmpty
        ? categories
        : _filteredCategories;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Categories', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // -----------------------------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (q) => _searchCategory(q, categories),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // --------------------------------
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: listToShow.length,
                    itemBuilder: (context, index) {
                      final category = listToShow[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.quiz_outlined),
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.blueAccent,
                          //   child: Text(
                          //   "Q",
                          //     style: const TextStyle(color: Colors.white),
                          //   ),
                          // ),
                          title: Text(category.name ?? "error"),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionsScreen(
                                  categoryId: category.id!,
                                  categoryName: category.name ?? "",
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "quize"),
        ],
      ),
    );
  }
}
