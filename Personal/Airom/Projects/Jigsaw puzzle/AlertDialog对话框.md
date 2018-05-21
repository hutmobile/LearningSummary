

类似RadioButton的AlertDialog
final String[] pattern = new String[] {"3*3", "4*4", "5*5", "6*6" };
        AlertDialog.Builder dialog = new AlertDialog.Builder(MainActivity.this);
        dialog.setTitle("选择难度");
        dialog.setIcon(R.drawable.ic_launcher)  
//        dialog.setMessage("听说你很厉害？");//setMessage不能与下面的setSingleChoiceItems同时显示
        dialog.setCancelable(true);
        dialog.setSingleChoiceItems(pattern, 0, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Toast.makeText(MainActivity.this,pattern[which],Toast.LENGTH_SHORT).show();
//                dialog.dismiss();
//五秒钟后自动关闭。 
                  Handler hander = new Handler();  
                  Runnable runnable = new Runnable()  
                  {  
   
                     @Override  
                     public void run()  
                     {  
                         ad.dismiss();  
                     }  
                  };  
                  hander.postDelayed(runnable, 5 * 1000);  //五秒钟后自动关闭。 
              }  

            }
        });
        
类似ListView的AlertDialog
        dialog.setSingleChoiceItems(arrayFruit, 0, new DialogInterface.OnClickListener() {   
    
                    @Override   
                    public void onClick(DialogInterface dialog, int which) {   
                        selectedFruitIndex = which;   
                    }   
                });
                
类似CheckBox的AlertDialog

      dialog.setMultiChoiceItems(arrayFruit, arrayFruitSelected, new DialogInterface.OnMultiChoiceClickListener() {   
                       
                    @Override   
                    public void onClick(DialogInterface dialog, int which, boolean isChecked) {   
                        arrayFruitSelected[which] = isChecked;   
                    }   
                });
                
                
自定义View的AlertDialog
    LayoutInflater layoutInflater = LayoutInflater.from(this);   
        View myLoginView = layoutInflater.inflate(R.layout.login, null); 
        
        dialog.setView(myLoginView);//myLoginView是自己定义的布局
        
        
        
        
        
        
        https://blog.csdn.net/flyfight88/article/details/8602162
