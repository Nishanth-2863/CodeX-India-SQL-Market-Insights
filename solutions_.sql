select * from dim_cities;
select * from dim_respondents;
select * from fact_survey_responses;
/*

Demographic Insights (examples)
a. Who prefers energy drink more? (male/female/non-binary?)
b. Which age group prefers energy drinks more?
c. Which type of marketing reaches the most Youth (15-30)?
*/

select gender,count(gender) as pref_count from dim_respondents 
group by gender order by pref_count desc;

select age,count(age) as age_pref_count from dim_respondents
 group by age order by age_pref_count desc;
 
 select Marketing_channels,count(Marketing_channels) as marketing_reaches_count from dim_respondents dres
 join fact_survey_responses fsr on
 dres.respondent_id=fsr.Respondent_ID 
 where age ='19-30' or age='15-18'
 group by Marketing_channels order by marketing_reaches_count desc;

 /*
 Consumer Preferences:
a. What are the preferred ingredients of energy drinks among respondents?
b. What packaging preferences do respondents have for energy drinks?
*/
select Ingredients_expected,count(Ingredients_expected) as pref_ingredi_count from fact_survey_responses
group by Ingredients_expected order by 
pref_ingredi_count desc;

select Packaging_preference,count(Packaging_preference) from fact_survey_responses
group by Packaging_preference;
/*
Competition Analysis:
a. Who are the current market leaders?
b. What are the primary reasons consumers prefer those brands over ours?
*/
select Current_brands,count(Current_brands) as market_lead_cnt
 from fact_survey_responses group by Current_brands
 order by market_lead_cnt desc;

select Reasons_for_choosing_brands,count(Reasons_for_choosing_brands) as reason_count
from fact_survey_responses where Current_brands='CodeX'
 group by Reasons_for_choosing_brands 
 order by reason_count desc;
 /*
Marketing Channels and Brand Awareness:
a. Which marketing channel can be used to reach more customers?
b. How effective are different marketing strategies and channels in reaching our customers?
*/
select Marketing_channels,count(Marketing_channels) as reach_count
from fact_survey_responses group by Marketing_channels order by reach_count desc;
/*
Brand Penetration:
a. What do people think about our brand? (overall rating)
b. Which cities do we need to focus more on?
*/

select round(avg(Taste_experience),2) from fact_survey_responses where Current_brands='CodeX';

select dci.city,count(fsr.Respondent_ID) as response_count from dim_cities dci 
join dim_respondents dres on dci.City_ID=dres.City_ID
join fact_survey_responses fsr on fsr.Respondent_ID=dres.Respondent_ID  and Current_brands='CodeX'
group by dci.City order by response_count ;


/*
Purchase Behavior:
a. Where do respondents prefer to purchase energy drinks?
b. What are the typical consumption situations for energy drinks among respondents?
c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
*/

select Purchase_location,count(Purchase_location) as Purchase_pref_count 
from fact_survey_responses group by Purchase_location;

select  Typical_consumption_situations,count(Typical_consumption_situations) as consumption_reason_count
 from fact_survey_responses group by Typical_consumption_situations
 order by consumption_reason_count;

select Price_range,round(count(Price_range)/100,2) as price_range_pref_In_perc from fact_survey_responses
group by Price_range;

select  Limited_edition_packaging,round(count(Limited_edition_packaging)/100,2)
 from fact_survey_responses group by Limited_edition_packaging;
 
 /*
 7. Product Development
a. Which area of business should we focus more on our product development? (Branding/taste/availability)
*/
select Improvements_desired,count(Improvements_desired) as improvement_response_count
 from fact_survey_responses where current_brands='CodeX'
 group by Improvements_desired order by improvement_response_count desc;
 
 select Heard_before,count(Heard_before) 
 from fact_survey_responses where Current_brands='Codex'
 group by Heard_before;
 
 select Brand_perception,count(Brand_perception) perception_count from fact_survey_responses
 where Current_brands='CodeX' group by Brand_perception order by perception_count
 desc;
 

 /*
 Give 5 recommendations for CodeX (below are some samples)
● What immediate improvements can we bring to the product?
● What should be the ideal price of our product?
● What kind of marketing campaigns, offers, and discounts we can run?
● Who can be a brand ambassador, and why?
● Who should be our target audience, and why?
*/
select Price_range,round(count(Price_range)/100,2) as price_expectation_count from fact_survey_responses
 group by Price_range;
 
 select Reasons_preventing_trying,count(Reasons_preventing_trying) as response_count
 from fact_survey_responses Where Current_brands='CodeX' group by Reasons_preventing_trying
 order by response_count desc;
 
 /*
 City-wise Brand Awareness:
a. What is the level of brand awareness for CodeX's energy drink in each city?

 */
select  City,Heard_before,count(Heard_before) as Yes_count from dim_respondents dres 
join dim_cities dc on dres.City_ID=dc.City_ID
join fact_survey_responses fsr on dres.Respondent_ID=fsr.Respondent_ID AND Heard_before='yes'
where Current_brands='CodeX' group by city,Heard_before order by Yes_count desc;
/*
"What are the top cities in terms of energy drink consumption, 
and how many respondents in each city have consumed energy drinks?"
*/
select city,count(Respondent_ID) as energy_drink_consume_count from dim_cities dic
join dim_respondents dres on dic.City_ID=dres.City_ID
group by city order by energy_drink_consume_count desc;

/*
"What is the frequency of energy drink consumption among different age groups?"

*/

select Consume_frequency,count(Consume_frequency) as consume_count from fact_survey_responses
group by Consume_frequency order by consume_count desc

