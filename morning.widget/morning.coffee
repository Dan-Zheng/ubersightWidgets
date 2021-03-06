# Lovingly crafted by Rohan Likhite [rohanlikhite.com]
# Lovingly edited by Dan Zheng

command: "finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ // '"


#Refresh time (default: 1/2 minute 30000)
refreshFrequency: 30000


#Body Style
style: """
  
  color: #fff
  font-family: Helvetica Neue, Arial

  .container
   margin-top:5%
   margin-left:10%
   height:0px
   width:260px
   font-weight: lighter
   font-smoothing: antialiased
   text-align:left
   text-shadow:0px 0px 20px rgba(0,0,0,0.3);

  .time
   font-size: 4em
   color:#fff
   font-weight:800
   text-align:left  

  .half
   font-size: 0.3em
   margin-left: -5%

  .text
   font-size: 1.6em
   color:#fff
   font-weight:300  
   margin-top:-3%  

  .hour
   margin-right:2%

  .min
   margin-left:-4%

  .salutation
   margin-right:-3%
  
"""

#Render function
render: -> """
  <div class="container">
  <div class="time">
  <span class="hour"></span>:
  <span class="min"></span>
  <span class="half"></span>
  </div>
  <div class="text">
  <span class="salutation"></span>
  <span class="name"></span>
  </div>
  </div>
  
"""

  #Update function
update: (output, domEl) -> 

  #Options: (true/false)
  showAmPm = true; 
  showName = true; 
  militaryTime = false; #Military Time = 24 hour time 

  #Time Segmends for the day
  segments = ["morning", "afternoon", "evening", "night"]

  #Grab the name of the current user. 
  #If you would like to edit this, replace "output.split(' ')" with your name
  name = output.split(' ')


  #Creating a new Date object
  date = new Date()
  hour = date.getHours()
  minutes = date.getMinutes()

  #Quick and dirty fix for single digit minutes
  minutes = "0"+ minutes if minutes < 10

  #timeSegment logic
  timeSegment = segments[0] if 4 < hour <= 11
  timeSegment = segments[1] if 11 < hour <= 17
  timeSegment = segments[2] if 17 < hour <= 24
  timeSegment = segments[3] if  hour <= 4

  #AM/PM String logic
  if hour < 12
    half = "AM"  
  else
    half = "PM"

  #0 Hour fix
  hour= 12 if hour == 0;

  #24 - 12 Hour conversion
  hour= hour%12 if hour > 12 && !militaryTime



  
  
  #DOM manipulation 
  $(domEl).find('.salutation').text("Good #{timeSegment}")
  $(domEl).find('.name').text(" , #{name[0]}.") if showName
  $(domEl).find('.hour').text("#{hour}")
  $(domEl).find('.min').text("#{minutes}") 
  $(domEl).find('.half').text("#{half}") if showAmPm && !militaryTime

  

 
