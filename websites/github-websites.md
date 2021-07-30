# Creating a (free!) personal website with github pages

This is a quick tutorial on personal websites hosted on github. Github allows each user to create a user page repository that will be hosted as a website at your-user-name.github.io

This will still be a git repository, so you can interract with it in the normal git way (version control, etc), but instead of just the classic repository visualisation on github, it will appear as a website too.

It's very quick and easy to get a first version of a website made, but maybe a little more involved to get something with a nice theme/layout that you like.

Note, I'm assuming you're working in a linux terminal, if not you can download a GUI client instead:

* https://desktop.github.com/

## 1. Create the web page repository

Making an empty website is easy. You may or may not have already done some of this...

1. Get a github account!

    * register on: https://github.com/

2. Follow the instructions at https://pages.github.com to generate your website repository

    * Go to GitHub and create a new public repository named username.github.io, where username is your username on GitHub.

    * clone the repository: 
    
    ```
    git clone https://github.com/username/username.github.io
    ```

    * Enter the project folder and add an index.html file:

    ```
    cd username.github.io
    echo "Hello World" > index.html
    ```

3. You now have the basis of your website. Open `index.html` in a web browser and you can see that its a bit... basic. But, at this stage you could already push it to github and make come online if you like.

    * Add, commit, and push your changes:

    ```
    git add --all
    git commit -m "Initial commit"
    git push -u origin main
    ```

    * You will now have a personal website live on github at: https://username.github.io


## 2. Make it look nice

Congratulations, you have a website! But its just an index page with no text  and it looks crap. How do we make it better?

 * Github pages are written in html, if you open up the `index.html` page, you can edit it yourself to your hearts content, push changes to the repository and it will be updated on github. This will obviously require some knowledge of writing html. If you're already an html wizard, just have fun, if not here are some resources:

    * http://www.w3schools.com/
    * http://www.htmldog.com/guides/html/beginner/
    * http://html.net/

"But I don't have the time or inclination to learn how to make a html webpage from scratch!"

 * Download a template - a quick google search will throw up tons of places to download free html website templates from, which will include the CSS to make it look fancy, e.g. https://www.css3templates.co.uk/templates.html
 * Do it with jekyll!


## 3. Websites with Jekyll

Jekyll is a Ruby Gem which is the engine behind GitHub pages - we can use Jekyll to more easily create a nice github website, combined with bundler to ensure the correct Ruby Gem versions are installed for your project. More info here: https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/

 1. You need to have Ruby installed
    ```
    sudo apt install ruby-full
    ```

 2. Install Jekyll and bundler (https://jekyllrb.com/docs/installation/)

    ```
    gem install jekyll bundler
    ```

 3. Navigate to your github website repository and create a jekyll site with the `jekyll new` command:
    ```
    jekyll new .
    ```

 4. Test the site locally with bundler. 

    * First run `bundle install` which will ensure that all of the correct Gems are installed (specified in the `gemfile` which was created by `jekyll new`):
    ```
    bundle install
    ```
    * Then run the jekyll site locally:
    ```
    bundle exec jekyll serve
    ```
    * Preview your website by navigating to http://localhost:4000 in a web browser


 5. Play around with it and maybe look in to using different jekyll themes for your website: https://pages.github.com/themes/

    * I cheated even more for my website by just forking a template from github: https://academicpages.github.io/


## Some examples for inspiration
(these are on github so if you like the layout, the code is all available for copying - find the code repositories for these websites at github.com/username/username.github.io replacing `username` with the github account name in the website url).

 * https://smithtp.github.io
 * https://ajhelmstetter.github.io/
 * https://tguillerme.github.io/
