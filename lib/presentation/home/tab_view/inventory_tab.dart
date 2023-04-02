import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../tab_controller/inventory_tab_controller.dart';

import '../../../domain/entity/category_entity.dart';
import '../../../domain/entity/product_entity.dart';

import '../../../core/components/table_components.dart';
import '../../../core/constant/color_constant.dart';
import '../../../core/constant/values_constant.dart';
import '../../../core/utils/decoration_utils.dart';
import '../../../core/utils/dialog_utils.dart';

class InventoryTab extends StatefulWidget {
  const InventoryTab({super.key});

  @override
  State<InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  final TextEditingController tecSearch = TextEditingController();
  final TextEditingController tecCode = TextEditingController();
  final TextEditingController tecName = TextEditingController();
  final TextEditingController tecPrice = TextEditingController();
  final TextEditingController tecStock = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = context.read<InventoryTabController>();
    controller.resetTab();
    controller.setCategories();
    controller.setProductData();
  }

  @override
  void dispose() {
    super.dispose();
    tecCode.dispose();
    tecName.dispose();
    tecPrice.dispose();
    tecStock.dispose();
    tecSearch.dispose();
  }

  void resetTec() {
    tecCode.clear();
    tecName.clear();
    tecPrice.clear();
    tecName.clear();
    tecStock.clear();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final controller = context.watch<InventoryTabController>();
    final size = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Container(
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SizedBox(
                            width: 200,
                            child: TextField(
                              controller: tecSearch,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                fillColor: Colors.white60,
                                hintText: "Search (Title)",
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
                                      controller.setProductData();
                                      tecSearch.clear();
                                      return;
                                    }

                                    if (tecSearch.text.isEmpty) return;

                                    controller
                                        .searchDataProduct(tecSearch.text);
                                  },
                                  child: Icon(
                                    controller.isSearch
                                        ? UniconsLine.times
                                        : UniconsLine.search_alt,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SizedBox(
                            width: 200,
                            child: DropdownSearch<String>(
                              items: const [
                                "Code",
                                "Name",
                                "Stock",
                                "Price",
                                "Sold",
                              ],
                              selectedItem: "Code",
                              onChanged: (String? value) {
                                controller.changeOrderColumn(value!);
                                controller.setProductData();
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
                                  DecorationUtils.dropdownStyleForm(
                                "Filter",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        IconButton(
                          onPressed: () {
                            controller.tooggleSort();
                            controller.setProductData();
                          },
                          icon: Icon(
                            UniconsLine.sort,
                            color: controller.orderSort
                                ? primaryColor
                                : Colors.black54,
                          ),
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(18),
                              backgroundColor: primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Generate Report",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  resetTec();
                                  controller.resetDialogAttr();
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DialogProductAdd(
                                      tecCode: tecCode,
                                      tecName: tecName,
                                      tecPrice: tecPrice,
                                      tecStock: tecStock,
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
                              "Create Product",
                              style: TextStyle(fontSize: 12),
                            ),
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
                      size >= 770 ? Axis.vertical : Axis.horizontal,
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
                      4: IntrinsicColumnWidth(),
                      5: IntrinsicColumnWidth(),
                      6: IntrinsicColumnWidth(),
                      7: IntrinsicColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      // Header Data Table
                      TableComponent.headerTable(
                        [
                          "Number",
                          "Code",
                          "Name",
                          "Price",
                          "Stock",
                          "Sold",
                          "Category",
                          "Action",
                        ],
                      ),
                      // Body Data Table
                      ...controller.listProduct
                          .asMap()
                          .map(
                            (index, val) => MapEntry(
                              index,
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
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
                                          val.code,
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
                                          val.name,
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
                                          val.price.toString(),
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
                                          val.stock.toString(),
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
                                          val.sold.toString(),
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
                                          val.titleCategory,
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
                                            // Edit
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    resetTec();
                                                    controller
                                                        .resetDialogAttr();
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: DialogProductEdit(
                                                        product: val,
                                                        tecCode: tecCode,
                                                        tecName: tecName,
                                                        tecPrice: tecPrice,
                                                        tecStock: tecStock,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon:
                                                  const Icon(UniconsLine.edit),
                                            ),
                                            // Delete
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return DialogUtils
                                                        .dialogConfirmation(
                                                      title: "Delete Product",
                                                      message:
                                                          "Are you sure delete this product ?",
                                                      callbackConfirmation: () {
                                                        controller
                                                            .removeProduct(
                                                          val.code,
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
                                              icon:
                                                  const Icon(UniconsLine.trash),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .values
                          .toList()
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
        )
      ],
    );
  }
}

class DialogProductAdd extends StatelessWidget {
  final TextEditingController tecCode;
  final TextEditingController tecName;
  final TextEditingController tecPrice;
  final TextEditingController tecStock;

  const DialogProductAdd({
    required this.tecCode,
    required this.tecName,
    required this.tecPrice,
    required this.tecStock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InventoryTabController>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Create Product",
      childern: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: tecCode,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Product Code",
                  hint: "Example : BN-R-0001",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecName,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Product Name",
                  hint: "Example : Beng-beng",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecPrice,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Price",
                  hint: "Example : 20000",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecStock,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Stock",
                  hint: "Example : 1000",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<CategoryEntity>(
                items: controller.listCategories,
                compareFn: (item1, item2) => item1.isEqual(item2),
                itemAsString: (item) => item.toString(),
                selectedItem: controller.categorySelection,
                onChanged: (CategoryEntity? value) =>
                    controller.changeCategorySelection(value!),
                validator: (value) {
                  if (value == null) {
                    return fieldRequired;
                  }

                  return null;
                },
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
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
                  "Select Category",
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

            controller.addProduct(
              code: tecCode.text,
              name: tecName.text,
              price: int.parse(tecPrice.text),
              stock: int.parse(tecStock.text),
              sold: 0,
              idCategory: controller.categorySelection!.id,
              callbackSuccess: () => navigator.pop(),
            );
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Add"),
        ),
        if (controller.errDialogMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              controller.errDialogMessage,
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

class DialogProductEdit extends StatelessWidget {
  final ProductViewEntity product;
  final TextEditingController tecCode;
  final TextEditingController tecName;
  final TextEditingController tecPrice;
  final TextEditingController tecStock;

  const DialogProductEdit({
    required this.product,
    required this.tecCode,
    required this.tecName,
    required this.tecPrice,
    required this.tecStock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InventoryTabController>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    // Set attr value
    tecCode.text = product.code;
    tecName.text = product.name;
    tecPrice.text = product.price.toString();
    tecStock.text = product.stock.toString();

    controller.changeCategorySelection(
      controller.listCategories
          .where((element) => element.title == product.titleCategory)
          .first,
    );

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Edit Product",
      childern: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: tecCode,
                enabled: false,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Product Code",
                  hint: "Example : BN-R-0001",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecName,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Product Name",
                  hint: "Example : Beng-beng",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecPrice,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Price",
                  hint: "Example : 20000",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: tecStock,
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return fieldRequired;
                  }

                  return null;
                },
                style: const TextStyle(fontSize: 14),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: DecorationUtils.textFieldDecoration(
                  label: "Stock",
                  hint: "Example : 1000",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<CategoryEntity>(
                items: controller.listCategories,
                compareFn: (item1, item2) => item1.isEqual(item2),
                itemAsString: (item) => item.toString(),
                selectedItem: controller.categorySelection,
                onChanged: (CategoryEntity? value) =>
                    controller.changeCategorySelection(value!),
                validator: (value) {
                  if (value == null) {
                    return fieldRequired;
                  }

                  return null;
                },
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
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
                  "Select Category",
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

            controller.changeProduct(
              ProductEntity(
                code: product.code,
                name: tecName.text,
                price: int.parse(tecPrice.text),
                stock: int.parse(tecStock.text),
                sold: product.sold,
                idCategory: controller.categorySelection!.id,
                createdAt: DateTime.now(),
              ),
            );

            navigator.pop();
          },
          style: DecorationUtils.buttonDialogStyle(),
          child: const Text("Edit"),
        ),
        if (controller.errDialogMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              controller.errDialogMessage,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          )
      ],
      callbackClose: () => navigator.pop(),
    );
  }
}
