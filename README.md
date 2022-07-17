# Olio test app

This app was built as a technical test for Olio.

## Tech stack

- Rails 7
- Ruby 3.0.2
- PostgreSQL database
- React frontend

## Initial setup

The first step is to clone this repository. Open a new terminal window and run:

```
git clone git@github.com:adamleozar/olio-test.git
```

Then cd into the directory:

```
cd olio-test
```

### Dependecies

There are bunch of dependencies that need to be installed before you can run the app.

#### RVM and Ruby

There are many different versions of the Ruby programming language and each new rails project will usually have a dependency on a different version of Ruby. We should therefore use a ruby version manager which help install and manage all the different ruby versions needed for each project. There are two main ruby version managers namely RVM and rbenv. I personally prefer RVM and therefore I will run through the setup for for RVM and the installation of the Ruby version needed for this project.

From the terminal window you are in run:

If you are using bash as your shell

```
\curl -sSL https://get.rvm.io | bash -s stable
source $HOME/.bashrc
source $HOME/.profile
```

alternatively if you are using zsh as your shell

```
\curl -sSL https://get.rvm.io | bash -s stable
source $HOME/.zshrc
source $HOME/.profile
```

You can validate the installation by running:

```
rvm -v
```

You should see the rvm version details as an output if rvm installed properly.

This project has a dependency on Ruby 3.0.2. Therefore in order to install and use the correct version, run the following from the terminal window from inside the project directory:

```
rvm install 3.0.2
rvm use 3.0.2
```

You can validate the installation by running the command `ruby -v` and you should see the following output: `ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [arm64-darwin21]`.

#### Rails

In order to run the all the ruby package dependencies known as gems we will use a rails package called bundler.
Run the following from the project directory:

```
gem install bundler
bundle install
```

This will install all the ruby gems that are listed in the Gemfile of this project.

#### Database

The database used in this project is postgresql. You will need install postgresql to get the app running. We will use homebrew to install run the postgresql package. Homebrew is a package manager for MacOS and Linux. To install homebrew run:

for bash

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
```

and zsh

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
```

You then need to open up a new terminal window and run `brew doctor` to check that the installation was successful.

You are now ready to install postgresql:

```
brew install postgresql
brew services start postgresql
```

You can check that postgresql is running by running the command: `brew services list`

You are now ready to create your databases for the rails app. Run the following command from within the app directory:

```
rails db:setup
```

This will create two database one for the main app and one for the test environment. This command will also run the migrations in the app which initialises the databases to be used in the app.

#### Javascript

This rails project has a react frontend. Rails 7 does not ship ship with any javascript out of the box so we therefore need to install node.js which is a javascript run time. There are two main node package managers namely: npm and yarn which are used to install the javascript package dependencies in a project. This project uses yarn. To install node.js, yarn and this projects package dependecies run the following from with the app directory:

```
brew install node
npm install --global yarn
yarn install
```

## Running the Rails app

Run the following in order to run the rails app:

```
bin/dev
```

This will run both the frontend and the backend at the same time by using a library called foreman. The list of commands that will be run are stored in Procfile.dev

You can now head over to `http://localhost:3000/` to start playing around with the app.

## Running tests

To run the test suite run:

```
rspec
```
