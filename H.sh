git add .
git commit -am "Default Push"
git push heroku master
heroku run rake db:migrate
#heroku run rails c
heroku logs --tail

