<cfcomponent displayName="ScreenshotsCloud component" output="false">
	<cffunction
		access="private"
		name="encodeURIComponent"
		output="false"
		returntype="string"
	>
		<cfargument
			name="stringToEncode"
			type="string"
			required="yes"
		>

		<cfscript>
			variables.encodedString = arguments.stringToEncode;
			variables.encodedString = replace( variables.encodedString, "!", "%21", "all" );
			variables.encodedString = replace( variables.encodedString, "*", "%2A", "all" );
			variables.encodedString = replace( variables.encodedString, "##", "%23", "all" );
			variables.encodedString = replace( variables.encodedString, "$", "%24", "all" );
			variables.encodedString = replace( variables.encodedString, "%", "%25", "all" );
			variables.encodedString = replace( variables.encodedString, "&", "%26", "all" );
			variables.encodedString = replace( variables.encodedString, "'", "%27", "all" );
			variables.encodedString = replace( variables.encodedString, "(", "%28", "all" );
			variables.encodedString = replace( variables.encodedString, ")", "%29", "all" );
			variables.encodedString = replace( variables.encodedString, "@", "%40", "all" );
			variables.encodedString = replace( variables.encodedString, "/", "%2F", "all" );
			variables.encodedString = replace( variables.encodedString, "^", "%5E", "all" );
			variables.encodedString = replace( variables.encodedString, "~", "%7E", "all" );
			variables.encodedString = replace( variables.encodedString, "{", "%7B", "all" );
			variables.encodedString = replace( variables.encodedString, "}", "%7D", "all" );
			variables.encodedString = replace( variables.encodedString, "[", "%5B", "all" );
			variables.encodedString = replace( variables.encodedString, "]", "%5D", "all" );
			variables.encodedString = replace( variables.encodedString, "=", "%3D", "all" );
			variables.encodedString = replace( variables.encodedString, ":", "%3A", "all" );
			variables.encodedString = replace( variables.encodedString, ",", "%2C", "all" );
			variables.encodedString = replace( variables.encodedString, ";", "%3B", "all" );
			variables.encodedString = replace( variables.encodedString, "?", "%3F", "all" );
			variables.encodedString = replace( variables.encodedString, "+", "%2B", "all" );
			variables.encodedString = replace( variables.encodedString, "\", "%5C", "all" );
			variables.encodedString = replace( variables.encodedString, '"', "%22", "all" );
			return variables.encodedString;
		</cfscript>
	</cffunction>
	<cffunction
		name="parameterString"
		access="private"
		output="false"
		returnType="string"
	>
		<cfargument name="options" required="true" type="struct" />
		<cfscript>
			var myParameters = "";

			// Create a named function that takes two arguments as key and value
			function getValues(key, value) {
				myParameters = myParameters & LCase(key) & "=" & encodeURIComponent(value) & "&";
			}

			// Run StructEach with the named function getValues
			structEach(options, getValues);
		</cfscript>
		<cfreturn Left(myParameters, len(myParameters)-1) />
	</cffunction>
    <cffunction name="screenshotUrl" access="remote" output="false" returnType="string">
        <cfargument name="apiKey" required="true" type="string" />
		<cfargument name="apiSecret" required="true" type="string" />
		<cfargument name="options" required="true" type="struct" />
		<cfset parameters = parameterString(options) />
		<cfset generatedToken = LCase(hmac(parameters, arguments.apiSecret, "HMACSHA1")) />
        <cfreturn "https://api.screenshots.cloud/v1/screenshot/" & arguments.apiKey & "/" & generatedToken & "/?" & parameters />
    </cffunction>
</cfcomponent>