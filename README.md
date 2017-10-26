# README

Ruby version: ruby 2.4.1p111

Preparing:
- bundle isntall
- rake db:migrate

Define next environment variables for the https://cloudinary.com resource:
- cloudinary_cloud_name
- cloudinary_api_key
- cloudinary_api_secret

Start database:
- sudo service postgresql start

Start server:
- rails s

Tests running:
- bundle exec rspec
