<html>
<head>
<title>ScreenshotsCloud Url Creation Example</title>
</head>
<body>
	<cfinvoke
		component="screenshotscloud"
		method="screenshotUrl"
		returnVariable="myScreenshotUrl"
	>
		<cfscript>
			Options = {};
		    Options.url = "bbc.com/news";
			Options.width = 1024;
		    Options.viewport_width = 1560;
		</cfscript>
	  	<cfinvokeargument name="apiKey" value="SCREENSHOTSCLOUD_KEY">
		<cfinvokeargument name="apiSecret" value="SCREENSHOTSCLOUD_SECRET">
		<cfinvokeargument name="options" value="#Options#">
	</cfinvoke>
	<cfoutput><a target="_blank" href="#myScreenshotUrl#">#myScreenshotUrl#</a></cfoutput>
</body>
</html>