import 'dart:io';

import 'package:yaml_magic/yaml_magic.dart';

// 初始化模板
void main(List<String> args) async {
  // 读取 YAML 文件
  final yamlMap = YamlMagic.load('./pubspec.yaml');

  String getProperty(String key, String defaultValue) {
    final value = yamlMap[key]?.toString() ?? defaultValue;
    if (value.isEmpty) {
      return defaultValue;
    }
    return value;
  }

  // 获取信息
  final name = getProperty("name", "flutter_template");
  final description = getProperty("description", "A new Flutter project.");
  final organization = getProperty("organization", "com.example");
  final version = getProperty("version", "1.0.0+1");
  final platform = getProperty("platform", "ios,android,windows,linux,macos,web");

  if (args.isEmpty) {
    await updateActionYaml(platform);
  }

  // 排除已经存在的目录
  final platforms = platform.split(',').where((val) => !directoryExists(val));

  if (platforms.isNotEmpty) {
    // 执行命令
    // 定义要传递的参数
    final arguments = [
      'create',
      '.',
      '--project-name=$name',
      '--description=$description',
      '--org=$organization',
      '--template=app',
      '--ios-language=swift',
      '--android-language=kotlin',
      '--platforms=${platforms.join(',')}',
    ];

    print('flutter ${arguments.join(' ')}');

    // 执行 flutter create 命令
    final process = await Process.start('flutter', arguments);

    // 输出命令行结果
    process.stdout.transform(const SystemEncoding().decoder).listen((data) {
      print(data);
    });

    process.stderr.transform(const SystemEncoding().decoder).listen((data) {
      print('Error: $data');
    });

    // 等待命令完成
    final exitCode = await process.exitCode;

    // 修改工作流，为了适应platforms
  }

  // 修改android gradle文件
  const androidGradlePath = 'android/app/build.gradle';
  final gradle = await isFileExists(androidGradlePath);
  if (gradle) {
    final gradleContent = getAndroidGradle(name, organization);

    File file = File(androidGradlePath);
    await file.writeAsString(gradleContent, mode: FileMode.write);
  }

  print('初始化成功！');
}

// 判断文件夹是否存在
bool directoryExists(String directoryPath) {
  final directory = Directory(directoryPath);
  return directory.existsSync();
}

Future<bool> isFileExists(String filePath) async {
  File file = File(filePath);
  return await file.exists();
}

// 修改action.yaml
Future<void> updateActionYaml(String platform) async {
  const filePath = '.github/workflows/action.yml';

  final file = File(filePath);
  var content = await file.readAsString();

  RegExp regExp = RegExp(r'type:\s*\[.*?\]');

  content = content.replaceFirstMapped(regExp, (match) {
    return 'type: [ ${platform.replaceAll(',', ', ')} ]';
  });

  await file.writeAsString(content);
}

String getAndroidGradle(String name, String organization) {
  return '''plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

// 从pubspec.yaml解析出版本号
def parseVersion() {
    def pubspec = new File("../pubspec.yaml")
    def lines = pubspec.readLines()
    def versionLine = lines.find { it.startsWith("version:") }
    def version = versionLine.split(" ")[1].trim()

    def versionParts = version.split("\\\\+")
    def versionName = versionParts[0]
    def versionCode = versionParts.length > 1 ? versionParts[1].toInteger() : null

    return [versionName, versionCode]
}

def (flutterVersionName, flutterVersionCode) = parseVersion()

android {
    namespace = "$organization.$name"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    // 分开打包
    splits {
        abi {
            enable true
            reset()
            include  'arm64-v8a', 'armeabi-v7a' // , 'x86', 'x86_64', 'armeabi', 'mips', 'mips64'
            universalApk true
        }
    }

    defaultConfig {
        applicationId = "$organization.$name"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode
        versionName = flutterVersionName

        resConfigs "zh"

//        ndk {
//            abiFilters "arm64-v8a"
//        }
    }

    signingConfigs {
        debug {

        }
        release {
            // 读取环境变量
            def keystoreBase64 = System.getenv("KEYSTORE_BASE64")
            if (keystoreBase64 != null) {
                // 创建临时文件
                def keystoreFile = File.createTempFile("keystore", ".jks")
                // 将 base64 解码并写入文件
                keystoreFile.bytes = keystoreBase64.decodeBase64()

                // 都从环境变量获取值，也可以改成通过文件获取
                keyAlias System.getenv("KEYSTORE_KEY_ALIAS")
                keyPassword System.getenv("KEYSTORE_KEY_PASSWORD")
                storeFile keystoreFile
                storePassword System.getenv("KEYSTORE_PASSWORD")

                // 在构建结束后删除临时文件
                gradle.buildFinished {
                    keystoreFile.delete()
                }
            } else {
                throw new Exception("Environment variable KEYSTORE_BASE64 is not set")
            }
        }
    }

    buildTypes {
        debug {
            minifyEnabled false
            shrinkResources false
        }

        release {
            // 签名配置
            signingConfig signingConfigs.release
            // 移除没用的代码
            shrinkResources true
            // 压缩代码
            minifyEnabled true

            proguardFiles getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
        }
    }
}

flutter {
    source = "../.."
}''';
}
