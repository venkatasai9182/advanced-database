<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Task</title>
</head>
<body>
    <h1>Add Task</h1>
    <form action="/tasks/add" method="post">
        <label for="user_id">User:</label>
        <select name="user_id" id="user_id" required>
            % for user in users:
                <option value="{{ user.id }}">{{ user.username }}</option>
            % end
        </select>
        <br>
        <label for="description">Description:</label>
        <input type="text" name="description" id="description" required>
        <button type="submit">Add Task</button>
    </form>
    <p><a href="/users">Back to Users list</a></p>
</body>
</html>
