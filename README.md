#UiAutomator & UICheck工具

仅支持MAC & Linux,需先安装[ImageMagick](http://www.imagemagick.org/script/index.php)  


	brew install imagemagick


- Step 1
    - 配置UiAutomator环境,编写测试脚本,具体请参考官方UiAutomator文档
    - 使用Scheme访问所有页面,测试Scheme内可包含各页面测试id,也可使用UiAutomator脚本方式访问页面
        - ex: scheme://user/{userId}  
    - 页面打开后使用Device.takeScreenshot截图并存入以版本号命名的文件夹中
        - ex: /sdcard/uiautomator/版本号/页面名称.png 
        
- Step 2
    - clone [https://github.com/dkmeteor/UICheckTool](https://github.com/dkmeteor/UICheckTool)  
        或者 直接下载/复制 uiauto.sh脚本
    - 到UiCheck根目录下,执行 adb pull /sdcard/uiautomator/版本号 base/版本号 
        - ex: adb pull /sdcard/uiautomator/3.1.5 base/3.1.5
    - 执行 sudo ./uiauto.sh 版本号1 版本号2 ,可将脚本中中注释打开,此时会自动从手机中pull版本号1/2的截图到 base/版本号 文件夹中
        - ex: sudo ./uiauto.sh 3.1.4 3.1.5 
    - 执行完毕后会自动打开浏览器展示对比结果,你也可以手动打开result版本号1-版本号2/result.html查看对比结果

- TODO
    - 当前输出UI太难看,需要处理一下,可能变成输出纯数据(JSON),UI到JS中组织
    - 集成到jenkins
    - 制作一个小型内网站点,显示&整理 数据,比如dexCount,及build&测试结果