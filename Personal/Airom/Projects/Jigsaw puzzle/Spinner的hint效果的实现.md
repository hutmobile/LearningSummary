

主要Spinner的适配器，有个getcount的方法，如果我们返回getCount()-1会使得Spinner一直认为自己本来就少一条.利用这个原理，将最后一条写成我们想设的hint，就达到了目的。

package com.airom.jigsaw_puzzle.ModeActivity;

import android.content.Context;
import android.widget.ArrayAdapter;


public class ModeAdapter extends ArrayAdapter{

    //复写这个方法，使返回的数据没有最后一项
    @Override
    public int getCount() {
        // don't display last item. It is used as hint.
        int count = super.getCount();
        return count > 0 ? count - 1 : count;
    }

    public ModeAdapter(Context context, int resource, String[] objects){
        super(context,resource,objects);
    }
}


引用

        modeAdapter = new ModeAdapter(com.airom.jigsaw_puzzle.ModeActivity.ModeActivity.this,android.R.layout.simple_spinner_item,mode);
