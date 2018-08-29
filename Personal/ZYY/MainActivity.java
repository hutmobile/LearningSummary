package com.game1;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends Activity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_psd);

        Button btn = (Button)findViewById(R.id.button_login);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String id = ((EditText) findViewById(R.id.text_id)).getText().toString();
                String psd = ((EditText)findViewById(R.id.text_psd)).getText().toString();
                Toast.makeText(MainActivity.this,id+psd,Toast.LENGTH_SHORT).show();
            }
        });
    }
}

