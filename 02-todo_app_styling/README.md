# Styling our ToDo App

In this lesson we're going to take what we built last week and make it look much nicer. Don't worry if you missed last week, as we'll show you how to grab the code from last week.

## Lesson Outline

  1. If you still have your nitrous.io instance from last week, and your code is up to date, you can skip this step. Otherwise,

    1. Create a [nitrous.io](nitrous.io) instance to run Ruby on Rails

    1. If you already have an instance but want to start fresh, then delete the folder you created last time

            $ rm -rf todo_app

    1. Pull the code from lesson01 into your nitrous box

            $ git clone https://github.com/rails-school/todo_app_lesson01.git

      - (optional, advanced) try forking the github repository and then cloning your fork so you can push your changes back to it.

    1. Initialize the rails app and make sure you can Preview it on Port 3000 (and create a new todo)

            $ cd todo_app_lesson01
            $ bundle install
            $ rake db:create
            $ rake db:migrate
            $ rails server

  1. Introduction to CSS

    1. with your `rails server` running, preview the server in Chrome (these instructions target chrome, but you can also do almost the same thing in Firefox. Safari and IE have developer tools as well.)

    1. right click on a todo item and choose __Inspect Element__ to open up the developer tools.

    1. In the styles panel, play around with the settings to change the apperance of the item

  1. Hardcoding CSS

    1. Remember the styles we just figured out? We can enter them into `app/assets/stylesheets/application.css`

    1. But that gets messy, so lets put them into `app/assets/stylesheets/custom.css` and require that file from `application.css`

  1. Getting Some Sass

    1. To make our lives easier, we can add some functionality to css, like support for variables and nested styles. To do this, change `application.css` to `aplication.css.scss` to indicate that rails should _preprocess_ the file with the `scss` preprocessor.

    1. Create a file `app/assets/stylesheets/_variables.css.scss` and define some variables, like:

            $main-color: blue;

    1. Now in `app/assets/stylesheets/application.css.scss` get rid of the `require_tree` directive, and explicitly import our variables, so that they're available to all our stylesheets. Also let's import our `custom` definitions rather than require them.

            /*
             *= require_self
             */

            @import 'variables';
            @import 'custom';

    1. rename `custom.css` to `_custom.css.scss`

    1. Now feel free to use our variables inside `_custom.css.scss`

  1. Now that we have an understanding of css and sass, we're going to take things to the next level by adding some convenience libraries. Add the following to the `Gemfile`:

          gem 'bourbon'
          gem 'neat'
          gem 'bitters'
          gem 'refills'

    1. Install these gems

            $ bundle install

    1. Install the styles that come with _bitters_

            $ cd app/assets/stylesheets
            $ bitters install

    1. reference all these new goodies in our `application.css.scss`

            @import "bourbon";
            @import "base/base";
            @import "neat";

    1. Since we're using both _neat_ and _bitters_ we have to uncomment the following line in `app/assets/stylesheets/base/_base.scss`:

            @import "grid-settings";

    1. Refresh the web page and notice that it's already starting to look better!

  1. Dive deeper into styling. 

    1. First, let's go over the _neat_ grid layout at http://neat.bourbon.io/examples/

    1. Play around with layouts and styling, using the _neat_ grid as well as available [Bourbon](http://bourbon.io/docs/) mixins.

  1. Use some rich existing layouts

    1. Check out the components that we can grab from [Refills](http://refills.bourbon.io/)

    1. You can either copy + paste the html and styling from this website, or because we installed the `refills` gem, you can view available refills with:

            $ rails g refills:list

    1. Once you find one you want to use, install it. In this case, I want to make our todo items look like cards.

      1. Install the html and styling

            $ rails g refills:import cards

      1. Include it into our `application.css.scss`

            @import 'refills/cards';

      1. Include it into our web page by copying and pasting the created `app/views/refills/cards.html.erb` into our `app/views/todos/index.html.erb`

      1. Repeat with other components. For example, say we wanted a landing page with a big hero message:

        1. Create a new `home_controller.rb` controller, with a single empty `index` method.

        1. Create the directory `app/views/home` and add a file `index.html.erb` in it.

        1. Update the root controller/action in `config/routes.rb` to point to `home#index`

        1. Install the html and styling

                $ rails g refills:import hero

        1. Include it in our `application.css.scss`

                @import 'refills/hero';

        1. Copy `app/views/refills/hero.html.erb` into the newly created `app/views/home/index.html.erb`
