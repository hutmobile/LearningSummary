


private void initListener() {

        imgSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            /*
            表示当spinner控件中item被选中时回调的方法
            AdapterView<?> parent, 表示当前出发时间的适配器控件对象spinner
            View view, 表示当前被选中的item的对象
            int position, 表示当前被选中的item的下标位置
            long id, 表示当前被选中的item的id
             */

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                try {
                    //以下三行代码是解决问题所在
                    Field field = AdapterView.class.getDeclaredField("mOldSelectedPosition");
                    field.setAccessible(true);  //设置mOldSelectedPosition可访问
                    field.setInt(imgSpinner, AdapterView.INVALID_POSITION); //设置mOldSelectedPosition的值
                } catch(Exception e){
                    e.printStackTrace();
                }


            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        modeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {


            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                try {
                    //以下三行代码是解决问题所在
                    Field field = AdapterView.class.getDeclaredField("mOldSelectedPosition");
                    field.setAccessible(true);  //设置mOldSelectedPosition可访问
                    field.setInt(modeSpinner, AdapterView.INVALID_POSITION); //设置mOldSelectedPosition的值
                } catch(Exception e){
                    e.printStackTrace();
                }


            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

    }


在field.setInt(modeSpinner, AdapterView.INVALID_POSITION); 里面填上相应的spinner


参考
https://blog.csdn.net/yiming_8988/article/details/51512153
https://blog.csdn.net/u012077817/article/details/50311865
