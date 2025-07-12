package com.example.darkshield;
import android.content.pm.*;
import android.net.*;
import android.os.*;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import java.io.*;
import java.util.*;
public class MainActivity extends AppCompatActivity {
  private TextView tvResult;
  private StringBuilder log = new StringBuilder();
  @Override protected void onCreate(Bundle s) {
    super.onCreate(s);
    setContentView(R.layout.activity_main);
    tvResult = findViewById(R.id.tvResult);
    findViewById(R.id.btnScanApps).setOnClickListener(v -> scanApps());
    findViewById(R.id.btnScanNetwork).setOnClickListener(v -> scanNetwork());
    findViewById(R.id.btnScanFiles).setOnClickListener(v -> scanHidden());
    findViewById(R.id.btnExport).setOnClickListener(v -> exportLog());
  }
  void scanApps() {
    String[] risky = { "rat","stealer","logger","spy" };
    List<PackageInfo> pkgs = getPackageManager().getInstalledPackages(0);
    StringBuilder r = new StringBuilder("\n📦 التطبيقات:\n\n");
    for (PackageInfo p: pkgs) {
      if ((p.applicationInfo.flags & ApplicationInfo.FLAG_SYSTEM)==0) {
        String n = p.packageName.toLowerCase();
        boolean s=false; for (String k:risky) if(n.contains(k)) s=true;
        r.append(s?"⚠ مشبوه: ":"✔ عادي: ").append(p.packageName).append("\n");
      }
    }
    tvResult.setText(r); log.append(r).append("\n");
  }
  void scanNetwork() {
    ConnectivityManager cm=(ConnectivityManager)getSystemService(CONNECTIVITY_SERVICE);
    NetworkInfo net=cm.getActiveNetworkInfo();
    String s=(net!=null&&net.isConnected())?"🔌 الشبكة: متصل - "+net.getTypeName():"🚫 لا يوجد اتصال";
    tvResult.setText(s); log.append(s).append("\n");
  }
  void scanHidden() {
    File[] f=new File("/sdcard").listFiles();
    StringBuilder r = new StringBuilder("\n🗂 الملفات المخفية:\n\n");
    for (File x:f) if(x.getName().startsWith(".")) r.append(x.getAbsolutePath()).append("\n");
    if (r.toString().equals("\n🗂 الملفات المخفية:\n\n")) r.append("✔ لا شيء مشبوه\n");
    tvResult.setText(r); log.append(r).append("\n");
  }
  void exportLog() {
    try {
      File out=new File(getExternalFilesDir(null),"darkshield_log.txt");
      try(FileOutputStream fos=new FileOutputStream(out)){ fos.write(log.toString().getBytes()); }
      tvResult.setText("✅ تم حفظ التقرير:\n"+out.getAbsolutePath());
    } catch(Exception e) {
      tvResult.setText("⚠ خطأ في التصدير: "+e.getMessage());
    }
  }
}
