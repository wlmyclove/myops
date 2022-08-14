#全局通用配置类
class Config(object):

    HOST = '127.0.0.1'
    PORT = '8088'

    #配置session KEY
    SECRET_KEY = 'xeewxe4xc0xeexb1]x9bxa0x9e)x15Qhemxe5xf17xd6xceBxb7xb4'

    """项目配置核心类"""
    #调试模式
    DEBUG=True
    #DEBUG=True
  
    # 配置日志
    # LOG_LEVEL = "DEBUG"
    #LOG_LEVEL = "INFO"
    # 日志
    LOGGING_LEVEL = 'INFO'
    LOGGING_FILE_DIR = './application/logs'
    LOGGING_FILE_MAX_BYTES = 300 * 1024 * 1024
    LOGGING_FILE_BACKUP = 10
    
    # 配置redis
    # 项目上线以后，这个地址就会被替换成真实IP地址，mysql也是
    REDIS_HOST = 'your host'
    REDIS_PORT = 'your port'
    REDIS_PASSWORD = 'your password'
    REDIS_POLL = 10
    
    #数据库连接格式
    SQLALCHEMY_DATABASE_URI = "mysql+pymysql://myweb:myweb123@172.16.0.99:3306/ops?charset=utf8"
    # 动态追踪修改设置，如未设置只会提示警告
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    # 查询时会显示原始SQL语句
    SQLALCHEMY_ECHO = False
    # 数据库连接池的大小
    SQLALCHEMY_POOL_SIZE=10
    #指定数据库连接池的超时时间
    SQLALCHEMY_POOL_TIMEOUT=10
    # 控制在连接池达到最大值后可以创建的连接数。当这些额外的 连接回收到连接池后将会被断开和抛弃。
    SQLALCHEMY_MAX_OVERFLOW=2
    
    #rabbitmq参数配置
    RABBITUSER="user"
    RABBITPASSWORD="password"
    RABBITHOST="your ip"
    RABBITPORT="your port"