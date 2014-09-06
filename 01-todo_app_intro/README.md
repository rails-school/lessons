# TODO App

A Ruby on Rails application to keep track of TODO items.
Created in RailsSchool. 

 - [RailsSchool Lesson](http://www.railsschool.org/l/todo-create-your-first-ruby-on-rails-app) (includes whiteboard)
 - [Completed Code](https://github.com/rails-school/todo_app_lesson01)

## Lesson Outline

1. Create a new nitrous.io environment - If you've followed the [FAQ](http://www.railsschool.org/faq) and created a local development environment, this works too, but we've found beginners are more comfortable using nitrous.io

1. Go over what we want to do - create an application to track To Do items (how meta...)

1. Create a new rails app in the console (It's that space on the bottom that ends in a `$`, so we'll use a `$` to indicate commands that you should run in the console) 

        $ rails new todos_app

4. Change Directory to the newly created todos_app directory 

        $ cd todos_app
         
5. Use rails built-in scaffolds to add the idea of a to do that we can check off 

        $ rails generate scaffold todo title:string description:text is_complete:boolean
         
6. This scaffolding created a database migration that needs to be run, so run it with 

        $ rake db:migrate
         
7. Launch the rails server 

        $ rails server
         
8. Preview the application by clicking on **Preview → Port 3000**

9. You should see the default welcome to rails screen. Browse to `/todos` to see the todo scaffold. 

10. We want the todos scaffold to be our root page, so in the editor, open `config/routes.rb` and add following line inside the `do...end` block:  

        root 'todos#index'
         
11. Browse to the root page (or click **Preview → Port 3000** again) and play around. Notice that we didn't have to restart our rails server.

## Extra

We had some time left over, so we decided to add another field to our Todo model in order to keep track of when we want to accomplish our todo items.

1. add new field to track when the todo item is due (note: you can create a new console tab for this, just remember to `cd todos_app`):
    
        $ rails generate migration add_due_at_to_todos due_at:datetime
        $ rake db:migrate

1. Enter the console to set the `due_at` fields for some existing todos:

        $ rails console
        > t = Todo.find(1)
        > t.due_at = "2014-09-05"
        > t.save!
        > t = Todo.find(2)
        > t.due_at = 5.days.from_now
        > t.save!

1. Edit `app/views/todos/index.html.erb` to show the `due_at` field:

1. edit app/views/todos/_form.html.erb to add the due_at field to our form

        <div class="field">
          <%= f.label :due_at %><br>
          <%= f.date_select :due_at %>
        </div>

1. tell the controller to allow the `due_at` field in the params

        def todo_params
          params.require(:todo).permit(:title, :description, :is_completed, :due_at)
        end
    

## Tips & Tricks

- While we can make changes to `config/routes.rb` or the files in `app/` without having to restart the rails server, if you want to restart it, in the console, press `Ctrl+c` (while holding down the `CTRL` key, press the `C` key) to quit out of the running server, and then press the up arrow (or retype `rails server`) and hit enter to relaunch the server.

- `rails s` works as shorthand for `rails server`

- `rails g` works as shorthand for `rails generate` 

- When in the console, you don't have to type out full names of files and directories. Just start typing and then hit the `TAB` key to autocomplete. This is known as __Tab Completion__. For example `$ cd tod[TAB]` will autocomplete to `$ cd todo_app` if you're in a new console.

- When in the `rails console`, if you change a file in `app/`, type `reload!` to grab those changes so you don't have to restart the rails console.

