![Simulator Screen Shot - iPhone 13 - 2022-05-04 at 22 18 00](https://user-images.githubusercontent.com/53842271/166875621-4fa92a92-feca-4f6b-9c8f-0014f00758c9.png)
![Simulator Screen Shot - iPhone 13 - 2022-05-04 at 22 20 35](https://user-images.githubusercontent.com/53842271/166875624-c2ed01ee-1d6b-4c31-8735-04b87496bef7.png)
![Simulator Screen Shot - iPhone 13 - 2022-05-04 at 22 21 40](https://user-images.githubusercontent.com/53842271/166875625-e8e93228-10fe-499d-a606-e2030224c0f5.png)
![Simulator Screen Shot - iPhone 13 - 2022-05-04 at 23 56 27](https://user-images.githubusercontent.com/53842271/166875628-c1871332-8ecc-4093-8acd-74a2af074f27.png)
![Simulator Screen Shot - iPhone 13 - 2022-05-04 at 23 57 03](https://user-images.githubusercontent.com/53842271/166875640-96532060-d0c7-4a99-a24d-c014f7552c50.png)
![Simulator Screen Shot - iPhone 13 - 2022-05-04 at 23 57 11](https://user-images.githubusercontent.com/53842271/166875642-49fea9af-537e-4603-b95e-358612fd9e0f.png)
**Picnic**


Team Lead: Hunter Krasa

API Expert: Adam Trafecanty

Styling and Messaging Guru: Makena Robison



Picnic is a new dating app geared towards young adults looking to find love and meet new people. 
These individuals are more focused on casual meet-ups and need a way to facilitate conversation 
with others like them. 



Picnic is mainly composed of three different views: the swipe view, the message view, and the settings view.

**Swipe View**

The swipe view is where users can look at each other's profiles and either "like" or "dislike" them. If you and 
another user like each other, you will be able to message them in the message view. The swipe view is organized 
by cards which show each user's name, bio, and picture.


**Message View**

The message view is where users who are matched (each of them liked each other) can chat! New matches that haven't 
been contacted yet are shown at the top, while matches that have been contacted are displayed in a list right below,
showing their picture and name. Upon clicking, you can send and receieve messages using the text editor or send a
random pickup line from https://getpickuplines.herokuapp.com, our pickup line API. 


**Settings View**

Settings view contains all of the settings for our app, which is fairly bare-bones. You can see your profile picture,
email, and view or edit your bio. In addition, you are also able to sign out of the app, which will bring you back to
the main sign in page. 


**Highlights**

Making the swipe view was a lot of fun and while it ended up being challenging, the final result was really cool!
Picture integration was also really cool and learning how to integrate that with firebase was a fun challenge.


**Lowlights**

Most of everything with the messages ended up taking really long and was incredibly unintuitive. Storing objects or 
eventually arrays inside of dictionaries took longer than it should have and was perpetuated by stupid bugs 
(ie firebase mistaked the period in the email query as a signifier for a subfield of an object, which it wasn't).
