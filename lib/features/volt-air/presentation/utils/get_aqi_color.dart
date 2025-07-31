import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';

class HealthImpact {
  final String summary;
  final Widget immediateImpact;
  final Widget longTermImpact;
  final Widget healthTips;
  final Widget activityRecommendations;

  const HealthImpact({
    this.summary = "",
    this.immediateImpact = const SizedBox.shrink(),
    this.longTermImpact = const SizedBox.shrink(),
    this.healthTips = const SizedBox.shrink(),
    this.activityRecommendations = const SizedBox.shrink(),
  });
}

class AirQualityInfo {
  final Color color;
  final IconData icon;
  final String description;
  final Color backgroundColor;
  final HealthImpact? healthImpact;

  AirQualityInfo({
    required this.color,
    required this.description,
    required this.backgroundColor,
    this.icon = Iconsax.danger,
    this.healthImpact,
  });
}

AirQualityInfo getAirQualityInfo(int aqi) {
  final Map<int, AirQualityInfo> aqiMap = {
    0: AirQualityInfo(
      color: AppPallete.goodAir,
      icon: Iconsax.lovely,
      backgroundColor: Colors.lightGreen[100]!,
      description: "Baik ",
      healthImpact: HealthImpact(
        summary:
            'Kualitas udara pada tingkat ini sangat baik dan tidak menimbulkan'
            ' risiko kesehatan. Semua aktivitas luar ruangan aman untuk dilakukan. ',
        immediateImpact: RichText(
          text: const TextSpan(
            text: 'Wah! ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'Kualitas udaranya memuaskan ',
                style: TextStyle(color: AppPallete.primaryColor),
              ),
              TextSpan(
                text:
                    'ya, VoltMates! Tidak ada risiko untuk kesehatan lho, happy deh! ',
              ),
            ],
          ),
        ),
        longTermImpact: RichText(
          text: const TextSpan(
            text: 'Tidak ada ',
            style: TextStyle(
              color: AppPallete.primaryColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text:
                    'dampak kesehatan jangka panjang yang signifikan kok, VoltMates! ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        healthTips: RichText(
          text: const TextSpan(
            text: 'Ga ada tindakan khusus, tapi tetap ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'jaga kesehatan ',
                style: TextStyle(
                  color: AppPallete.primaryColor,
                ),
              ),
              TextSpan(
                text: 'ya, VoltMates! ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        activityRecommendations: RichText(
          text: const TextSpan(
            text: 'Semua aktivitas luar ruangan aman untuk'
                ' dilakukan lho! Mungkin kamu'
                ' mau jogging, mancing, atau main golf? ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'It’s up to you',
                style: TextStyle(
                  color: AppPallete.primaryColor,
                ),
              ),
              TextSpan(
                text: ', guys!',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    1: AirQualityInfo(
      color: AppPallete.mediumAir,
      description: "Sedang",
      backgroundColor: AppPallete.voltAirBackgroundColor,
      healthImpact: HealthImpact(
        summary: 'Kualitas udara cukup'
            ' baik untuk sebagian besar orang,'
            ' namun orang yang sangat sensitif'
            ' terhadap polusi mungkin mengalami'
            ' dampak ringan. Semua aktivitas luar ruangan umumnya aman.',
        immediateImpact: RichText(
          text: const TextSpan(
            text: 'Kualitas udaranya',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'cukup baik ',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
              TextSpan(
                text: 'namun beberapa orang yang ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'sangat sensitif',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
              TextSpan(
                text:
                    'terhadap polusi mungkin mengalami gejala ringan seperti iritasi pada sistem pernapasan. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'Stay safe ',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
              TextSpan(
                text: 'VoltMates! ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        longTermImpact: RichText(
          text: const TextSpan(
            text: 'Paparan jangka panjang pada tingkat ini biasanya ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'tidak menyebabkan masalah kesehatan yang serius, ',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
              TextSpan(
                text: 'meskipun orang yang sangat sensitif mungkin merasakan ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'dampak ringan. ',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
            ],
          ),
        ),
        healthTips: RichText(
          text: const TextSpan(
            text:
                "Bagi VoltMates yang sangat sensitif terhadap polusi udara harus "
                " mempertimbangkan untuk mengurangi aktivitas luar ruangan "
                " yang berat.",
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
          ),
        ),
        activityRecommendations: RichText(
          text: const TextSpan(
            text: 'PSebagian besar VoltMates ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'dapat melakukan aktivitas luar ruangan tanpa masalah ',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
              TextSpan(
                text: ', tetapi VoltMates yang sangat sensitif ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'harus waspada!.',
                style: TextStyle(
                  color: AppPallete.mediumAir,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    2: AirQualityInfo(
      color: AppPallete.dangerAir,
      description: "Tidak Sehat",
      backgroundColor: Colors.orange[100]!,
      healthImpact: HealthImpact(
        summary: "Kualitas udara pada tingkat ini dapat mempengaruhi kesehatan"
            " kelompok sensitif, sementara orang sehat biasanya tidak"
            " terpengaruh. Aktivitas luar ruangan perlu dikurangi oleh kelompok"
            " sensitif.",
        immediateImpact: RichText(
          text: const TextSpan(
            text: 'Anggota ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'kelompok sensitif ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text:
                    'seperti penderita penyakit paru-paru, anak-anak, dan orang tua mungkin ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'mengalami efek kesehatan. ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text: 'Orang sehat biasanya tidak terpengaruh. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'Stay safe, ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text: 'VoltMates! ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        longTermImpact: RichText(
          text: const TextSpan(
            text: 'Paparan jangka panjang pada tingkat ini ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'bisa memperburuk kondisi kesehatan ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text: 'bagi kelompok sensitif, seperti memperburuk ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'asma atau penyakit paru-paru lainnya. ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
            ],
          ),
        ),
        healthTips: RichText(
          text: const TextSpan(
            text: 'Kelompok sensitif ',
            style: TextStyle(
              color: AppPallete.dangerAir,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'harus mengurangi aktivitas luar ruangan yang ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'berat dan menghabiskan lebih banyak waktu ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text: 'di dalam ruangan.',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        activityRecommendations: RichText(
          text: const TextSpan(
            text: 'Orang sehat ',
            style: TextStyle(
              color: AppPallete.dangerAir,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'masih dapat beraktivitas ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'di luar ruangan ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text: 'namun dengan. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'kewaspadaan ',
                style: TextStyle(
                  color: AppPallete.dangerAir,
                ),
              ),
              TextSpan(
                text: 'terutama jika sudah merasa tidak nyaman.. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    3: AirQualityInfo(
      color: AppPallete.veryDangerAir,
      description: "Sangat Tidak Sehat",
      backgroundColor: AppPallete.voltAirVeryDangerBg,
      healthImpact: HealthImpact(
        summary: "Kualitas udara buruk dan dapat mempengaruhi kesehatan semua"
            " orang, terutama kelompok sensitif. Disarankan untuk mengurangi"
            " aktivitas luar ruangan dan lebih banyak berada di dalam ruangan.",
        immediateImpact: RichText(
          text: const TextSpan(
            text: 'Peringatan kesehatan serius! ',
            style: TextStyle(
              color: AppPallete.veryDangerAir,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'Semua orang ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'lebih mungkin ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir,
                ),
              ),
              TextSpan(
                text: 'mengalami dampak kesehatan yang signifikan ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: ' seperti masalah pernapasan berat. STAY SAFE, ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir,
                ),
              ),
              TextSpan(
                text: 'VOLTMATES!',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        longTermImpact: RichText(
          text: const TextSpan(
            text: 'Paparan jangka panjang dapat menyebabkan penyakit ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text:
                    'paru-paru kronis, masalah kardiovaskular, dan memperburuk'
                    ' kondisi kesehatan yang ada. ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir,
                ),
              ),
            ],
          ),
        ),
        healthTips: RichText(
          text: const TextSpan(
            text: 'Tetap di ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'dalam ruangan dan minimalkan paparan polusi udara. '
                    ' Gunakan masker ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir,
                ),
              ),
              TextSpan(
                text:
                    'jika harus keluar dan pastikan lingkungan dalam ruangan memiliki ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'udara yang bersih. ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir,
                ),
              ),
            ],
          ),
        ),
        activityRecommendations: RichText(
          text: const TextSpan(
            text: 'Batasi semua ',
            style: TextStyle(
              color: AppPallete.veryDangerAir,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text:
                    'aktivitas luar ruangan. Aktivitas di dalam ruangan dengan ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'kualitas udara terkontrol ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir,
                ),
              ),
              TextSpan(
                text: 'lebih disarankan. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    4: AirQualityInfo(
      color: AppPallete.veryDangerAir2,
      description: "Berbahaya",
      backgroundColor: AppPallete.voltAirVeryDanger2,
      healthImpact: HealthImpact(
        summary: "Kualitas udara buruk dan dapat mempengaruhi kesehatan semua"
            " orang, terutama kelompok sensitif. Disarankan untuk mengurangi"
            " aktivitas luar ruangan dan lebih banyak berada di dalam ruangan.",
        immediateImpact: RichText(
          text: const TextSpan(
            text: 'Peringatan kesehatan serius! ',
            style: TextStyle(
              color: AppPallete.veryDangerAir2,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'Semua orang ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'lebih mungkin ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir2,
                ),
              ),
              TextSpan(
                text: 'mengalami dampak kesehatan yang signifikan ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: ' seperti masalah pernapasan berat. STAY SAFE, ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir2,
                ),
              ),
              TextSpan(
                text: 'VOLTMATES!',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        longTermImpact: RichText(
          text: const TextSpan(
            text: 'Paparan jangka panjang dapat menyebabkan penyakit ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text:
                    'paru-paru kronis, masalah kardiovaskular, dan memperburuk'
                    ' kondisi kesehatan yang ada. ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir2,
                ),
              ),
            ],
          ),
        ),
        healthTips: RichText(
          text: const TextSpan(
            text: 'Tetap di ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'dalam ruangan dan minimalkan paparan polusi udara. '
                    ' Gunakan masker ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir2,
                ),
              ),
              TextSpan(
                text:
                    'jika harus keluar dan pastikan lingkungan dalam ruangan memiliki ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'udara yang bersih. ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir2,
                ),
              ),
            ],
          ),
        ),
        activityRecommendations: RichText(
          text: const TextSpan(
            text: 'Batasi semua ',
            style: TextStyle(
              color: AppPallete.veryDangerAir2,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text:
                    'aktivitas luar ruangan. Aktivitas di dalam ruangan dengan ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'kualitas udara terkontrol ',
                style: TextStyle(
                  color: AppPallete.veryDangerAir2,
                ),
              ),
              TextSpan(
                text: 'lebih disarankan. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    5: AirQualityInfo(
      color: AppPallete.deathAir,
      description: "Mematikan",
      backgroundColor: AppPallete.voltAirDeathAir,
      healthImpact: HealthImpact(
        summary: "Kualitas udara sangat berbahaya dan menimbulkan risiko"
            " kesehatan yang serius bagi semua orang. Disarankan"
            " untuk tetap di dalam ruangan dan menghindari semua"
            " aktivitas luar ruangan.",
        immediateImpact: RichText(
          text: const TextSpan(
            text: 'Peringatan kesehatan darurat! ',
            style: TextStyle(
              color: AppPallete.deathAir,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text:
                    'Seluruh kelompok masyarakat lebih cenderung terpengaruh oleh ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'polusi udara yang sangat tinggi. Tetap tenang dan stay'
                    ' safe, ',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
              TextSpan(
                text: 'VoltMates! ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
            ],
          ),
        ),
        longTermImpact: RichText(
          text: const TextSpan(
            text: 'Paparan jangka panjang dapat menyebabkan ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'penyakit serius ',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
              TextSpan(
                text: 'dan berpotensi fatal seperti ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'kanker paru-paru dan penyakit jantung. ',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
            ],
          ),
        ),
        healthTips: RichText(
          text: const TextSpan(
            text: 'Tetap di dalam ruangan ',
            style: TextStyle(
              color: AppPallete.deathAir,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'dan hindari semua paparan luar ruangan. ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'Gunakan masker dengan filtrasi tinggi ',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
              TextSpan(
                text: 'jika harus keluar. Pastikan udara dalam ruangan ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'bersih dan terkontrol. ',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
            ],
          ),
        ),
        activityRecommendations: RichText(
          text: const TextSpan(
            text: 'Semua aktivitas luar ruangan ',
            style: TextStyle(
              color: AppPallete.blackGrayColor,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'harus dihindari! ',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
              TextSpan(
                text: 'Pastikan lingkungan dalam ruangan memiliki udara ',
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                ),
              ),
              TextSpan(
                text: 'bersih dan terkontrol dengan baik.',
                style: TextStyle(
                  color: AppPallete.deathAir,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  };

  int index = (aqi / 50).ceil() - 1;
  index = index.clamp(0, aqiMap.length - 1);

  return aqiMap[index]!;
}
