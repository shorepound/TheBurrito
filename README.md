# Burrito

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
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
