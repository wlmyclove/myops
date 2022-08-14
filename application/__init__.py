from flask_sqlalchemy import SQLAlchemy
import pymysql
from  flask import Flask
from application.settings.dev import DevelopmentConfig
from application.settings.prod import ProductionConfig


app = Flask(__name__)


config = {
    'dev': DevelopmentConfig,
    'prop': ProductionConfig
}


# 设置配置类
Config = config['dev']
# 加载配置
app.config.from_object(Config)


# 创建数据库连接对象
db = SQLAlchemy(app)


# todo 注册蓝图
from application.views import *
app.register_blueprint(views)

from application.utils.loggings import create_logger
create_logger(app)