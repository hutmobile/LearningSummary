#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author: loveNight

import json
import itertools
import urllib
import requests
import os
import re
import sys
from config import *
from multiprocessing import Pool


# 解码图片URL
def decode(url):
    # 先替换字符串
    for key, value in STR_TABLE.items():
        url = url.replace(key, value)
    # 再替换剩下的字符
    return url.translate(CHAR_TABLE)

# 生成网址列表
def buildUrls(word):
    word = urllib.parse.quote(word)
    url = URL
    urls = (url.format(word=word, pn=x) for x in itertools.count(start=0, step=60))
    return urls

# 解析JSON获取图片URL
re_url = re.compile(r'"objURL":"(.*?)"')
def resolveImgUrl(html):
    imgUrls = [decode(x) for x in re_url.findall(html)]
    return imgUrls

def downImg(imgUrl, dirpath, imgName):
    dir_list = dirpath.split(os.path.sep)
    filename = os.path.join(dirpath, dir_list[-1] + imgName)
    try:
        res = requests.get(imgUrl, timeout=15)
        if str(res.status_code)[0] == "4":
            print(str(res.status_code), ":" , imgUrl)
            return False
    except Exception as e:
        print("抛出异常：", imgUrl)
        print(e)
        return False
    with open(filename, "wb") as f:
        f.write(res.content)
    return True

def mkDir(dirName):
    dirpath = os.path.join(sys.path[0], dirName)
    if not os.path.exists(dirpath):
        os.makedirs(dirpath)
    return dirpath

def start(name, dir):
    word = name
    dirpath = mkDir(dir)
    urls = buildUrls(word)
    index = 0
    for url in urls:
        print("正在请求：", url)
        html = requests.get(url, timeout=10).content.decode('utf-8')
        imgUrls = resolveImgUrl(html)
        if len(imgUrls) == 0:  # 没有图片则结束
            break
        for url in imgUrls:
            if downImg(url, dirpath, str(index) + ".jpg"):
                index += 1
                print(name, ": 已下载 %s 张" % index)
                if index == MAX:
                    return


if __name__ == '__main__':
    p = Pool(processes=POOLNUM)
    for name, dir in PIC_TYPES.items():
        print(name, dir)
        p.apply_async(start, (name, dir))
    print('Waiting for all subprocesses done...')
    p.close()
    p.join()
    print('All subprocesses done.')










