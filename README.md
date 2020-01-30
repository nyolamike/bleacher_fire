# Bleacher Fire
A phoenix-based microservice that maintains an in-memory cache of users who have reacted to content in the Bleacher Report app by selecting or deselecting the 'fire' icon

# Assumptions
The demo application has been split into a web phoenix app and three micoservices  
The architecture is only to demostrate the SOLID principle of microservices, that is to break apart business logic into single responsiblity tasks.  
We have the following taks to accomplish  
    1. A web interface to display data and capture user interactions (Phoenix Web App)  
    2. A services to store in mememory user reactions to bleacher content  
    3. A dashboard service to keep count/Statistics of the reactions  
    4. A user bound service to keep track of users and their reactions 

There is a one way data flow so that operations on data have to be from one source of truth.  
That is:  
    * on create:   ` web -> bleacher_server -> [dasboard_server, user_server] `  
    * on delete:   ` web -> bleacher_server -> [dasboard_server, user_server] `  
    * on count:    ` web -> dasboard_server `  
    * on users reactions: ` web -> user_server `  
This coupled with data indexing also ensures atomic operations on the data  



# Tests  
The approach was to use a test driven developement approach to guide the developement to have  
some degree of confidence and to reason about the quality of the code but also to set a stage  
for setting up a CI/CD in future.  
Most of the tests are for the micoservices  
To run test for the **bleacher_server** service  
`cd bleacher_server `  
`mix test`  


# Folder/Directoy Structure
**bleacher_fire:**   
    is the phoenix mvc web application that the user interacts with  
**bleacher_server**  
    This is a services that is going to store and also delete reactions from users
    That is the only purpose of this service
    Internally it uses the Agent API to have in memory cache of a map of reactions  
    Ractions are stores as a key-value pair map, where  
        the key is that content_id   
        the value is also a map where the key is the user_id and the value is the reaction map   
    Indexing data like this makes reads and writes very straight forward and very fast.   
**dashboard_server**    
    This is a service to truck application statistics like the count of reactions of a content  
    This could have been done in the bleacher_server service but we want to demostrate role distrbution  
    Besides having the  bleacher_server keep statistics and reports would increase latency  
**users_server**  
    This is a service to truck users and their reactions, just the content id  
    To keep unique reactions, this service will first be called to check if a user  
    has already reacted to the content  
**Screen Shoots**
    This folder contains screen shoots of the while is production  

# Sample Sytem Walk Through And Explanations In 9 steps  
**1. Signup**  
    This page allows the user to enter an email address, which will be used as the users id in the system.  
    There is no end point in the system for user registration so we keep the user_id on the ui untill the user reacts to a post   

    ![ScreenShot](/ScreenShoots/1_signin_page.png)  

**2. Viewing Bleacher Posts Without Signing in**  
    When the reactions tab is selected with out first signning in, there is an error message message that instructs you to signin.  
    Also if you are not signed in and you try to react to a post, an alert will be displayed to remind you to signin

    ![ScreenShot](/ScreenShoots/2_reactions_page_no_user.png) 

**3. Go To Sign In And Then Click The Reactions Tab**  
    This is display your name in the corner.  
    Its going to load hard corded posts from the `Reactions Controller`  
    Your reaction status for these posts are loaded from the `users_server Microservice`
    If you previouly reacted to a post and didnot unreact then a fire icon is shown on that post  
        
    ![ScreenShot](/ScreenShoots/3_reactions_page_clean.png)   

**4. Select One Of The Posts To Load Its Details**  
    The number of reactions for this post are loaded via Ajax when the page loads.  
    The end point is `/reaction_counts/:content_id`, the controller will use the `dashboard_server Microservice` for this.  
    The `users_server Microservice` is used to indicate if you have a reaction to this post or not  
    In case you have no reaction a react button with a fire icon is rendered.  
    In the even that you already have a reaction, a unreact button is rendered.  

    ![ScreenShot](/ScreenShoots/4_reactions_page_select_post.png)   


**5. Click The React Button To Post A Reaction**  
    An ajax http Json post is made to the end point `/reaction`.  
    The `reactions_server Microservice` is passed a message to store the post in cache.
    The `users_server Microservice` is told to register the user and his content_id reacted to if its not alredy there.    
    The `dashboard_server Microservice` is passed a message to increament the counts of posts for this content.  
    The react button is removed and an unreact button is rendered.  
    When one presses the unreact button, an ajax request is sent to same end point to reverse the effects.  
    Each time the page reloads to reconstruct the page with valid states of affairs.  

    ![ScreenShot](/ScreenShoots/5_reactions_page_after_reacting.png)  


**6. This displays statistics of data**  
    Mainly the `dashboard_server Microservice` is used to provide reaction counts and also fill the table.  
    The `users_server Microservice` provides data to get the number of users so far.  

    ![ScreenShot](/ScreenShoots/6_dashboard.png)  


**7. The users list and what they reacted to**  
    The `users_server Microservice` is the main source of info for this.  

    ![ScreenShot](/ScreenShoots/7_users.png) 


 **8. The Architecture Simplified**  
    The diagram shows a simplified breakdwon of the microservices and how they are talking to eacg other.  
    The three microservices never talk to each other because i want to use the phoenix web app to monitor evy one.
    And also to reduce interdepencies and cyclic references.  

    ![ScreenShot](/ScreenShoots/8_architecture.png)  

**9. The Unit Tests**  
    This shows the tests that were written to ensure good code quality and follow goood practices like TDD.  
    To run the tests one need to `cd [root of service direcrion]`, then run `$ mix tests `  

    ![ScreenShot](/ScreenShoots/9_tests.png)  

    








