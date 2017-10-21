# Tech Exam - Hivetec

## Development Environment Setup

* Install xCode (latest) and install xCode Command Line Tools (5.0.2).
* Setup GitHub

  Setup SSH Keys (https://help.github.com/articles/connecting-to-github-with-ssh/)

* Configure git

        git config --global user.name "Your Actual Name"
        git config --global user.email "Your Actual Email"
        git config -l

* Install Homebrew, http://brew.sh/ (package manager for MacOs).

        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    Or

        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
    Or

        sudo apt install linuxbrew-wrapper

* Install Homebrew packages

        brew install wget
        brew install git

* Install RVM (Ruby Version Manager).

        curl -L https://get.rvm.io | bash -s stable

* Install Ruby

        rvm use ruby --install —default

        $ restaurant_menu git:(master) ruby -v
        ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16]



* Install PostgreSQL

    ***The best results I had were to install in the PostgresApp, installing it via the command line gave me tons of issues.
    Brew install postgresql DID NOT WORK. Instead, here are the steps that I had to take;

    PG App Install - GUI version 
    Elephant populates the minibar - open psql opens psql in the terminal. From there, you can edit user data:
    You can create a new user;
    
    `CREATE USER "user_name" WITH PASSWORD 'new_password';`

    OR

    `ALTER USER "user_name" WITH PASSWORD 'new_password';`

    PG App Install - GUI version 
    Check if PG is online/server is running:
    
    `ps aux | grep postgres`

    **Install PGAdmin III**
    
    Add a connection
    - local
    - localhost
    - 5432
    - username/password of database user (set above)
    
    Put following into ~/.bash_profile
    
    ```
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
    export PGHOST=localhost
    ```

    **export in base lingo is simply to set a new ENV for your OSX environment to use upon loading.
     
* Install Bundler (gem management tool).

        gem install bundler
        bundle install
        bundle update

* Install Rake

       gem install rake

* Initialize local development database

    Copy the file `config/database.yml.example` and rename it to `config/database.yml`

    Copy the file `config/application.yml.example` and rename it to `config/application.yml`, then update your database credentials

        DATABASE_USERNAME: your_database_username
        DATABASE_PASSWORD: your_database_password

    Setup the development database on your local instance  

        rails db:setup RAILS_ENV=development
        rails db:seed RAILS_ENV=development

* If you want to run the tests

        rake

* Run the application

  ```
  rails s
  ```

* Visit your application at [http://localhost:3000](http://localhost:3000)


### To import menu data, unzip datazet.zip and select Menu.csv to upload
