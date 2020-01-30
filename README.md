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






