# README
## Make a plan/list
- Figure out data structure
- Name of db ---> Wilder side
- Columns ---> name, cohort
- Schema ---> colun names, datatypes

Model ---> get a class --->migration --->schema

Routes

Controller Class

Test files --->install rspec

If something goes awry
- $ rails db:drop
- $ rails db:create
- $ rails db:migrate

# The API Stories
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go-ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

## Story: As a developer I can create an animal model in the database. An animal has the following information: common name, latin name, kingdom (mammal, insect, etc.).

https://github.com/learn-academy-2022-alpha/Syllabus/blob/main/rails/wildlife-tracker-challenge.md

https://github.com/learn-academy-2022-alpha/Syllabus/blob/main/rails/generate-resource.md

- $ rails new wilder_side -d postgresql -T
- $ cd wilder_side
- $ git checkout -b model
- $ rails db:create
- $ bundle add rspec-rails
- $ rails generate rspec:install
- $ rails server
- In a browser navigate to: http://localhost:3000
- $ rails generate resource Chicken name:string origin:string feature:string
- $ rails db:migrate
- In a browser navigate to: http://localhost:3000/rails/info/routes
- In wilder_side app: app/controllers/application_controller.rb, add the following to the method ----> skip_before_action :verify_authenticity_token

### Postman Entry--->it will make the request and test API
http verb ---> copy url from rails routes 

GET ---->   localhost:3000

Preview will show how the DOM looks

## Story: As the consumer of the API I can see all the animals in the database.
Hint: Make a few animals using Rails Console
https://github.com/learn-academy-2022-alpha/Syllabus/blob/main/rails/active-record-intro.md
- $ rails c
> Chicken.create name:"Dong Tao", origin:"Vietnam", feature:"legs as thick as a human's wrist"

> Chicken.create name:"Old English Pheasant Fowl", origin:"England", feature:"feathering used as camouflage"

> Chicken.create name:"La Fleche", origin:"France", feature:"V-shaped comb"

> Chicken.create name:"Scots Dumpy", origin:"Scotland", feature:"abnormally short legs"

### Go to method for backend
https://github.com/learn-academy-2022-alpha/Syllabus/blob/main/rails/fullstack.md

Chickens controller
```
  def index
    chickens = Chicken.all
    render json: chickens
  end
```
### In postman app: 
http verb ---> copy url from rails route 

GET ---->         localhost:3000/chickens

#### Body tab in postman
Pretty tab and JSON

## Story: As the consumer of the API I can update an animal in the database.
  ### controller
  ```
  def update
    one_chick = Chicken.find(params[:id])
    one_chick.update(chick_params)
    if one_chick.valid?
      render json: one_chick
    else
      render json: one_chick.errors
    end
  end

  private
  def chick_params
    <!-- model as a lowercase symbol with permitted attributes as symbols -->
    params.require(:chicken).permit(:name, :origin, :feature)
  end
```
### postman
 - Go to body tab that is right under the http verb, raw radio button, json drop down

Write the updated params
```
{
  "name": "La Fleche", 
  "origin": "France", 
  "feature": "V-shaped comb, devil chicken"
}
```
http verb ---> copy url from browser

PATCH --->       localhost:3000/chickens/3

## Story: As the consumer of the API I can destroy an animal in the database.
### Destroy method
```
  def destroy
    one_chick = Chicken.find(params[:id])
    if one_chick.destroy
      render json: one_chick
    else
      render json: one_chick.errors
    end
  end
```
### Postman
http verb ---> copy url from browser 
DELETE ---->      localhost:3000/chickens/3

Verify that entry is deleted
### In postman app: 
http verb ---> copy url from rails route

GET --->       localhost:3000/chickens

## Story: As the consumer of the API I can create a new animal in the database.

### Controller
```
  def create
    chick = Chicken.create(chick_params)
    if chick.valid?
      render json: chick
    else
      render json: chick.errors
    end
  end
```
  ### Postman
  ```
  {
    "name": "Onagadori", 
    "origin": "Japan", 
    "feature": "long tail feathers"
  }
```
http verb ---> copy url from browser

POST --->      localhost:3000/chickens

## Story: As the consumer of the API I can create a sighting of an animal with date (use the datetime datatype), a latitude, and a longitude.

Hint: An animal has_many sightings. (rails g resource Sighting animal_id:integer ...)
Hint: Datetime is written in Rails as “year-month-day hr:min:sec" (“2022-01-28 05:40:30")

