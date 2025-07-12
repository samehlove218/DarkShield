#!/bin/bash
# مسار المشروع
ROOT=~/DroidRemoteX_Java
# إنشاء هيكل المجلدات
mkdir -p \$ROOT/Client/app/src/main/{java/com/bekhet/client,res/layout,res/values,res/mipmap}
mkdir -p \$ROOT/Controller/app/src/main/{java/com/bekhet/controller,res/layout,res/values,res/mipmap}

# إعداد settings.gradle
cat << SGRADLE > \$ROOT/settings.gradle
rootProject.name = "DroidRemoteX"
include ':Client:app', ':Controller:app'
SGRADLE

# إعداد build.gradle (root)
cat << RGRADLE > \$ROOT/build.gradle
buildscript {
    repositories { google(); mavenCentral() }
    dependencies { classpath 'com.android.tools.build:gradle:4.0.1' }
}
allprojects {
    repositories { google(); mavenCentral() }
}
RGRADLE

### === Module: Client ===
# MainActivity.java
cat << CLIENTJAVA > \$ROOT/Client/app/src/main/java/com/bekhet/client/MainActivity.java
package com.bekhet.client;
import android.app.Activity;
import android.os.Bundle;
public class MainActivity extends Activity {
    @Override protected void onCreate(Bundle s) {
        super.onCreate(s);
        setContentView(R.layout.activity_main);
    }
}
CLIENTJAVA

# AndroidManifest.xml
cat << CLIENTMANI > \$ROOT/Client/app/src/main/AndroidManifest.xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.bekhet.client">
    <application android:label="Client" android:icon="@mipmap/ic_launcher">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
CLIENTMANI

# Layout
cat << CLIENTLAYOUT > \$ROOT/Client/app/src/main/res/layout/activity_main.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical" android:layout_width="match_parent"
    android:layout_height="match_parent">
    <TextView android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello from Client!" />
</LinearLayout>
CLIENTLAYOUT

# Strings
cat << CLIENTSTR > \$ROOT/Client/app/src/main/res/values/strings.xml
<resources>
    <string name="app_name">DroidRemoteXClient</string>
</resources>
CLIENTSTR

# Icon
wget -q -O \$ROOT/Client/app/src/main/res/mipmap/ic_launcher.png https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/512px-React-icon.svg.png

# Module build.gradle
cat << CLIENTGRADLE > \$ROOT/Client/app/build.gradle
apply plugin: 'com.android.application'
android {
    compileSdkVersion 33
    defaultConfig {
        applicationId "com.bekhet.client"
        minSdkVersion 21; targetSdkVersion 33
        versionCode 1; versionName "1.0"
    }
    buildTypes { release { minifyEnabled false } }
    compileOptions { sourceCompatibility JavaVersion.VERSION_1_8; targetCompatibility JavaVersion.VERSION_1_8 }
}
repositories { google(); mavenCentral() }
dependencies {}
CLIENTGRADLE

### === Module: Controller ===
# MainActivity.java
cat << CTRLJAVA > \$ROOT/Controller/app/src/main/java/com/bekhet/controller/MainActivity.java
package com.bekhet.controller;
import android.app.Activity;
import android.os.Bundle;
public class MainActivity extends Activity {
    @Override protected void onCreate(Bundle s) {
        super.onCreate(s);
        setContentView(R.layout.activity_main);
    }
}
CTRLJAVA

# AndroidManifest.xml
cat << CTRLMANI > \$ROOT/Controller/app/src/main/AndroidManifest.xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.bekhet.controller">
    <application android:label="Controller" android:icon="@mipmap/ic_launcher">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
CTRLMANI

# Layout
cat << CTRLLAYOUT > \$ROOT/Controller/app/src/main/res/layout/activity_main.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical" android:layout_width="match_parent"
    android:layout_height="match_parent">
    <TextView android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello from Controller!" />
</LinearLayout>
CTRLLAYOUT

# Strings
cat << CTRLSTR > \$ROOT/Controller/app/src/main/res/values/strings.xml
<resources>
    <string name="app_name">DroidRemoteXController</string>
</resources>
CTRLSTR

# Icon
wget -q -O \$ROOT/Controller/app/src/main/res/mipmap/ic_launcher.png https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/512px-React-icon.svg.png

# Module build.gradle
cat << CTRLGRADLE > \$ROOT/Controller/app/build.gradle
apply plugin: 'com.android.application'
android {
    compileSdkVersion 33
    defaultConfig {
        applicationId "com.bekhet.controller"
        minSdkVersion 21; targetSdkVersion 33
        versionCode 1; versionName "1.0"
    }
    buildTypes { release { minifyEnabled false } }
    compileOptions { sourceCompatibility JavaVersion.VERSION_1_8; targetCompatibility JavaVersion.VERSION_1_8 }
}
repositories { google(); mavenCentral() }
dependencies {}
CTRLGRADLE

chmod +x ~/setup_full_project.sh
echo "[✅] Full project scaffold created at \$ROOT"
