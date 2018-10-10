#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on 2017-8-26
@author: kevin

'''

from lxml import etree
import os
from PIL import Image
from PIL import ImageDraw
from PIL import ImageFilter
import matplotlib.pyplot as plt

def readxml(xmldir):
    html = etree.parse(xmldir)
    # 显示xml
    # result = etree.tostring(html)
    # print(result)
    # xpath过滤xml
    anno_name = html.xpath('//object/name')
    anno_xmin = html.xpath('//object//bndbox/xmin')
    anno_ymin = html.xpath('//object//bndbox/ymin')
    anno_xmax = html.xpath('//object//bndbox/xmax')
    anno_ymax = html.xpath('//object//bndbox/ymax')
    name = [x.text for x in anno_name]
    xmin = [int(x.text) for x in anno_xmin]
    ymin = [int(x.text) for x in anno_ymin]
    xmax = [int(x.text) for x in anno_xmax]
    ymax = [int(x.text) for x in anno_ymax]
    return name, xmin, ymin, xmax, ymax


def cropimg(imgpath, imgname, cropname, xmin, ymin, xmax, ymax):
    # 查找cropname中的重复元素
    # setcropname = list(set(cropname))
    # for itemset in setcropname:
    # 	if cropname.count(itemset) > 1:
    # 		# itemset 有多个
    im = Image.open(imgpath)
    i = 0
    j = 0
    cropnamelist = []
    for itemname in cropname:
        cropbox = (xmin[i], ymin[i], xmax[i], ymax[i])
        region = im.crop(cropbox)
        basepath = '../data/JPEGImages/'
        addpath = basepath + itemname
        if not os.path.exists(addpath):
            os.makedirs(addpath)
        if cropname in cropnamelist:
            # 有重复命名
            j += 1
            fullpath = os.path.join(addpath, imgname + '_' + str(j) + '.jpg')
        else:
            fullpath = os.path.join(addpath, imgname + '_0' + '.jpg')
        cropnamelist.append(cropname)
        region.save(fullpath)
        i += 1

def perpicshow(imgpath, imgname, Anno_name, Anno_xmin, Anno_ymin, Anno_xmax, Anno_ymax):
    im = Image.open(imgpath).convert('RGBA')
    draw = ImageDraw.Draw(im)
    draw.rectangle((int(Anno_xmin), int(Anno_ymin), int(Anno_xmax), int(Anno_ymax)), fill=(255,0,0,128), outline=None)
    # box = (int(Anno_xmin), int(Anno_ymin), int(Anno_xmax), int(Anno_ymax))
    # im_crop = im.crop(box)
    # im_crop = im_crop.filter(ImageFilter.BLUR)
    # r,g,b,a = im_crop.split()
    # im.paste(im_crop,box)
       # draw.rectangle([Anno_xmin, Anno_ymin, Anno_xmax, Anno_ymax], fill=(255,0,0,128), outline=None)
    plt.figure(Anno_name)
    plt.imshow(im)
    # im.save('1.jpg')
    # print(im.mode)
    # im.show()
    return plt

if __name__ == '__main__':
    xmldir = os.path.join('..\data\Annotations',
                          '013659679_K2216046_185_1_11.xml')
    Annoindex = readxml(xmldir)
    imgpath = '../data/JPEGImages/013704524_K2216144_189_1_28.jpg'
    imgname = '013704524_K2216144_189_1_28'
    cropname = ['screw2', 'screw2', 'nut']
    xmin = [75, 207, 80]
    ymin = [4, 11, 149]
    xmax = [145, 274, 202]
    ymax = [49, 60, 217]
    cropimg(imgpath, imgname, cropname, xmin, ymin, xmax, ymax)
