%#template to edit a user
% user = user

<h1>Edit User</h1>

<form action="/users/{{user.id}}/edit" method="POST">
  <label>Username:</label>
  <input name="username" type="text" value="{{user.username}}">
  <button type="submit">Save</button> 
</form>