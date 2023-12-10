<h1>Tasks</h1>

<a href="/tasks/add">Add Task</a>

<table border="1">
  <tr>
    <th>Description</th>
    <th>Edit</th>
    <th>Delete</th>
  </tr>
  % for task in tasks:
    <tr>
      <td>{{ task.description }}</td>
      <td><a href="/tasks/{{ task.id }}/edit">Edit</a></td>
      <td><a href="/tasks/{{ task.id }}/delete">Delete</a></td>
    </tr>
  % end
</table>

<p><a href="/users">Back to Users list</a></p>