https://github.com/learn-academy-2022-alpha/Syllabus/blob/main/rails/associations.md

### Association app/models
Chicken ----> has_many :sightings

Sighting ----> belongs_to :chicken

### Terminal command
- $ rails g resource Sighting date:datetime latitude:string longitude:string chicken_id:integer 
- rails db:migrate
- $ rails c
> rooster = Chicken.find 1

> rooster.sightings.create date:"2022-01-18 07:40:30", latitude:"14.0583N", longitude:"
108.2772E"

> hen = Chicken.find 4

> hen.sightings.create date:"2022-01-28 05:40:30", latitude:"36.7783N", longitude:"119.4179W"

> bird = Chicken.find 5

> bird.sightings.create date:"2022-01-28 05:40:30", latitude:"32.3547N", longitude:"89.3985W"

> Sighting.all

### CONTROLLER
```
def index
    sightings = Sighting.all
    render json: sightings
  end
```
### Postman
GET ---> http://localhost:3000/sightings

## Story: As the consumer of the API I can update an animal sighting in the database.
  ### controller
  ```
  def update
    one_sight = Sighting.find(params[:id])
    one_sight.update(sighting_params)
    if one_sight.valid?
      render json: one_sight
    else
      render json: one_sight.errors
    end
  end

  private
  def sighting_params
    <!-- model as a lowercase symbol with permitted attributes as symbols -->
    params.require(:sighting).permit(:date, :latitude, :longitude)
  end
```
### postman
 - Go to body tab, raw radio button, json drop down
```
{
  "date": "2022-01-28 05:40:30", 
  "latitude": "46.7783N", 
  "longitude": "93.3985W"
}
```
http verb ---> copy url from browser

PATCH ----->      localhost:3000/sightings/3

## Story: As the consumer of the API I can destroy an animal sighting in the database.

### controller
```
  def destroy
    one_sight = Sighting.find(params[:id])
    if one_sight.destroy
      render json: one_sight
    else
      render json: one_sight.errors
    end
  end
```
### postman
http verb ---> copy url from browser

DELETE   ---->     localhost:3000/sightings/3


## Story: As the consumer of the API, when I view a specific animal, I can also see a list sightings of that animal.
Hint: Checkout the Ruby on Rails API docs on how to include associations.

https://medium.com/@jodipruett/render-json-include-multiple-activerecord-associations-75f72ada3c26
```
  def show
    one_bird = Chicken.find(params[:id])
    render json: one_bird, include: [:sightings]
  end
```
Syllabus format
```
  def show
    one_bird = Chicken.find(params[:id])
    render json: one_bird.as_json(include: :sightings)
  end
```
## Story: As the consumer of the API, I can run a report to list all sightings during a given time period.
Hint: Your controller can look like this:
```
class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end
```
Remember to add the start_date and end_date to what is permitted in your strong parameters method. In Postman, you will want to utilize the params section to get the correct data. Also see Routes with Params .

https://ryanbigg.com/2016/03/working-with-date-ranges-in-active-record

> Sighting.where(date: "2021-01-01".."2022-01-01")

### postman
GET ----> http://localhost:3000/sightings?

Params  
  key ----> start_date, value ---> 2021/01/01

  key ----> end_date, value ---> 2022/01/01

Url becomes `http://localhost:3000/sightings?start_date=2021-01-18&end_date=2022-01-01`

# Stretch Challenges
Note: All of these stories should include the proper RSpec tests. Validations will require specs in spec/models, and the controller method will require specs in spec/requests.
https://github.com/learn-academy-2022-alpha/Syllabus/blob/main/rails/validations.md

## Story: As the consumer of the API, I want to see validation errors if a sighting doesn't include: latitude, longitude, or a date.

Similar steps as for the following question.

## Story: As the consumer of the API, I want to see validation errors if an animal doesn't include a common name, or a latin name.

### spec/models
chicken_spec.rb --->
```
require 'rails_helper'

RSpec.describe Chicken, type: :model do
  it 'is not valid without a name' do
    foghorn_leghorn = Chicken.create origin: 'Looney Tunes', feature: 'loud, fast talker and over-explanation'
    expect(foghorn_leghorn.errors[:name]).to_not be_empty
  end
end
```
- $ rspec spec/models/chicken_spec.rb

### app/models
chicken.rb --->
```
validates :name, presence: true
```
- $ rspec spec/models/chicken_spec.rb

