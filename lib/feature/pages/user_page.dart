import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController.text = '0';
    _sizeController.text = '10';
    _fetchUsers();
  }

  void _fetchUsers() {
    final int page = int.tryParse(_pageController.text) ?? 0;
    final int size = int.tryParse(_sizeController.text) ?? 10;
    context.read<UserBloc>().add(FetchUsers(page: page, size: size));
  }

  void _nextPage() {
    final int currentPage = int.tryParse(_pageController.text) ?? 1;
    _pageController.text = (currentPage + 1).toString();
    _fetchUsers();
  }

  void _prevPage() {
    final int currentPage = int.tryParse(_pageController.text) ?? 1;
    if (currentPage > 1) {
      _pageController.text = (currentPage - 1).toString();
      _fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pageController,
                    decoration: InputDecoration(labelText: 'Page Number'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _sizeController,
                    decoration: InputDecoration(labelText: 'Page Size'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _fetchUsers,
                  child: Text('Fetch Users'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prevPage,
                  child: Text('Previous Page'),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text('Next Page'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {

                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserLoaded) {
                    print("User List count ${state.users.length}");
                    return ListView.builder(

                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                        );
                      },
                    );
                  } else if (state is UserError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return Center(child: Text('No Users Found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}