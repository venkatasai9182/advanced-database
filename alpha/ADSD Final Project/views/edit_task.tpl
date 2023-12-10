%#template for editing tasks
% task = task

<h1>Edit Task</h1>

<form action="/tasks/{{ task.id }}/edit" method="post">
    <label for="description">New Description:</label>
    <input type="text" name="description" value="{{ task.description }}" required>
    <input type="submit" value="Save">
</form>

<a href="/tasks">Back to Task List</a>
