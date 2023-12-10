# application.py

from bottle import *
import database

from database import User, Task  

database.create_tables()

@route('/')

@route('/users')
def users():
    search_username = request.query.get('search_username', '')
    users = database.get_users()

    if search_username:
        user = User.get_or_none(User.username == search_username)
        tasks = Task.select().where(Task.user == user) if user else []
        return template('users', users=users, search_username=search_username, user=user, tasks=tasks)
    
    users_with_tasks = User.select(User, Task).join(Task)

    return template('users', users=users, search_username=search_username, user=None, tasks=[], users_with_tasks=users_with_tasks)

    return template('users', users=users, search_username=search_username, user=None, tasks=[])

@get('/users/add')  
def get_add_user():
    return template('add_user')

@get('/search')
def get_search():
    return template('search')

@post('/search')
def post_search():
    username = request.forms.get('username')
    user = User.get_or_none(User.username == username)
    
    if user:
        tasks = Task.select().where(Task.user == user)
        return template('search_results', username=username, tasks=tasks)
    else:
        return template('search_results', username=username, tasks=None)


@post('/users/add')
def post_add_user():
    username = request.forms.get('username')
    database.add_user(username)
    redirect('/users')

@get('/users/<user_id:int>/edit')
def get_edit_user(user_id):
    user = database.get_user_by_id(user_id)
    return template('edit_user', user=user)

@post('/users/<user_id:int>/edit') 
def post_edit_user(user_id):
    username = request.forms.get('username')
    database.update_user(user_id, username)
    redirect('/users')

@get('/users/<user_id:int>/delete')
def get_delete_user(user_id):
    database.delete_user(user_id)
    redirect('/users')

@route('/tasks')
def tasks():
    tasks = database.get_tasks()
    return template('tasks', tasks=tasks)

@get('/tasks/add')  
def get_add_task():
    users = database.get_users()
    return template('add_task', users=users)

@post('/tasks/add')
def post_add_task():
    user_id = request.forms.get('user_id')
    description = request.forms.get('description')
    user = database.get_user_by_id(user_id)
    database.add_task(user, description)
    redirect('/tasks')

@get('/tasks/<task_id:int>/edit')
def get_edit_task(task_id):
    task = database.get_task_by_id(task_id)
    return template('edit_task', task=task)

@post('/tasks/<task_id:int>/edit') 
def post_edit_task(task_id):
    description = request.forms.get('description')
    database.update_task(task_id, description)
    redirect('/tasks')

@get('/tasks/<task_id:int>/delete')
def get_delete_task(task_id):
    database.delete_task(task_id)
    redirect('/tasks')

# application.py

@route('/user_tasks')
def get_user_tasks():
    try:
        # Fetching the users and their associated tasks using a join
        users_with_tasks = User.select(User, Task).join(Task).group_by(User.id)

        # For debugging purposes
        for user_with_tasks in users_with_tasks:
            print("User:", user_with_tasks.username)
            print("Tasks:", [task.description for task in user_with_tasks.tasks])
        
        return template('user_tasks', users_with_tasks=users_with_tasks)
    except Exception as e:
        print("Error:", e)
        raise  # Re-raise the exception for detailed traceback



run(host='localhost', port=8081)