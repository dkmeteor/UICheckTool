#UiAutomator & UICheck工具

- Step 1
    - 配置UiAutomator环境,编写测试脚本,具体请参考官方UiAutomator文档
    - 使用Scheme访问所有页面,测试Scheme内可包含各页面测试id
        - ex: scheme://user/{userId}  
    - 页面打开后使用Device.takeScreenshot截图并存入以版本号命名的文件夹中
        - ex: /sdcard/uiautomator/版本号/页面名称.png 
        
- Step 2
    - clone [https://github.com/dkmeteor/UICheckTool](https://github.com/dkmeteor/UICheckTool)  
        或者 直接下载/复制 uiauto.sh脚本
    - 到UiCheck根目录下,执行 adb pull /sdcard/uiautomator/版本号 base/版本号 
        - ex: adb pull /sdcard/uiautomator/3.1.5 base/3.1.5
    - 执行 sudo ./uiauto.sh 版本号1 版本号2
        - ex: sudo ./uiauto.sh 3.1.4 3.1.5 
    - 执行完毕后会自动打开浏览器展示对比结果,你也可以手动打开result/result.html查看对比结果