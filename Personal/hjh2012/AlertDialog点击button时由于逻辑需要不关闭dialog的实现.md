2018.05.11
需要学习的的部分：java反射
//保持dialog不关闭的方法
    private void keepDialogOpen(AlertDialog dialog) {
        try {
            java.lang.reflect.Field field = dialog.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);
            field.set(dialog, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //关闭dialog的方法
    private void closeDialog(AlertDialog dialog) {
        try {
            java.lang.reflect.Field field = dialog.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);
            field.set(dialog, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    程序调用
private void saveFavoriteDialog()
{
    LayoutInflater inflater = LayoutInflater.from(getActivity()); 
    final View view = inflater.inflate(R.layout.favorite_add_dialog, null);  

    dialog = new AlertDialog.Builder(getActivity())  
    .setTitle(R.string.create_favorite)  
    .setIcon(android.R.drawable.ic_menu_save) 
    .setView(view)
    .setPositiveButton(R.string.chose_photo,new DialogInterface.OnClickListener()
    {

        @Override
        public void onClick(DialogInterface dialog, int which)
        {

            favoriteName = (EditText) view.findViewById(R.id.favorite_name_tv);
            String name = favoriteName.getText().toString().trim();
            if(name.length() == 0)
            {
                //条件不符合时点击按钮不消失对话框,提示用户输入必要内容
                keepDialogOpen((AlertDialog) dialog);
                Toast.makeText(getActivity(), R.string.please_enter_favorite_name, Toast.LENGTH_SHORT).show();
            }
            else
            {
                //手动调用dismiss(),先取消对话框，这一步必须调用
                dialog.dismiss();
                Intent intent = new Intent(getActivity(), ChooseFavorite.class);
                intent.putExtra(ChooseFavorite.KEY_FAVORITE_NAME, name);
                startActivityForResult(intent, 0);
            }

        }
    })
    .setNegativeButton(android.R.string.cancel, new DialogInterface.OnClickListener()
    {

        @Override
        public void onClick(DialogInterface dialog, int which)
        {
            closeDialog((AlertDialog) dialog);
        }
    })
    .show();
}
