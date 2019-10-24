# Trivial Tube Quiz

How well do you think you know the London Underground? 
The Trivial Tube Quiz will put your Tube knowledge to the test. 

![demogif](https://s3.gifyu.com/images/Demogif.gif)

:train: Mind the Gap! :train:

&nbsp;

## Getting Started

These instructions will get you a copy of the project up and running on your local machine so you can play to your heart's content!

&nbsp;

### Prerequisites

An installation of ruby.

Install ruby if you don't have it already on your system -- https://www.ruby-lang.org/en/documentation/installation/

You can check if ruby is installed and if so which version. Type the following into your terminal:

```
ruby -v
```

might output something like...

```
ruby 2.6.1p33 (2019-01-30 revision 66950) [x86_64-darwin16]
```

&nbsp;

### Installing the Game

These are the steps which allow you to get up and running with the game.


**Step 0** -- Visit the Project URL: https://github.com/Liko/trivial-tube-quiz

**Step 1** -- Download As Zip Archive
![image of downloadzip](https://i.ibb.co/QcfhqQK/2.png)

**Step 2** -- Move the Zip Archive to your preferred directory
!image of downloads folder
![image of folder](https://i.ibb.co/SxfCp2M/3.png)

**Step 3** -- Open the Terminal and navigate to your chosen directory

```
cd /Users/Liko/Downloads/trivial-tube-quiz-master
```

**Step 4** -- Once you are here, run the following commands:


```
bundle install
```
This makes sure all dependencies in the Gemfile are available to your application.

```
rake db:migrate
rake db:seed
```
These commands create the database schema and populate the details of the London Undeground.

```
ruby bin/run.rb
bundle exec ruby bin/run.rb
```
Run the first command to play the game! If there are errors, try the second command with `bundle exec` prepended. 

![main-menu](https://i.ibb.co/PZMy0Q8/Welcome-Menu.png)

**Step 5** -- Test your knowledge, and top the leaderboards!

&nbsp;
![leaderboard-image](https://i.ibb.co/7yZCyzx/Leaderboard-Screen.png)


&nbsp;

## Authors

**Caroline Seilern** - [GitHub](https://github.com/cseiasp)

**Li Xie** - [GitHub](https://github.com/Liko)

See also the list of all [contributors](https://github.com/Liko/trivial-tube-quiz/contributors) who participated in this project.


&nbsp;
## License

See the LICENSE.md file for details.