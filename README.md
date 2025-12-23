# TheBurrito

Simple Rails 8 application for creating burritos.

Quick start

1. Install dependencies:

```bash
bundle install
```

2. Create and seed the database:

```bash
bin/rails db:create db:migrate db:seed
```

3. Run the server:

```bash
bin/rails server
```

4. Open http://localhost:3000

Default admin credentials (created by `db:seed`):

- email: `admin@example.com`
- password: `password`

Notes

- Bootstrap is loaded from CDN in `app/views/layouts/application.html.erb`.
- To speed up boots, the app uses `bootsnap`. If you run into stale-constant errors, stop Spring and clear caches:

```bash
bin/spring stop
rm -rf tmp/cache tmp/bootsnap*
```

Dev helpers

- A convenience rake task is provided to stop Spring, clear tmp caches, and restart the dev server in the background:

```bash
bin/rake dev:restart_server
# logs are appended to log/dev_server_task.log
```

Development mail

- `letter_opener` and `letter_opener_web` are included for dev email previews. After starting the server open:

```
http://127.0.0.1:3000/letter_opener
```

Password reset

- Users can request a password reset from the login area. Password reset emails are sent to the dev preview above in development.

User flows

- Anyone can compose a burrito; if they aren’t signed in when they try to save it the burrito is stored in the session and the user is redirected to sign up or login. After signing up or logging in the pending burrito will be persisted to their account.

Admin

- Admin UI is available under `/admin`. Seed creates a default admin:

	- email: admin@example.com
	- password: password

Troubleshooting

- If Bootstrap or assets don't appear, remove any integrity/crossorigin attributes from the CDN tags in `app/views/layouts/application.html.erb` while iterating locally.
- If you see stale-constant or name-collision errors after renames, run the Spring stop + tmp cache removal above and restart the server.
