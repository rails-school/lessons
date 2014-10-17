(copied from whiteboard, not formatted yet)

Haml: http://haml.info/
Haml Reference: http://haml.info/docs/yardoc/file.REFERENCE.html
Converter: http://htmltohaml.com/ 

Coffeescript: http://coffeescript.org/ (can try out coffee -> javascript here)
js2coffee for converting existing javascript to coffeescript (or the other way): http://js2coffee.org/

Editor: spaces vs. tabs
Because haml and coffeescript both give meaning to indentation, it's important to set your editor to use spaces instead of tabs. 

In Sublime, go to Preferences -> Settigns - Default, and set "translate_tabs_to_spaces": true,
nitrous.io uses the correct settings already


Notes:
go to nitrous.io and fire up a rails dev box, or use your local dev machine if you have one set up.
$ rails new todos
$ cd todos

add to Gemfile:
    gem 'haml-rails'
$ bundle install

scaffold our Todo model, controller, and views
$ rails g scaffold todo title:string is_completed:boolean
rake db:create
rake db:migrate

add to config/routes.rb:
    root 'todos#index'

    
rename app/views/layouts/application.html.erb to application.html.haml and switch its contents to the haml equivalent:

!!! 5 
%html 
  %head  
    %title Todos  
    = stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true  
    = javascript_include_tag 'application', 'data-turbolinks-track' => true
    = csrf_meta_tags
  %body
    = yield

The following are all the other files we changed/created. We didn't do them all at once, but rather built up. We started by having index.html.haml just have a remote link, and then created new.js.coffee to test that remote link. Initially, we just had new.js.coffee be something simple like: alert("new todo clicked") to ensure that it was being run, then we switched it to use jquery to insert some text into the index.html.haml (we also created a div to stick that text into), and then finally we rendered a form as the text, and escaped it so that it could fit into a javascript string.


app/views/

index.html.haml

%h1 Listing todos 
#todos-list
  = render @todos
= link_to 'New Todo', new_todo_path, remote: true
#new-todo-form 


form.html.haml - we just changed line 1 to make it a remote form

= form_for @todo, remote: true do |f|


_todo.html.haml - we created this partial, which is used to render each todo in the collection when we render @todos

- if todo.is_completed
  .title.completed= todo.title
- else
  .title= todo.title
= form_for(todo, remote: true) do |f|
  = f.hidden_field :is_completed, value: true
  = f.submit '✓'   


new.js.coffee - show the new todo form as a result of clicking 'New Todo'

$("#new-todo-form").html("<%= j(render 'form') %>")
$("#todo_title").focus() 


create.js.coffee - refresh the list of todos as a result of submitting the new todo form. We took a shortcut and used this also as a result of updating a todo. We also demonstrated a little bit of coffeescript for a small easter egg here:

$("#todos-list").html("<%= j(render @todos) %>")
$("#new-todo-form").html("")
$(".title").each (idx, elem)->
  $(elem).css("background-color", "green") if $(elem).html() == "Learn Coffeescript" 


app/controllers/todos_controller.rb - in both create and update, add the following:
    
        @todos = Todo.all
        format.js   { render :create }


app/assets/stylesheets/todos.css.scss - we added a tiny bit of style to the list

.title {
  font-weight: bold;
  float: left;
  margin-right: 1em;
  &.completed {
    text-decoration: line-through;     
    float: none;   
  }      
  &.completed:after {     
    content: "✓";   
  } 
}

