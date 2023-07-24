import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/process_item_model.dart';
import 'package:vici_technical_test/features/cart/presentation/cubit/cart_cubit.dart';

import '../../../../core/api/pdf_api.dart';
import '../../../../core/api/pdf_invoice_api.dart';
import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/format_currency.dart';
import '../../../../widgets/not_found_widget.dart';
import '../../domain/datas/models/customer.dart';
import '../../domain/datas/models/invoice.dart';
import '../../domain/datas/models/supplier.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    fecthCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          previous.listProcessCartModel != current.listProcessCartModel,
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return state.listProcessCartModel!.isEmpty
            ? const SingleChildScrollView(
                child: NotFoundWidget(
                    image: 'assets/images/tracking_not_found.png',
                    title: 'Pertanyaan Kosong',
                    subtitle: 'Silahkan Coba Lagi Nanti'),
              )
            : Scaffold(
                appBar: AppBar(
                  surfaceTintColor: Colors.white,
                  title: Text(
                    'Cart',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontSize: 26.sp,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  elevation: 0,
                  actions: [
                    GeneratePdf(state.listProcessCartModel!),
                  ],
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.white,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AlignedGridView.count(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          crossAxisCount: 1,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          itemCount: state.listProcessCartModel!.length,
                          itemBuilder: (context, index) {
                            final item = state.listProcessCartModel![index];
                            return itemsCard(item);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future<void> fecthCart() async {
    return await sl<CartCubit>().fetchCardListEvent();
  }

  Widget itemsCard(ProcessItemModel item) {
    ///create item card row
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(item.fotoProduct!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.namaProduct!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      // item.hargaProduct.toString(),
                      CurrencyFormat.convertToIdr(item.priceCount, 0),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IconButton(
                        //   icon: const Icon(Icons.remove),
                        //   onPressed: () {
                        //     sl<CartCubit>().removeItemCartEvent(item);
                        //   },
                        // ),
                        Text(
                          item.quantityCount.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneratePdf extends StatefulWidget {
  final List<ProcessItemModel> list;

  const GeneratePdf(this.list, {super.key});

  @override
  State<GeneratePdf> createState() => _GeneratePdfState();
}

class _GeneratePdfState extends State<GeneratePdf> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.picture_as_pdf),
      onPressed: () {
        // sl<CartCubit>().generatePdfEvent();
        pdfInvoice(widget.list!);
      },
    );
  }

  Future<void> pdfInvoice(List<ProcessItemModel> list) async {
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    final invoice = Invoice(
      customer: const Customer(
        name: 'Kasir',
        address:
            'Jl. Puri Indah Raya, RT.1/RW.2, Kembangan Sel., Kec. Kembangan, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11610',
      ),
      supplier: const Supplier(
        name: 'VICI',
        address:
            'Puri Indah Financial Tower, 10-11 Floor, Jl. Puri Lkr. Dalam Jl. Puri Indah Raya, RT.1/RW.2, Kembangan Sel., Kec. Kembangan, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11610',
        paymentInfo: 'https://paypal.me/Vici',
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'My description...',
        number: '${DateTime.now().year}-9999',
      ),
      items: [
        for (var item in list)
          InvoiceItem(
            description: item.namaProduct!,
            date: DateTime.now(),
            quantity: item.quantityCount!,
            vat: 0,
            unitPrice: item.priceCount!,
          ),
      ],
    );

    final pdf = pw.Document();

    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Invoice'),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Sarah Field'),
                  pw.Text('Example Street 42'),
                  pw.Text('1234 Example Town'),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Invoice Number:'),
                  pw.Text('9999'),
                ],
              ),
              pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Invoice Date:'),
                  pw.Text('24.05.2021'),
                ],
              ),
              pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Due Date:'),
                  pw.Text('31.05.2021'),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        child: pw.Text(
                          'INVOICE FOR PAYMENT',
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        padding: const pw.EdgeInsets.all(20),
                      ),
                    ],
                  ),
                  ...list.map(
                    (e) {
                      return pw.TableRow(children: [
                        pw.Expanded(child: pw.Text(e.namaProduct!)),
                        pw.Expanded(child: pw.Text(e.priceCount.toString())),
                      ]);
                    },
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        child: pw.Text(
                          'Total',
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        padding: const pw.EdgeInsets.all(20),
                      ),
                      pw.Padding(
                        child: pw.Text(
                          list.fold<int>(
                              0, (sum, item) => sum + item.priceCount!) as String,
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        padding: const pw.EdgeInsets.all(20),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );

    // final pdfFile = await PdfInvoiceApi.generate(invoice);
    //
    // PdfApi.openFile(pdfFile);

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/my_pdf.pdf');
    await file.writeAsBytes(await pdf.save());
    print('PDF saved to ${file.path}');
  }
}
