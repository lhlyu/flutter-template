#!/bin/bash

# 生成安卓秘钥

## 秘钥信息
# 别名
alias_name="app"
# 秘钥长度
keysize="2048"
# 有效期（天）
validity="3650"
# 生成的文件名字，我们最终需要的是base64，所以这里设置的是临时文件
keystore_filename="./tmp.jks"

## 填写信息
# 密钥库口令（长度不少于6）
password="123456"
# 您的名字与姓氏是什么
name="Lhlyu"
# 您的组织单位名称是什么
org="Lhlyu"
# 您的组织名称是什么
org_name="Lhlyu"
# 您所在的城市或区域名称是什么
city="Shenzhen"
# 您所在的省/市/自治区名称是什么
province="Guangdong"
# 该单位的双字母国家/地区代码是什么
country="CN"


rm -f $keystore_filename

# 生成秘钥对，通过重定向和管道自动化输入密码和其他答案
echo -e "$name\n$org\n$org_name\n$city\n$province\n$country\ny\n" | keytool -genkeypair -alias "$alias_name" -keyalg RSA -keysize "$keysize" \
        -validity "$validity" -keystore "$keystore_filename" \
        -storepass "$password" -keypass "$password"
##### base64在mac/linux上可行
##### windows需要改造成 certutil 命令，建议直接使用git bash
jks=$(base64 -i $keystore_filename)

echo "KEYSTORE_KEY_ALIAS=$alias_name\nKEYSTORE_KEY_PASSWORD=$password\nKEYSTORE_BASE64=$jks\nKEYSTORE_PASSWORD=$password" > ./.env.local

rm -f $keystore_filename