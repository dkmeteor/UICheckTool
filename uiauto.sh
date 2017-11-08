#!/bin/bash
#                                                                                                                                    
# Copyright (C) 2014 zhengyang.xu E-mail: zhengyang.xu@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# `adb pull /sdcard/uiautomator/$1 base/$1`
# `adb pull /sdcard/uiautomator/$2 base/$2`

##配置文件夹
BASEPATH="base/"$1"/"
if [ ! -d $BASEPATH ]; then  
    mkdir $BASEPATH
fi 

NEWPATH="base/"$2"/"
if [ ! -d $NEWPATH ]; then  
    mkdir $NEWPATH
fi

#source ~/.bash_profile

EXPORTPATH="/result"$1"-"$2"/"
if [ ! -d $EXPORTPATH ]; then  
    mkdir $EXPORTPATH
fi

$File1
$File2
$File3
##图片差异 当前ImageMagick返回结果使用了科学计数法
$diff_count

#比较BASEPATH&NEWPATH中的所有同名图片,并输出diff图片到EXPORTPATH
function compare_png(){ 
    for file in ` ls $BASEPATH `
    do
        if [ -d $BASEPATH$file ]
        then
            compare_png $BASEPATH$file
        else
            echo "compare " $BASEPATH$file
            diff_count=`compare -metric AE $BASEPATH$file $NEWPATH$file $EXPORTPATH$file 2>&1`
            File1=$EXPORTPATH$file"_base_small.png"
            File2=$EXPORTPATH$file"_new_small.png"
            File3=$EXPORTPATH$file"_export_small.png"
            #width is 160 px, and you can use percent like 30% replace 160
            convert -thumbnail 160 $BASEPATH$file $File1
            convert -thumbnail 160 $NEWPATH$file $File2
            convert -thumbnail 160 $EXPORTPATH$file $File3
            #TODO Shell太难用,页面生成代码移到JS中进行
            echo "<tr>">>$result_html
            echo "<td><font style=\"color:red;\">$file</font></td>">>$result_html
            echo "<td><font style=\"color:red;\">$diff_count</font></td>">>$result_html
            echo "<td><font style=\"color:red;\">"Failed"</font></td>">>$result_html
            echo "<td><a target=_blank href=$BASEPATH$file><img src=$File1></a></td>&nbsp;">>$result_html                
            echo "<td><a target=_blank href=$NEWPATH$file><img src=$File2></a></td>&nbsp;">>$result_html
            echo "<td><a target=_blank href=$EXPORTPATH$file><img src=$File3></a></td>&nbsp;">>$result_html
            echo "<td>$diff_count</td>&nbsp;">>$result_html
            echo "</tr>">>$result_html
        fi
    done
}
#create result.html
result_html=$EXPORTPATH"result.html"
`rm -r $result_html`
echo $result_html
echo "result: "$1" -> "$2"<br>">>$result_html
echo "">>$result_html
echo "<table border="1">">>$result_html
compare_png
`open result$1-$2/result.html`
