/application #主程序目录
    ----settings #参数配置文件目录
        ----dev.py #开发参数文件继承settings
        ----prod.py #生产参数文件继承settings
        ----settings.py  #基础参数配置文件
    ----filter #修饰器
        ----requestFiler.py #修饰器文件
    ----staic #静态文件目录
    ----logs  #日志文件存放目录
    ----templates  #模板文件存放目录
    ----utils   #自定义工具目录
        ----loggings.py  #日志配置文件
    ----__init__.py  #初始化
    ----models.py  #数据模型
    ----views.py  #业务代码
run.py  #启动文件
db.sql  #数据库脚本

