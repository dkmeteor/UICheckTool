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

##配置文件夹
BASEPATH="/Users/dk/Documents/UICheck/base/"
if [ ! -d $BASEPATH ]; then  
    mkdir $BASEPATH
fi 

NEWPATH="/Users/dk/Documents/UICheck/new/"
if [ ! -d $NEWPATH ]; then  
    mkdir $NEWPATH
fi

souce ~/.bash_profile

EXPORTPATH="/Users/dk/Documents/UICheck/result/"
if [ ! -d $EXPORTPATH ]; then  
    mkdir $EXPORTPATH
fi

$File1
$File2
$File3
$diff_count
$ok_count
$ng_count

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
            echo "#####" $File3
            #width is 160 px, and you can use percent like 30% replace 160
            convert -thumbnail 160 $BASEPATH$file $File1
            convert -thumbnail 160 $NEWPATH$file $File2
            convert -thumbnail 160 $EXPORTPATH$file $File3
            echo "##########diff_count" $diff_count
            # if [$diff_count -gt 0 ]; then
                echo "<br><tr>">>$result_html
                echo "<td><font style=\"color:red;\">$file</font></td>">>$result_html
                echo "<td><font style=\"color:red;\">$diff_count</font></td>">>$result_html
                echo "<td><font style=\"color:red;\">"Failed"</font></td>">>$result_html
                echo "<td><a target=_blank href=$BASEPATH$file><img src=$File1></a></td>&nbsp;">>$result_html
                echo "<td><a target=_blank href=$NEWPATH$file><img src=$File2></a></td>&nbsp;">>$result_html
                echo "<td><a target=_blank href=$EXPORTPATH$file><img src=$File3></a></td>&nbsp;">>$result_html
                echo "<td>$diff_count</td>&nbsp;">>$result_html
                echo "</tr>">>$result_html
                let ng_count+=1;
            # elif [ $diff_count -eq 0 ]; then
            #     echo "<br><tr>">>$result_html
            #     echo "<td><font style=\"color:black;\">$file</font></td>">>$result_html
            #     echo "<td><font style=\"color:black;\">$diff_count</font></td>">>$result_html
            #     echo "<td><font style=\"color:black;\">"OK"</font></td>">>$result_html
            #     echo "<td><a target=_blank href=$BASEPATH$file><img src=$File1></a></td>&nbsp;">>$result_html
            #     echo "<td><a target=_blank href=$NEWPATH$file><img src=$File2></a></td>&nbsp;">>$result_html
            #     echo "<td><a target=_blank href=$EXPORTPATH$file><img src=$File3></a></td>&nbsp;">>$result_html
            #     echo "</tr>">>$result_html
            #     let ok_count+=1;
            # fi
        fi
    done
    echo "<br><tr>">>$result_html
    echo "<td><font style=\"color:black;\">"OK :"</font></td>">>$result_html
    echo "<td><font style=\"color:black;\">$ok_count</font></td>">>$result_html
    echo "</tr>">>$result_html
    echo "<br><tr>">>$result_html
    echo "<td><font style=\"color:red;\">"Failed :"</font></td>">>$result_html
    echo "<td><font style=\"color:red;\">$ng_count</font></td>">>$result_html
    echo "</tr>">>$result_html

}
#create result.html
result_html=$EXPORTPATH"result.html"
echo $result_html
echo "<a href="$EXPORTPATH/result.html">$(date -d now --rfc-3339=ns)</a>&nbsp;&nbsp;<br>">>$result_html
echo "<br>">>$result_html
echo "<table border="1">">>$result_html
compare_png


