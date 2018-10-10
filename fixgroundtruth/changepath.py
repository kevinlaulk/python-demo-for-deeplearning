#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on 2017-8-26
@author: kevin

'''

from lxml import etree
import os
import re


class fileread(object):
    def __init__(self):
        self.datapath = '../data/VOC2007/Annotations/'
        self.scriptpath = ''
        self.output = './output/'
        self.outwidth = 2048
        self.outheight = 2048

    def Annoread(self):
        # 检查Annotations是否存在
        if not os.path.exists(self.datapath):
            print('the Annotations is not exis')
        else:
            self.Annolist = os.listdir(self.datapath)
            print('the amount is :%s' % len(self.Annolist))
            # print(self.Annolist)

    def xmlread(self):
        for itemxml in self.Annolist:
            self.xmldir = os.path.join(self.datapath, itemxml)
            print('opening the xmlfile:%s' % self.xmldir)
            self.html = etree.parse(self.xmldir)
            # 显示xml
            # result = etree.tostring(self.html)
            # print(result)
            # xpath 提取path
            width = self.html.xpath('//width')[0].text
            height = self.html.xpath('//height')[0].text
            xmin = self.html.xpath('//xmin')
            ymin = self.html.xpath('//ymin')
            xmax = self.html.xpath('//xmax')
            ymax = self.html.xpath('//ymax')
            width = int(width)
            height = int(height)
            #print(type(width), height)
            #print(xmin[0].text, xmin[1].text, xmin[2].text, xmin[3].text)
            #print(len(xmin))
            # 计算新的坐标
            ratio_width = self.outwidth / width
            ratio_height = self.outheight / height
            #print(ratio_width, ratio_height)
            if not xmin:
                print('target path is not found')
            else:
                # 修改节点内容
                for i in range(len(xmin)):
                    self.html.xpath('//xmin')[i].text = str(int(int(xmin[i].text) * ratio_width))
                    self.html.xpath('//ymin')[i].text = str(int(int(ymin[i].text) * ratio_height))
                    self.html.xpath('//xmax')[i].text = str(int(int(xmax[i].text) * ratio_width))
                    self.html.xpath('//ymax')[i].text = str(int(int(ymax[i].text) * ratio_height))
                    # print(int(xmin[i].text) * ratio_width)
                # 输出xml
                if not os.path.exists(self.output):
                    print('the output dir is not exis')
                else:
                    outputdir = os.path.join(self.output, itemxml)
                    self.html.write(outputdir)


if __name__ == '__main__':
    file = fileread()
    file.Annoread()
    file.xmlread()
