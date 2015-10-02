## Jackhuahua.com

Community for Jack Russell/Chihuahua mix owners to share their dogs and get to
know each other. Built on
[Ruby on Rails][RoR]

### How to use:

Install needed gem and packages
```
  $ bundle install
  $ bower install
```

Additionaly, if you want a working dev environment
```
  $ rake db:migrate
  $ rake db:seed
```

Then start server
```
  $ rails server
```

### Features includes:

+ user accounts through Devise with Facebook login through OmniAuth, 
+ photo galleries with multiple image uploads and storage on S3,
+ fully responsive design with Bootstrap theme,
+ forums for discussion,
+ event organizing for meeting,
+ commenting powered by Disqus,
+ pretty URLs for user's profile pages through the [friendly_id][gemFriendlyId]
 gem.

## [Website][Website]

[RoR]: http://rubyonrails.org
[Website]: https://jackhuahua.herokuapp.com/
[gemFriendlyId]: https://github.com/norman/friendly_id
