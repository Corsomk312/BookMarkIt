#Bookmark It! Web app & Chrome extension
###by Kevin Corso, Jacob Crofts, Ronny Ewanek & Lars Johnson
#### Dev Bootcamp, February 5, 2016
<br>
We presented The Bookmark It! web app and Chrome extension as the result of our 8 day final project for Dev Bootcamp in Chicago, IL. The goal of our project was to learn as much as possible about a handful of programming technologies that were new to all of us by implementing a bookmark sharing and visualization website.

We had a great time working on this and while we are all proud of the results so far, it is still very much a work in progress (hence this fork). In fact, we have plans to refactor and improve on the original product in many ways. If you are interested in learning more or taking this further in any direction, we encourage you to fork this repository and get in touch with us.

**Core technologies:**

- Ruby
- JavaScript
- Ruby on Rails
- Nokogiri
- Twitter Bootstrap

**Technologies that were new to us:**
- WebGL
- Three.js
- Phantomjs
- Redis
- Sidekiq
- Amazon S3
- Google Chrome APIs

**Installation and setup of the application**

1. Create a new file called **.env** in the project's root directory.
2. Store **your own** Amazon S3 credentials as environment variables in the **.env** file like this:

  ```
  S3_BUCKET_NAME=yourbucketnamegoeshere
  AWS_ACCESS_KEY_ID=yourawsaccesskeyidgoeshere
  AWS_SECRET_ACCESS_KEY=yourawssecretaccesskeygoeshere
  ```

3. **BE SURE to include .env in your .gitignore file** and NEVER push, post or share the above credentials.
4. Run **```Bundle Install```** from the command line.
5. If it's not already on your system, install **Redis** which works with Sidekiq to manage background tasks.

**Running the application**

First open at least 3 terminal windows and start each server as follows:

  ```
  redis-server
  be sidekiq
  rails server
  ```

To launch the application, direct your web browser to **```http://localhost:3000```**

**Stopping the application**

- Hit ```control-c``` in each of the 3 server windows to stop all 3 servers

- You may also wish to kill any background tasks which may have been queued up by flushing Redis.

**Installing the Chrome Extension**

1. Open Google Chrome and navigate to ```chrome://extensions```
2. Drag and drop the file ext/bookmarkextension.crx into Chrome
3. After a few seconds a dialog box will appear to add the extension

**Original Chrome Extension source code:**
  - https://github.com/Corsomk312/BookMarketExtension

**Original 8-Day Final Project results:**
  - https://github.com/Corsomk312/BookMarkIt

**Bookmark It! Subsequent development fork**
  - https://github.com/larsjx/BookmarkIt-fork