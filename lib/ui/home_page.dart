import 'package:bus/cubit/destination_cubit.dart';
import 'package:bus/models/destination_model.dart';
import 'package:bus/widget/button.dart';
import 'package:bus/widget/custom_card.dart';
import 'package:bus/widget/custom_search.dart';
import 'package:bus/widget/custom_search_date.dart';
import 'package:bus/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/Home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _datePickerControllerAwal = TextEditingController();
  TextEditingController _datePickerControllerAkhir = TextEditingController();
  TextEditingController _searchControllerAwal = TextEditingController();
  TextEditingController _searchControllerTujuan = TextEditingController();

  @override
  void initState() {
    context.read<DestinationCubit>().fetchDestinations();
    super.initState();
  }

  @override
  void dispose() {
    _datePickerControllerAwal.dispose();
    _datePickerControllerAkhir.dispose();
    _searchControllerAwal.dispose();
    _searchControllerTujuan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<DestinationCubit, DestinationState>(
          listener: (context, state) {
            if (state is DestinationFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[400],
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is DestinationSuccess) {
              List<DestinationModel> destination = state.destinations;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: 'Halo,\n',
                                  style: myTextTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text: 'TAMRIN',
                                      style: myTextTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 194, 194, 194),
                                child: Icon(Icons.account_circle),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          Text("Mau kemana hari ini?",
                              style: myTextTheme.titleMedium),
                          const SizedBox(height: 20),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: secondGrey),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CustomSearch(
                                    labelText: "Dari",
                                    hintText: "Destinasi awal",
                                    controller: _searchControllerAwal,
                                  ),
                                  const SizedBox(height: 15),
                                  CustomSearch(
                                    labelText: "Ke",
                                    hintText: "Destinasi Akhir",
                                    controller: _searchControllerTujuan,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomDateSearch(
                                          controller: _datePickerControllerAwal,
                                          labelText: "Keberangkatan",
                                          hintText: "tanggal",
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: CustomDateSearch(
                                          controller:
                                              _datePickerControllerAkhir,
                                          labelText: "Kepulangan",
                                          hintText: "tanggal",
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  BlocConsumer<DestinationCubit,
                                      DestinationState>(
                                    listener: (context, state) {
                                      final scaffoldMessenger =
                                          ScaffoldMessenger.of(context);
                                      if (state is DestinationSuccess) {
                                        scaffoldMessenger.showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Text("Success"),
                                          ),
                                        );
                                      } else if (state is DestinationFailed) {
                                        scaffoldMessenger.showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(state.error),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is DestinationLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return InkWell(
                                        onTap: () => search(),
                                        child: const CustomButton(
                                            height: 50, text: "Mencari"),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          destination.length,
                          (idx) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: CustomCard(
                                destination: destination[idx],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void search() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    String destinasiAwal = _searchControllerAwal.text;
    String destinasiTujuan = _searchControllerTujuan.text;
    String waktuKeberangkatan = _datePickerControllerAwal.text;
    String waktuKepulangan = _datePickerControllerAkhir.text;

    if (destinasiAwal.isEmpty || destinasiTujuan.isEmpty) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red[400],
          content: const Text(
              "Silahkan isi destinasi awal atau tujuan terlebih dahulu"),
        ),
      );
    } else if (waktuKepulangan.isNotEmpty && waktuKeberangkatan.isNotEmpty) {
      DateTime departureTime =
          DateFormat('dd MMM yyyy').parse(waktuKeberangkatan);
      DateTime arrivalTime = DateFormat('dd MMM yyyy').parse(waktuKepulangan);
      if (departureTime.isAfter(arrivalTime)) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red[400],
            content: const Text(
                "Waktu keberangkatan harus sebelum waktu kepulangan"),
          ),
        );
      } else {
        context.read<DestinationCubit>().searchDestinations(
              destinasiAwal,
              destinasiTujuan,
              waktuKeberangkatan,
              waktuKepulangan,
            );
      }
    } else if (waktuKepulangan.isNotEmpty && waktuKeberangkatan.isEmpty) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red[400],
          content:
              const Text("Silahkan isi waktu keberangkatan terlebih dahulu"),
        ),
      );
    } else if (waktuKeberangkatan.isNotEmpty) {
      context.read<DestinationCubit>().searchDestinations(
            destinasiAwal,
            destinasiTujuan,
            waktuKeberangkatan,
            null,
          );
    } else {
      context.read<DestinationCubit>().searchDestinations(
            destinasiAwal,
            destinasiTujuan,
            null,
            null,
          );
    }
  }
}
