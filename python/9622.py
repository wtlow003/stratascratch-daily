"""
Difficulty: Easy
Company: Amazon
https://platform.stratascratch.com/coding-question?id=9622&python=1

Number Of Bathrooms And Bedrooms
Find the average number of bathrooms and bedrooms for each city’s property types.
Output the result along with the city name and the property type.

airbnb_search_details
id int64
price float64
property_type object
room_type object
amenities object
accommodates int64
bathrooms int64
bed_type object
cancellation_policy object
cleaning_fee bool
city object
host_identity_verified object
host_response_rate object
host_since datetime64[ns]
neighbourhood object
number_of_reviewsi nt64
review_scores_rating float64
zipcode int64
bedrooms int64
beds int64
"""

# Import your libraries
import pandas as pd

# Start writing code
output = airbnb_search_details.groupby(['city', 'property_type'])['bathrooms','bedrooms'].agg('mean').reset_index()

output.column = ['city', 'property_type', 'n_bedrooms_avg', 'n_bathrooms_avg']

output
