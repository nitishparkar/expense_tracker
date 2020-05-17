# The Project: An Expense Tracker

Test project for [Effective Testing with RSpec 3](https://pragprog.com/book/rspec3/effective-testing-with-rspec-3)

We’ll need a project big enough to contain some real-world problems, but small enough to work on over a few chapters. How about a web service for tracking expenses? Customers will use some kind of client software—a com- mand-line app, a GUI, or even a web app—to track and report their daily expenses.

Here are the major parts of the app:
• A web application written in Sinatra that will receive incoming HTTP requests (to add new expenses or search for existing ones)1
• A database layer using Sequel to store expenses between requests2
• A set of Ruby objects to represent expenses and glue the other pieces together