### Repeat steps for additional columns
#### spec/models
- Add additional it methods
#### app/models
- Pass column name(s) on the validates line

## Story: As the consumer of the API, I want to see a validation error if the animals latin name matches exactly the common name.
https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations
```
validate :name_and_origin_cannot_be_equal, on: :create

  def name_and_origin_cannot_be_equal
    if name == origin
      errors.add(:name, "cannot be equal to origin")
    end
  end
```
## Story: As the consumer of the API, I want to see a validation error if the animals latin name or common name are not unique.
```
validates :name, :feature, uniqueness: true

  it 'is not allow duplicate names' do
    Chicken.create name: 'Foghorn Leghorn', origin: 'Looney Tunes', feature: 'loud, fast talker and over-explanation'
    foghorn_leghorn = Chicken.create name: 'Foghorn Leghorn', origin: 'Walt Diney', feature: 'aburd notion that the sky is falling'
    expect(foghorn_leghorn.errors[:name]).to_not be_empty
  end 
```
- Repeat for feature error

## Story: As the consumer, I want to see a status code of 422 when a post request can not be completed because of validation errors.
Check out Handling Errors in an API Application the Rails Way
- { message: "422 Unprocessable Entity" }

## Super Stretch Challenge
## Story: As the consumer of the API, I can submit sighting data along with a new animal in a single API call.
Hint: Look into accepts_nested_attributes_for
https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
- place with has_many association
```
accepts_nested_attributes_for
```
- $ rails c
> params = { chicken: {name: 'Cluck Buck', origin:'Walt Disney', feature:
'Father of Chicken Little', sightings_attributes: [ {date:'2022-04-02', latitude:'45
.4545N', longitude:'90.9090E'} ] }}

> chick = Chicken.create(params[:chicken])

> chick.sightings

### postman
- First attempt

```
{ 
    "chicken": 
        {
            "name": "Hei Hei", 
            "origin": "Walt Disney", 
            "feature": "accident prone rooster", 
            "sightings_attributes": 
                [ 
                    {
                        "date": "2021-04-02", 
                        "latitude": "48.4545N", 
                        "longitude": "96.9090E"
                    }
                ] 
        }
}
```

- Produced a chicken entry with a blank sighting
```
{
    "id": 23,
    "name": "Hei Hei",
    "origin": "Walt Disney",
    "feature": "accident prone rooster",
    "created_at": "2022-04-03T04:18:36.587Z",
    "updated_at": "2022-04-03T04:18:36.587Z",
    "sightings": []
}
```

- If there is a chicken without a sighting

POST ----> http://localhost:3000/sightings
```
{
    "date": "2021-04-02", 
    "latitude": "48.4545N", 
    "longitude": "96.9090E",
    "chicken_id": 23
}
```
GET -----> http://localhost:3000/chickens/23

- Woohoo! Found a way to pass the nested attributes of sightings with a chicken entry

https://rubydoc.info/gems/strong_parameters
### controller, strong params
```
  private
  def chick_params
    params.require(:chicken).permit(:name, :origin, :feature, :sightings_attributes => [ :date, :latitude, :longitude ])
  end
```
### Postman

POST ----> http://localhost:3000/chickens
```
{ 
    "chicken": 
        {
            "name": "Funky Chicken", 
            "origin": "Dance", 
            "feature": "sweating while flapping arms", 
            "sightings_attributes": 
                [ 
                    {
                        "date": "2021-04-02", 
                        "latitude": "38.9045N", 
                        "longitude": "90.3890E"
                    }
                ] 
        }
}
```







## ******Additional notes
## Follow 7 restful routes

### Backend cares about data
- Index - shows all data
- Create - posts new data
- Show - shows one data
- Update - modifies data
- Destroy - removes data

### Front end does not
- New - shows a form
- Edit - shows a form

@ instance is a view, we will not need that structure

## Go to method for backend
- render json so that the data will appear in postman
- Create - need strong params, private so info does not get called outside the class, give conditional that shows error message
- Update - modifies data(similar to show and create)
- Destroy - removes data...does not return boolean value does not need ? catchall
- Make sure server is running
- Postman Entry---it will make the request
- http verb ---> copy url from browser 
- Preview will show how the DOM looks
- Get the convention for the route
- controller method--->follow the rails route
- Body, Pretty tab and JSON
- id, created_at, updated_at ----> handled by rails. Just update the other attributes
- RAILS DOES NOT DELETE PRIMARY KEYS. It will assign the next number to new entries.
