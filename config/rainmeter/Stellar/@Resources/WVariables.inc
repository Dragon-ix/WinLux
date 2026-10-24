[Variables]

; You must use location Latitude and Longitude.
; Websites to get the latitude / longitude are:
; https://www.latlong.net/
; https://www.mapcoordinates.net

Latitude=26.938222
Longitude=75.760556
Location=Jaipur

;==================================================

; If another language is desired the correct code can be found at:
; https://admin.rainmeter.net/LanguageCodes.php
; For example, French as used in France would be Language=fr-FR

Language=en-US
;Language=fr-FR
;Language=hu-HU

;==================================================

; Units of measure. This must be one of the following lower case letters:
; e		This is "Imperial", using Fahrenheit for temperatures.
; m		This is "Metric", using Celsius for temperatures.
; h		This is "Hybrid", used primarily in the UK. Celsius for temperatures, but miles for distances.

Units=m
TempSymbol=C

;==================================================

; How often to update the weather information. Default and recommended is 600, which would be 10 minutes.

UpdateRate=600

;==================================================

; Don't change any below here.

APIKey=71f92ea9dd2f4790b92ea9dd2f779061
UserAgent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.0.0

CommonSubstitute='"':"","^null$":"","\\u002F":"/","\\u005C":"\","\\u003C":"<","\\u003E":">"
URLSite=https://api.weather.com/v3/aggcommon/v3-wx-observations-current;v3-wx-forecast-daily-15day;v3alertsHeadlines;v3-location-point?format=json&geocode=#Latitude#,#Longitude#&units=#Units#&language=#Language#&apiKey=#APIKey#
