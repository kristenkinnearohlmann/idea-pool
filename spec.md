# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app  
_I installed the recommended gems for Sinatra based on lesson work and video reviews._
- [x] Use ActiveRecord for storing information in a database  
_I installed ActiveRecord and ensured the models inherited from its Base class._
- [x] Include more than one model class (e.g. User, Post, Category)  
_I included models for User, Idea, Project, and IdeaProject to correlate to my application objects._
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)  
_User `has_many` ideas and projects._
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)  
_Both idea and project `belongs_to` user._
- [x] Include user accounts with unique login attribute (username or email)
_Users are identified by their email address._
- [ ] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [ ] Ensure that users can't modify content created by other users
- [x] Include user input validations  
_Validating form entries, authenticating password, model validation_
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)  
_Added Sinatra Flash to give messages on certain conditions, such as an existing user trying to create a new account when checked by email address_
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code  
_All items are included; I enjoyed crafting a contributor's guide which, while incomplete, starts to indicate what is desired in contributions._

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
