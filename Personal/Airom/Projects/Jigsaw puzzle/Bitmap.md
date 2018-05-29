            
            //读入back图片
            InputStream assetInputStream=assetManager.open("back.jpg");
            //创建bitmap对象
            Bitmap bitmap=BitmapFactory.decodeStream(assetInputStream);
            //将图片压缩，不按比例，传入bitmap对象，将其压缩为制定长宽的图片
//            back=Bitmap.createScaledBitmap(bitmap,MainActivity.getScreenWidth(),MainActivity.getScreenWidth(),true);
            //将图片裁剪，传入bitmap对象，从左上角0，0开始，裁剪出一个制定长宽的图片
            back=Bitmap.createBitmap(bitmap,0,0,MainActivity.getScreenWidth(),MainActivity.getScreenWidth());
