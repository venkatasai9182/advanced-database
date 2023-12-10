<!-- users.tpl -->

<!-- Search Form -->
<form action="/users" method="get">
    <label for="search_username">Search Tasks for an User:</label>
    <input type="text" name="search_username" value="{{ search_username }}">
    <input type="submit" value="Search">
</form>

% if search_username:
    <h2>Search Results for '{{ search_username }}'</h2>
    % if user:
        <h3>{{ user.username }} - Tasks:</h3>
        % for task in tasks:
            <p>{{ task.description }}</p>
        % end
    % else:
        <p>No user found with the username '{{ search_username }}'</p>
    % end
% else:
<h1>Users</h1>
    <!-- Display Users -->
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        % for user in users:
            <tr>
                <td>{{ user.username }}</td>
                <td><a href="/users/{{ user.id }}/edit">Edit</a></td>
                <td><a href="/users/{{ user.id }}/delete">Delete</a></td>
            </tr>
        % end
    </table>
    <a href="/users/add">Add User</a>

% if users_with_tasks:
    <!-- Display Users with Tasks -->
    <h2>Users with Tasks (Join)</h2>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Tasks</th>
        </tr>
        % users_displayed = set()  # Create a set to track unique users
        % for user_with_tasks in users_with_tasks:
            % if user_with_tasks.username not in users_displayed:  # Check if the user is not already displayed
                <tr>
                    <td>{{ user_with_tasks.username }}</td>
                    <td>
                        <ul>
                            % for task in user_with_tasks.tasks:
                                <li>{{ task.description }}</li>
                            % end
                        </ul>
                    </td>
                </tr>
                % users_displayed.add(user_with_tasks.username)  # Add the username to the set
            % end
        % end
    </table>
% end

% # template to display tasks
% tasks = tasks

<h1>Tasks</h1>

<a href="/tasks/add">Add Task</a>

% if tasks:
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
% end
