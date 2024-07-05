# flutter_template

A new Flutter project.

## 如何将本项目改造成自己的项目

#### 1. 将项目克隆到本地

```shell
git clone git@github.com:lhlyu/flutter_template.git [自定义名字]
```

#### 2. 制作android的秘钥

如果不开发android这一步直接跳过

1. 生成秘钥

- 本项目已经提供了生成秘钥的脚本，在 [genkey.sh](genkey.sh) ，打开文件，按照自己的要求进行修改
- 保证系统安装了**keytool**工具
- 执行脚本（windows建议使用Git Bash）`sh genkey.sh`
- 生成后的信息放在 [.env.local](.env.local)


2. 配置环境变量

如果你怕这些变量暴露，可以自己找地方保存，我这里是开源项目，所以直接展示在 [.env.local](.env.local)

本地使用时，需要配置下面的环境变量

github action打包需要在仓库 `Settings -> Secrets and variables -> Actions` 配置 `secrets`

| 名字                    | 值            | 说明                           |
|-----------------------|--------------|------------------------------|
| KEYSTORE_BASE64       | `sdafdsf...` | 秘钥内容，base64格式                |
| KEYSTORE_PASSWORD     | 123456       | 就是上面输入的秘钥口令                  |
| KEYSTORE_KEY_ALIAS    | app          | 上面生成秘钥的别名                    |
| KEYSTORE_KEY_PASSWORD | 123456       | 安卓要求跟 `KEYSTORE_PASSWORD` 一样 |

#### 3. 初始化项目

- 打开 [pubspec.yaml](pubspec.yaml) 文件，按照自己的要求修改项目的名字、描述、组织、需要构建的平台（支持ios,android,windows,linux,macos,web，如果是空字符串，则构建所有平台)

- 执行脚本

```shell
dart scripts/init.dart
```
