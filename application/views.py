from re import template
from flask import Blueprint
from flask import Flask, render_template, request, redirect, url_for, flash,session,jsonify
from importlib_metadata import method_cache
from .models import t_system_info, t_users
from .utils.tools import tomd5
from application import db
from .filter.requestFilter import func_check_login

import logging
logger = logging.getLogger('flask.app')
views = Blueprint('views',__name__)


@views.route('/')
def func_access_index():
    return render_template('index.html')



@views.route('/login',methods=['GET', 'POST'])
def func_auth_login():
    username=''
    password=''
    if request.method == 'GET':
        return render_template('index.html')
    if request.method == 'POST':
        username = request.form.get('username')
        password = tomd5(request.form.get('password'))
        print(username + password)
        if len(username) != 0 :
            logger.info('user: ' + username + ' begin login!')
            user = t_users.query.filter(t_users.username == username , t_users.password == password ).first()
            print(user)
            if user is not None : 
                #检查用户状态是否为锁定
                if user.status == 1 :
                    logger.info('user: ' +user.username + ' login is success !')
                    session['username'] = user.username
                    session['realname'] = user.realname
                    session['usertype'] = user.usertype
                    session['groups'] =  user.groups.name
                    session['status'] = user.status
                    #获取权限及目录结构
                    menusql ='select a.id,d.name,d.value,d.list_order from t_users a ,t_user_role b ,t_role_permission c,t_permission d where a.id = b.user_id  and b.role_id = c.role_id  and c.permission_id = d.id and a.id = "{0}"  and d.type = 1 order by list_order'.format(user.id)
                    menu = db.session.execute(menusql).fetchall()
                    #处理菜单序列化
                    menuList = []
                    for i in menu:
                        templist = (i.id,i.name,i.value,i.list_order)
                        menuList.append(templist)
                    #-------------------------------------------
                    session['menuList'] = menuList
                    return render_template('main.html', menuList = menuList)
                else:
                    logger.info('user: ' + user.username + ' login check ok ,but user statu is ' + str(user.status) )
                    return render_template('index.html', message='User is Clock, Please call Admin!')
                    #return jsonify('User is Clock, Please call Admin!')
            else:
                logger.info('user: ' + username + ' login check Failed, For Username or Password Invaid!')
                return render_template('index.html',message='Username or Password Invaid!!')
        else:
            return render_template('index.html',message='Please imput Username or Password!')
    return render_template('index.html')



@views.route('/main',methods=['GET', 'POST'])
@func_check_login
def func_open_main():
    menuList = session['menuList']
    return render_template('main.html',menuList=menuList)



@views.route('/exit',methods=['GET', 'POST'])
def func_exit():
    session.clear()
    return render_template('index.html')

@views.route('/operation',methods=['GET', 'POST'])
@func_check_login
def func_open_operation():
    menuList = session['menuList']
    systemlist  =  t_system_info.query.all()

    return render_template('operation.html',menuList=menuList,systemInfo = systemlist)

@views.route('/network',methods=['GET', 'POST'])
@func_check_login
def func_open_network():
    menuList = session['menuList']
    return render_template('network.html',menuList=menuList)

@views.route('/ajaxhtml',methods=['POST'])
def func_ajaxthml_test():
    username = request.form.get('username')
    password = request.form.get('password')
    print(username+'1111')
    print(password)
    return jsonify(username)
