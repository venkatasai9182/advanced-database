# database.py

from peewee import *

db = SqliteDatabase('app.db')

class User(Model):
    username = CharField()
    
    class Meta:
        database = db

class Task(Model):
    user = ForeignKeyField(User, backref='tasks')
    description = CharField()

    class Meta: 
        database = db

def create_tables():
    db.connect()
    db.create_tables([User, Task])

def get_users():
    return User.select()

def get_user_by_id(user_id):
    return User.get_by_id(user_id)

def add_user(username):
    User.create(username=username)

def update_user(user_id, username):
    user = User.get_by_id(user_id)
    user.username = username
    user.save()

def delete_user(user_id):
    user = User.get_by_id(user_id)
    user.delete_instance(recursive=True)

# Add CRUD operations for Task

def get_tasks():
    return Task.select()

def get_task_by_id(task_id):
    return Task.get_by_id(task_id)  

def add_task(user, description):
    Task.create(user=user, description=description)

def update_task(task_id, description):
    task = Task.get_by_id(task_id)
    task.description = description
    task.save()

def delete_task(task_id):
    task = Task.get_by_id(task_id)
    task.delete_instance()
