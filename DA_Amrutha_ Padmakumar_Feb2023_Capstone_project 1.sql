-- TASK.1 Display the full names of actors
use sakila;
select concat(first_name," ",last_name) as full_name from actor;
select * from actor;


-- TASK.2i Display number of  times each first_name appears
select first_name,count(first_name) as count from actor group by first_name;
-- TASK.2ii count of actors that have unique first_name
create view view_3 as
select first_name,count(*) as unique_first_name from actor group by first_name having unique_first_name=1;
select * from view_3;
select count(first_name) from view_3;


-- TASK.3i Display number of  times each last_name appears
select last_name,count(last_name) as count from actor group by last_name;
-- TASK.3ii count of actors that have unique last_name
select last_name,count(*) as unique_last_name from actor group by last_name having unique_last_name=1;
 
 
 -- TASK.4i List of records for the movies with rating R
 select * from film where rating= "R";
 -- TASK.4ii List of records for the movies that are not rated R
 select * from film where rating!= "R";
 -- TASK.4iii Diaplay the records of the movies that are suitable for audience below age 13
 select * from film where rating="PG"or rating="PG-13" or rating="G";
 
 
 -- TASK.5i Display the records for the movies where replacement cost is upto 11$
 select * from film where replacement_cost<=11;
 -- TASK.5ii Display the records for the movies where replacement cost is between 11$ and 20$
 select * from film where replacement_cost between 11  and 20;
 -- TASK.5ii Display the records of all movies in descending order of their replacement cost
 select * from film order by replacement_cost desc;
 
 
 -- TASK.6 Display the names of top 3 movies with greatest number of actors
 select *  from film;
 select *  from film_actor;
 select film.title,count(film_actor.actor_id) as actor_count from film 
 inner join film_actor on film.film_id=film_actor.film_id 
 group by film.film_id order by actor_count desc limit 3;
 
 -- TASK.7 Display the titles of movies starting with K and Q
 select title from film where title like "K%" or title like "Q%";
 
 
 -- TASK.8 Display the names of all actors who appeared in the film agent truman
   select *  from actor;
  select actor.first_name,actor.last_name from film inner join film_actor on film.film_id= film_actor.actor_id
  inner join actor on actor.actor_id=film_actor.actor_id group by film.film_id;
  
  
  -- TASK.9 Identify all the movies categorized as family movies
  select * from film_category;
  select * from category;
  select * from film;
  select film.title from film_category inner join category on category.category_id= film_category.category_id
  inner join film on film.film_id=film_category.film_id
  where category.name="Family";
  
  
  -- TASK.10i Display min, max ,avg of rental_rates of movies based on movie rating
  select rating, min(rental_rate)as minimum ,max(rental_rate)as maximum,avg(rental_rate) as average
  from film group by rating order by average desc;
  
  -- TASK.10ii Display movies in descending order of their rental frequencies
 select * from inventory;
select film.title, count(rental_id) as rental_count from rental
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
group by film.film_id order by rental_count desc;

  
  
  -- TASK.11 list of film category along with average film rental cost and average film rental rate
  select  category.name as category_name,film.rental_rate,  film.replacement_cost from film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id= category.category_id;

create view view_1 as
select  category.name as category_name,film.rental_rate,  film.replacement_cost from film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id= category.category_id;
create view view_2 as
select category_name ,avg(replacement_cost)as avg_replacement_cost,avg(rental_rate) as avg_rental_rate, avg(replacement_cost-rental_rate)as avg_difference  from view_1
group by category_name having avg_difference>15;
select count(category_name) from view_2;
select category_name,avg_replacement_cost,avg_rental_rate from view_2;




-- TASK.12 Display the film categories in which number of movies is greater than 70
select category.name,count(film_category.film_id) as no_of_movies from category
inner join film_category on category.category_id = film_category.category_id group by category.name
having no_of_movies>70;
