from csv import unregister_dialect
from datetime import datetime
from operator import attrgetter
from sqlalchemy import ForeignKey
from application import db



class SerializationObject(object):
    def to_dict(self):
        value = {}
        for column in self.__table__.columns:
            attribute = getattr(self,column.name)
            if isinstance(attribute,datetime.datetime):
                attribute = str(attribute)
            value[column.name] = attribute
        return value

#db.String
#db.Text
#db.Integer
#db.Float
#db.Boolean
#db.Date
#db.DateTime
#db.Time
#-----------------------------------
#primary_key	如果设为 True，这列就是表的主键
#ForeignKey('table.id')
#unique	如果设为 True，这列不允许出现重复的值
#index	如果设为 True，为这列创建索引，提升查询效率
#nullable	如果设为 True，这列允许使用空值；如果设为 False，这列不允许使用空值
#default	为这列定义默认值
#db.relationship("Group", backref="user", passive_deletes=True)


#用户表
class t_users(db.Model):
    __tablename__ = "t_users" #设置表名
    id = db.Column(db.Integer,primary_key=True)
    username = db.Column(db.String(30) ,unique=True)
    password = db.Column(db.String(128),nullable=True)
    realname = db.Column(db.String(50),nullable=True)
    gender = db.Column(db.Integer)
    usertype = db.Column(db.Integer,ForeignKey('t_role.id'))
    status = db.Column(db.Integer)
    telephone = db.Column(db.String(50))
    email = db.Column(db.String(50))
    change_time = db.Column(db.DateTime)
    groups = db.relationship('t_role',backref='t_users')

#角色表
class t_role(db.Model):
    __tablename__="t_role"
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(20) ,unique=True)
    description = db.Column(db.String(255) ,unique=True)


#权限表
class t_permission(db.Model):
    __tablename__="t_permission"
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(20))
    value = db.Column(db.String(40))
    type = db.Column(db.String(2))
    #按钮才有的配置，按钮ID
    paraent_id = db.Column(db.Integer)
    list_order = db.Column(db.Integer)
    description = db.Column(db.String(255))


#用户角色对照表
class t_user_role(db.Model):
    __tablename_ = "t_user_role"
    id = db.Column(db.Integer,primary_key=True)
    user_id = db.Column(db.Integer,ForeignKey('t_users.id'))
    role_id = db.Column(db.Integer,ForeignKey('t_role.id'))


#角色权限对照表
class t_role_permission(db.Model):
    __tablename__ = "t_role_permission"
    id = db.Column(db.Integer,primary_key=True)
    role_id = db.Column(db.Integer,ForeignKey('t_role.id'))
    permission_id = db.Column(db.Integer,ForeignKey('t_permission.id'))

#单位表
class t_company(db.Model):
    __tablename__ = "t_company"
    id = db.Column(db.Integer,primary_key=True)
    company_name = db.Column(db.String(30),nullable=True)
    person_name = db.Column(db.String(30))
    person_tel = db.Column(db.String(30))
    description = db.Column(db.String(255))

#单位人员表
class t_system_info(db.Model):
    __tablename__ = "t_system_info"
    id = db.Column(db.Integer,primary_key=True)
    company_id = db.Column(db.Integer,ForeignKey('t_company.id'))
    system_name = db.Column(db.String(30),nullable=True)
    system_type = db.Column(db.String(10),ForeignKey('t_code.code'))
    description = db.Column(db.String(255))
    system_types = db.relationship('t_code',backref='t_system_info')
    company_info = db.relationship('t_company',backref='t_system_info')

#代码表
class t_code(db.Model):
    __tablename__ =  "t_code"
    id = db.Column(db.Integer,primary_key=True)
    code = db.Column(db.String(10) ,unique=True)
    name = db.Column(db.String(30))