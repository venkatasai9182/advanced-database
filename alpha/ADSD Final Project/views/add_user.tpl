%#template for add user form

<h1>Add User</h1>

<form action="/users/add" method="POST">
  <label>Username:</label>
  <input name="username" type="text">
  <button type="submit">Save</button>
</form>