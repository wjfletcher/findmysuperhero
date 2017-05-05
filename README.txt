Find My Superhero

This is an app built for my Skedaddle interview process. It links the 15 most
popular superheroes to a set of given coordinates which is then saved to a redis
database. You can then search for heroes near a specific location using coordinates
or google autocomplete.

To set up this app, save the app to your computer. You then need to run "bundle install"
and "npm install" for the rails and react dependancies respectively. then you have
to start a rails server with "rails s", then in another terminal tab start a node server
with "npm start" and finally a redis server with "redis-server". Open up a browser tab
and point it to "localhost:3000" to see the app!

The initial setup of the redis database takes a while because I had to make 15 api calls
in order to get all the superheroes so that I could then sort by the most popular.
Once that is done though, the app runs much quicker.

Please let me know if there are any problems with setup.



Original Challenge Prompt:

Use the marvel API to save the world!

1. Retrieve the 15 most popular super heroes based on the amount of comics they have appeared in

2. Sort the heroes in descending order

3. Given this hash of cities,

{

"NYC" => [40.730610, -73.935242],

"Boston" => [42.364506, -71.038887],

"DC" => [38.894207, -77.035507],

"Chicago" => [41.881832, -87.623177],

"Indianapolis" => [39.832081, -86.145454],

"LA" => [34.052235, -118.243683],

"SF" => [37.733795, -122.446747],

"Dallas" => [32.897480, -97.040443],

"Denver" => [39.742043, -104.991531],

"Seattle" => [47.608013, -122.335167],

"New Orleans" => [29.951065, -90.071533],

"Orlando" => [28.538336, -81.379234],

"Baltimore" => [39.299236, -76.609383],

"Minneapolis" => [44.986656, -93.258133],

"Cleveland" => [41.505493, -81.681290]

}

assign the locations to the heroes in order and add them to redis using GEOADD. Redis (https://redis.io/) is an in memory data store commonly used as a cache system. It's a very powerful tool that we are just starting to explore at Skedaddle. This may require some installation.

4. Magneto is wreaking havoc in Boston! find the heroes that are within 500 miles of Boston (sorted by closest)!

5. Bonus: By implementing a simple UI, give the user the ability to input any coordinates or location (google maps autocomplete) and see which of the top 15 superheros are nearest.
