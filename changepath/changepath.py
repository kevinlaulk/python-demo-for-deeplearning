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
        self.datapath = './data/'
        self.scriptpath = ''
        self.output = './output/'

    def Annoread(self):
        # 检查Annotations是否存在
        if not os.path.exists(self.datapath):
            print('the Annotations is not exis')
        else:
            self.Annolist = os.listdir(self.datapath)
            print('the amount is :%s' % len(self.Annolist))
            print(self.Annolist)

    def xmlread(self):
        for itemxml in self.Annolist:
            self.xmldir = os.path.join(self.datapath, itemxml)
            print('opening the xmlfile:%s' % self.xmldir)
            self.html = etree.parse(self.xmldir)
            # 显示xml
            # result = etree.tostring(self.html)
            # print(result)
            # xpath 提取path
            filepath = self.html.xpath('//path')
            print(filepath[0].text)
            # 正则表达式提取子路径
            pattern = re.compile(
                r'\\([\d|\w|_]*)\\([\d|\w|_]*)\\([\d|\w|_]*.jpg)$')
            items = re.findall(pattern, filepath[0].text)
            if not items:
                print('xml path is not found')
            else:
                # print(items[0][1])
                changepath = '/home/' + str(items[0][0]) + '/' + str(items[0][1]) + '/' + str(items[0][2])
                print(changepath)
                # 修改节点内容
                self.html.xpath('//path')[0].text = changepath
                if not os.path.exists(self.output):
                    print('the output dir is not exis')
                else:
                    outputdir = os.path.join(self.output, itemxml)
                    self.html.write(outputdir)


if __name__ == '__main__':
    file = fileread()
    file.Annoread()
    file.xmlread()
