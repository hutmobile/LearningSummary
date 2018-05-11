2018.05.11
package cn.winfirm.examples.base;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnKeyListener;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.Window;

/**
 * Activity的基类，带一个ProgressDialog，可双击取消其显示
 * 
 * @author savant
 * 
 */
public class BaseActivity extends Activity {

    private ProgressDialog progressDialog = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
    }

    /**
     * show loading progress dialog
     */
    public void showDialog() {
        if (null == progressDialog) {
            progressDialog = ProgressDialog.show(BaseActivity.this, "", "正在加载，请稍候...");
            progressDialog.setCancelable(false);
        } else {
            progressDialog.show();
        }
        progressDialog.setOnKeyListener(onKeyListener);
    }

    /**
     * add a keylistener for progress dialog
     */
    private OnKeyListener onKeyListener = new OnKeyListener() {
        @Override
        public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
            if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
                dismissDialog();
            }
            return false;
        }
    };

    /**
     * dismiss dialog
     */
    public void dismissDialog() {
        if (isFinishing()) {
            return;
        }
        if (null != progressDialog && progressDialog.isShowing()) {
            progressDialog.dismiss();
        }
    }

    /**
     * cancel progress dialog if nesseary
     */
    @Override
    public void onBackPressed() {
        if (progressDialog != null && progressDialog.isShowing()) {
            dismissDialog();
        } else {
            super.onBackPressed();
        }
    }
} 
