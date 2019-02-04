# NewSpeak
[NewSpeak](https://www.thomasraddatz.com) makes navigating the news easier.  With over 20+ News outlets and 10,000+ articles, the application delivers up-to-date news every 15 minutes, allowing users to view articles from multiple angles. This project was undertaken to serve as a representation of my Ruby on Rails experience as well as its integrations with ELK, Docker, Digitial Ocean, and 3rd party APIs.  Several different technologies and techniques were employed to ensure that test driven development and agile methodologies could serve as the basis for this project. At the helm of this was Docker and RSpec. RSpec tests were written before any code was committed to their respective controllers, models or views. Ensuring that test driven development could guide the project. Docker was used to ensure a stable development environment, being employeed by pulling from the ruby, elasticsearch, logstash, and kibana Docker containers.

The Javascript library "Bricklayer.js" was used in order to deliver an interactive and comfortable user experience. However, the use of this library in combination with Turbolinks resulted in some unexpected edge case behaviors. This behavior was cased by Turbolinks initializing the `bricklayer = new Bricklayer(document.querySelector('.bricklayer'));` either before or after the `div class="bricklayer"` was created.  In research of this issue, two important truths were discovered:
```
1. On the initial page load, there are one pair of turbolinks:before-cache and turbolinks:load events that are executed.
2. On the initial page load and every subsequent page load, there are two pairs of turbolinks:before-render and turbolinks:render events
```
None of these events however could resolve the issue of destroying a bricklayer object before you leave the page and/or creating a new one after the `bricklayer` div was created, but not before.  To contain these issues, two methods were employed. [1] Turbolinks was disabled on bricklayer pages using the `content_for(:bricklayer)` tags in combination with `<meta name="turbolinks-cache-control" content="no-cache">` and yielding `:bricklayer` within its respective views. And [2] The bricklayer.js initialization variable was initialized after the `bricklayer` div was created, but before any data was populated within it.

Further, database methods were employed to demonstrate knowledge of the `.includes`, `.join`, and `.pluck`.  These methods are meant to serve as illustrations and are not meant to be premature optimizations.

## NewsAPI
[NewsAPI](https://newsapi.org/) was used to deliver consistent news articles to the PostgreSQL database. The API call and all subsequent actions to store articles and their respective outlets, were contained within the NewsManager Services model.  This service consists of 6 classes: NewsApiCaller, ArticleSaver, OutletSaver, DuplicateOutlet, DatabaseTransactor, and NewsRetriever. Each of these classes are meant to serve a single purpose.

## Infinite Scrolling
A prominent feature of NewSpeak is its infinite scrolling capability.  In other projects I have used the ```will_paginate``` gem to accomplish this, but the gems use of  ```.offset().limit()``` bogged down preformance and was considered unacceptable for this project. In lieu of this, I rolled my own preformance sharp infinite scrolling.  The article's model has a class method ```self.update_feed(published_at, limit_num)``` that accepts the last article's ```published_at``` timestamp as a parameter and will execute:
```
Article.includes(:outlet).where('articles.published_at < ?', published_at.to_datetime).limit(limit_num)
```
Returning articles to the calling controller.  This method removes performance problems caused by using ```offset``` and will only parse and return the desired amount of articles, without an 'N+1' query.

# Technologies Used
## Deployment
### Docker
Docker was used throughout the development cycle, from initially creating the application to eventually deploying the container on digital ocean.  I have become very familiar with Docker over the past year and feel very comfortable using it for small sized projects. This rails application uses two docker-compose and Dockerfiles, for development or production purposes.  The production version of these files incorporates an NGINX server, which is used to preprocess assets and handle requests.

### Digital Ocean
Docker deploys its container to Digital Ocean and creates a droplet.  For this project, only one droplet was used, but in the near future the project may expand to utilize multiple droplets and load balancers.  Digital Ocean was chosen over AWS because of its simple deployment and pricing plans.  

## Testing
### RSpec
Originally all test cases were written with minitest and capybara, but were eventually transported over to RSpec. All test cases are contained within the spec folder. RSpec was chosen for its ability to be written in a more functional manner and produce human readable output.

### Capybara
Prior to this application, I had no experience with Capybara.  Though it is not utilized heavily within the spec testing, it served its purpose as a learning tool and in the future I hope to expand test cases by running a headless chromedriver.

## Logging
### ELK Stack  
Logstash collects and parses logs, Elasticsearch indexes and stores the information, Kibana presents the data in visualizations that provide actionable insights into one’s environment. All data is sent to logstash through lograge, in order to keep logs simple and easy to understand.  Within the Kibana interface I have created several different types of visualizations to parse data: number of active users, guest users, errors recieved, and most frequent news outlets selected.

### Lograge
On their own, rails logs are pretty useless.  They contain a large amount of data and present it in an unreadable way.  To tame this, I use [Lograge](https://github.com/roidrage/lograge).  As an example, Lograge transforms the following rails log:
```
Started GET "/" for 127.0.0.1 at 2012-03-10 14:28:14 +0100
Processing by HomeController#index as HTML
  Rendered text template within layouts/application (0.0ms)
  Rendered layouts/_assets.html.erb (2.0ms)
  Rendered layouts/_top.html.erb (2.6ms)
  Rendered layouts/_about.html.erb (0.3ms)
  Rendered layouts/_google_analytics.html.erb (0.4ms)
Completed 200 OK in 79ms (Views: 78.8ms | ActiveRecord: 0.0ms)
```
into this single line:
```
method=GET path=/jobs/833552.json format=json controller=JobsController  action=show status=200 duration=58.33 view=40.43 db=15.26
```
In this format, the logs shown in Kibana are easy to read and visualize.

## Development
### ChronJobs
To deliver news content every 15 minutes, I created a cronjob that the production docker container runs.  This cronjob calls ```rails import:news``` from the rake tasks, to populate the database with new article data.  

### Turbolinks
In doing research for this project, it was clear to me that a misunderstandings of Turbolinks life cycle callbacks have spread widely across the rails community, and that often the accepted solution for turbolinks related problems is to disable its functionality. Considering its presence had a noticeable impact on performance and user experience, this solution was unacceptable to me.  However, it also had a noticeable impact on the Bricklayer.js, the java library used to display content.  The library requires that the bricklayer object be attached to the window after ```<div class="bricklayer">```   is created, but before any content is pushed into the div.  Unfortunately, using turbolinks ```:before-cache```, ```:before-render```, ```:render```, or ```:load``` events could not accomplish this. As a result, the initialization of bricklayer occurs in a javascript partial that is render in the bricklayer view class. Each bricklayer partial is stored within the '/views/bricklayer' folder and are called to create the bricklayer newsfeed as well as append to it.  

## Javascript Libraries
### Bricklayer.js
[Bricklayer](https://github.com/ademilter/bricklayer) is a responsive lightweight and independent cascading grid layout library.  It was chosen to allow articles to be easily appending or prepended to the DOM without worring about changes to the screen size or length of each card column. Furthermore, it appends articles to the DOM in a horizontal manner, placing newly appended cards next to one another, rather than below one another, as does Bootstrap 4 card-columns.

## About Section
NewSpeak makes navigating the news easier.  With over 20+ News outlets and 10,000+ articles, the application delivers up-to-date news every 15 minutes, allowing users to view articles from multiple angles. This project was undertaken to serve as a hardcopy of my Ruby on Rails experience as well as its integrations with ELK, Docker, Digitial Ocean, and 3rd party APIs.

A recent graduate of The College of William & Mary with a double major in Computer Science and Finance, I specialize in application and full-stack web development, with an interest in financial technology software. Throughout my four years at the College of William & Mary, I was an avid Ruby on Rails developer, building rails applications to compete in hack-a-thons and business competitions. Since graduating, I have continued my passion for web development with Ruby on Rails and in an effort to encapsulate some of my knowledge  into one project, I created “NewSpeak.”  

To learn more about my interest and experience download my resume. 
