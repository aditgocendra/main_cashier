import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:main_cashier/domain/entity/user_entity.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../domain/entity/role_entity.dart';
import '../tab_controller/users_tab_controller.dart';

import '../../../core/components/table_components.dart';
import '../../../core/constant/color_constant.dart';
import '../../../core/constant/values_constant.dart';
import '../../../core/utils/decoration_utils.dart';
import '../../../core/utils/dialog_utils.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  final TextEditingController tecUsername = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();
  final TextEditingController tecSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = context.read<UsersTabController>();
    controller.setDataRole();
    controller.setDataUser();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersTabController>();
    final navigator = Navigator.of(context);
    final size = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Container(
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          // controller: tecSearch,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            hintText: "Search",
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: borderColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                if (controller.isSearch) {
                                  controller.tooggleIsSearch();
                                  controller.setDataUser();
                                  tecSearch.clear();
                                  return;
                                }

                                if (tecSearch.text.isEmpty) return;

                                controller.searchDataUser(
                                  tecSearch.text,
                                );
                              },
                              child: const Icon(
                                UniconsLine.search_alt,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DialogUserAdd(
                                      tecUsername: tecUsername,
                                      tecPassword: tecPassword,
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(18),
                              backgroundColor: primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Create User",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SelectionArea(
                  child: SingleChildScrollView(
                    scrollDirection:
                        size >= 450 ? Axis.vertical : Axis.horizontal,
                    child: Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          width: 0.1,
                        ),
                        top: BorderSide(
                          width: 0.1,
                        ),
                        bottom: BorderSide(
                          width: 0.1,
                        ),
                      ),
                      // defaultColumnWidth: FixedColumnWidth(1800 / 3),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                        3: IntrinsicColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        // Header Data Table
                        TableComponent.headerTable(
                          ["UID", "Username", "Role", "Action"],
                        ),
                        // Body Data Table
                        ...controller.listUser.map((val) {
                          return TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      val.uid.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      val.username,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      val.roleName,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Wrap(
                                      children: [
                                        // Change Password
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: DialogUserChangePass(
                                                    user: val,
                                                    tecPassword: tecPassword,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            UniconsLine.key_skeleton_alt,
                                          ),
                                        ),

                                        // Edit
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: DialogUserEdit(
                                                    user: val,
                                                    tecUsername: tecUsername,
                                                    tecPassword: tecPassword,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(UniconsLine.edit),
                                        ),
                                        // Delete
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DialogUtils
                                                    .dialogConfirmation(
                                                  title: "Delete User",
                                                  message:
                                                      "Are you sure delete this user ?",
                                                  callbackConfirmation: () {
                                                    controller.removeUser(
                                                      val.uid,
                                                    );

                                                    navigator.pop();
                                                  },
                                                  callbackCancel: () {
                                                    navigator.pop();
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(UniconsLine.trash),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList()
                      ],
                    ),
                  ),
                ),
                // Footer
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            "Rows per page",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 75,
                            child: DropdownSearch<int>(
                              items: const [10, 25, 50],
                              selectedItem: 10,
                              onChanged: (int? value) {
                                controller.updateRowPage(value!);
                              },
                              popupProps: PopupProps.menu(
                                fit: FlexFit.loose,
                                menuProps: const MenuProps(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                containerBuilder: (ctx, popupWidget) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Flexible(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                          child: popupWidget,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // Back Page
                          IconButton(
                            onPressed: () {
                              controller.backPage();
                            },
                            icon: const Icon(Icons.keyboard_arrow_left),
                          ),
                          Text(
                            controller.activeRowPage.toString(),
                            style: const TextStyle(
                              fontSize: 12.5,
                            ),
                          ),
                          // Next Page
                          IconButton(
                            onPressed: () {
                              controller.nextPage();
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DialogUserAdd extends StatelessWidget {
  final TextEditingController tecUsername;
  final TextEditingController tecPassword;

  const DialogUserAdd({
    required this.tecUsername,
    required this.tecPassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersTabController>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Create User",
      childern: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: tecUsername,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Username",
                  hint: "Example : Fred",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecPassword,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Password",
                  hint: "Example : Beng-beng",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<RoleEntity>(
                items: controller.listRole,
                compareFn: (item1, item2) => item1.isEqual(item2),
                itemAsString: (item) => item.toString(),
                selectedItem: controller.selectionRole,
                onChanged: (RoleEntity? value) {
                  controller.changeRoleUserSelection(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return fieldRequired;
                  }

                  return null;
                },
                popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: const MenuProps(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  containerBuilder: (ctx, popupWidget) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Flexible(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: popupWidget,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                dropdownDecoratorProps: DecorationUtils.dropdownStyleForm(
                  "Role",
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            controller.addUser(
              UserEntity(
                uid: "",
                username: tecUsername.text,
                password: tecPassword.text,
                roleId: controller.selectionRole!.id,
                createdAt: DateTime.now(),
              ),
            );

            navigator.pop();
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Add"),
        ),
        if (controller.errMessageDialog.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              controller.errMessageDialog,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          )
      ],
      callbackClose: () {
        navigator.pop();
      },
    );
  }
}

class DialogUserEdit extends StatelessWidget {
  final TextEditingController tecUsername;
  final TextEditingController tecPassword;
  final UserViewEntity user;

  const DialogUserEdit({
    required this.tecUsername,
    required this.tecPassword,
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersTabController>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    // Set user entity
    tecUsername.text = user.username;

    controller.changeRoleUserSelection(
      controller.listRole
          .where((element) => element.name == user.roleName)
          .first,
    );

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Edit User",
      childern: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: tecUsername,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Username",
                  hint: "Example : Fred",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<RoleEntity>(
                items: controller.listRole,
                compareFn: (item1, item2) => item1.isEqual(item2),
                itemAsString: (item) => item.toString(),
                selectedItem: controller.selectionRole,
                onChanged: (RoleEntity? value) {},
                popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: const MenuProps(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  containerBuilder: (ctx, popupWidget) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Flexible(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: popupWidget,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                dropdownDecoratorProps: DecorationUtils.dropdownStyleForm(
                  "Role",
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            controller.editUser(
              user.uid,
              tecUsername.text,
              controller.selectionRole!.id,
            );

            if (controller.errMessageDialog.isNotEmpty) return;

            navigator.pop();
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Edit"),
        ),
        if (controller.errMessageDialog.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              controller.errMessageDialog,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          )
      ],
      callbackClose: () {
        navigator.pop();
      },
    );
  }
}

class DialogUserChangePass extends StatelessWidget {
  final TextEditingController tecPassword;
  final UserViewEntity user;

  const DialogUserChangePass({
    required this.tecPassword,
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersTabController>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Change Password User",
      childern: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: tecPassword,
                validator: (pass) {
                  if (pass == null || pass.isEmpty) {
                    return fieldRequired;
                  }

                  if (pass.length < 8) {
                    return "Password at least 8 character";
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "New Password",
                  hint: "Example : *******",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            controller.changePasswordUser(
              user.uid,
              tecPassword.text,
            );

            if (controller.errMessageDialog.isNotEmpty) return;

            navigator.pop();
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Change"),
        ),
        if (controller.errMessageDialog.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              controller.errMessageDialog,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          )
      ],
      callbackClose: () {
        navigator.pop();
      },
    );
  }
}
