import os

POOLNUM = 4

MAX = 100

BASE = 'res'


# BUILDING = os.path.join(BASE, 'building')

# PEOPLE = os.path.join(BASE, 'people')

# SCENERY = os.path.join(BASE, 'scenery')

# FLOWER = os.path.join(BASE, 'flower')

# CAR = os.path.join(BASE, 'car')

# GROUPPHOTO = os.path.join(BASE, 'group-photo')

# WORKPLACE = os.path.join(BASE, 'work-space')

# CLASSROOM = os.path.join(BASE, 'classroom')

# SNOW = os.path.join(BASE, 'snow')

# MANGA = os.path.join(BASE, 'manga')

# ANIMAL = os.path.join(BASE, 'animal')

# THINGS = os.path.join(BASE, 'things')

# TEXT = os.path.join(BASE, 'text')

# SELF_SNAPSHOT = os.path.join(BASE, 'self-snapshot')

URL = r"http://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&ct=201326592&fp=result&queryWord={word}&" \
      r"cl=2&lm=-1&ie=utf-8&oe=utf-8&st=-1&ic=0&word={word}&face=0&istype=2nc=1&pn={pn}&rn=60"

# PIC_TYPES = {
#     '建筑': BUILDING,
#     '人脸': PEOPLE,
#     '风景': SCENERY,
#     '花': FLOWER,
#     '汽车图片': CAR,
#     '合影': GROUPPHOTO,
#     '办公室': WORKPLACE,
#     '教室': CLASSROOM,
#     '雪景': SNOW,
#     '动漫': MANGA,
#     '动物': ANIMAL,
#     '小物品': THINGS,
#     '文本 文字': TEXT,
#     '自拍': SELF_SNAPSHOT
#     }
MAN = os.path.join(BASE, 'man')
WOMAN_ALL = os.path.join(BASE, 'woman-all')
MAN_ALL = os.path.join(BASE, 'man_all')
PEN_TEXT = os.path.join(BASE, 'pen')
SOFT_TEXT = os.path.join(BASE, 'soft')
PHONE_COM = os.path.join(BASE, 'phone')
BUILDING = os.path.join(BASE, 'building')
PEOPLE = os.path.join(BASE, 'people')
SCENERY = os.path.join(BASE, 'scenery')
FLOWER = os.path.join(BASE, 'flower')
CAR = os.path.join(BASE, 'car')
GROUPPHOTO = os.path.join(BASE, 'group-photo')
WORKPLACE = os.path.join(BASE, 'work-space')
Office = os.path.join(BASE, 'office')
CLASSROOM = os.path.join(BASE, 'classroom')
SNOW = os.path.join(BASE, 'snow')
MANGA = os.path.join(BASE, 'manga')
ANIMAL = os.path.join(BASE, 'animal')
THINGS = os.path.join(BASE, 'things')
TEXT = os.path.join(BASE, 'text')
SELF_SNAPSHOT = os.path.join(BASE, 'self_snapshot')
FOOD = os.path.join(BASE, 'food')
Eatables = os.path.join(BASE, 'eatables')
Emoticon = os.path.join(BASE, 'emoticon')
Cartoon = os.path.join(BASE, 'cartoon')
Night_Scene = os.path.join(BASE, 'night_scene')
PIC_TYPES = {
'男人 自拍': MAN,
'全身照片 女': WOMAN_ALL,
'全身照片 男': MAN_ALL,
'硬笔书法': PEN_TEXT,
'书法': SOFT_TEXT,
'手机 电脑':PHONE_COM,
'建筑': BUILDING,
'人脸': PEOPLE,
'风景': SCENERY
'花': FLOWER,
'汽车图片': CAR,
'合影': GROUPPHOTO,
'办公室': WORKPLACE,
'教室': CLASSROOM,
'雪景': SNOW,
'动漫': MANGA,
'动物': ANIMAL,
'小物品': THINGS,
'文本 文字': TEXT,
'自拍': SELF_SNAPSHOT
'表情包': Emoticon,
'卡通': Cartoon,
'夜景': Night_Scene,
'食物': FOOD
'办公室': Office
}

STR_TABLE = {
    '_z2C$q': ':',
    '_z&e3B': '.',
    'AzdH3F': '/'
}

char_table = {
    'w': 'a',
    'k': 'b',
    'v': 'c',
    '1': 'd',
    'j': 'e',
    'u': 'f',
    '2': 'g',
    'i': 'h',
    't': 'i',
    '3': 'j',
    'h': 'k',
    's': 'l',
    '4': 'm',
    'g': 'n',
    '5': 'o',
    'r': 'p',
    'q': 'q',
    '6': 'r',
    'f': 's',
    'p': 't',
    '7': 'u',
    'e': 'v',
    'o': 'w',
    '8': '1',
    'd': '2',
    'n': '3',
    '9': '4',
    'c': '5',
    'm': '6',
    '0': '7',
    'b': '8',
    'l': '9',
    'a': '0'
}

CHAR_TABLE = {ord(key): ord(value) for key, value in char_table.items()}


# deal pics

SIZE = (299, 299)
